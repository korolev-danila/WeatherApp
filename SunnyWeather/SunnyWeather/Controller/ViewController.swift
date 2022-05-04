//
//  ViewController.swift
//  SunnyWeather
//
//  Created by Данила on 28.04.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var networkWeatherManager = NetworkManager()
    
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    
    private var mainView: MainView! {
        guard isViewLoaded else { return nil }
        return (view as! MainView)
    }
    
    override func loadView() {
        self.view = MainView(frame: UIScreen.main.bounds)
        self.mainView.imageView.image = UIImage(systemName: "cloud.rain.fill")
        self.mainView.cityFindButton.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackImage()
        self.mainView.configure()
        
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            
            self.updateInterfaceWith(weather: currentWeather)
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        } else {
            networkWeatherManager.getLocationAndWeather(forCity: "Moscow")
        }
        
        self.mainView.cityFindButton.addTarget(self, action: #selector(findCity), for: .touchUpInside)
    }
    
    private func setBackImage() {
        let bgImage     = UIImage(named: "background.png")
        let imageView   = UIImageView(frame: self.view.bounds)
        imageView.image = bgImage
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }

    var cityTextIsEmpty = true
    
    @objc func findCity() {
        presentSearchAlertController(withTitle: "Enrer city name", message: nil, style: .alert) { [unowned self] city in
            self.networkWeatherManager.getLocationAndWeather(forCity: city)
            self.mainView.cityNameLabel.text = city
            self.cityTextIsEmpty = false
        }
    }
    
    func updateInterfaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async {
            if self.cityTextIsEmpty {
                self.mainView.cityNameLabel.text = weather.cityName
            } else {
                self.cityTextIsEmpty = true
            }

            self.mainView.temperatureLabel.text = weather.temperatureString
            self.mainView.feelsLikeTemperatureLabel.text = weather.feelsLikeTemperatureString
            self.mainView.imageView.image = UIImage(systemName: weather.systemIconNameString)
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        networkWeatherManager.fetchCurrentWeather(latitude: latitude, longitude: longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

