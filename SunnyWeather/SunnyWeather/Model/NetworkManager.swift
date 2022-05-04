//
//  NetworkManager.swift
//  SunnyWeather
//
//  Created by Данила on 29.04.2022.
//

import Foundation
import CoreLocation

class NetworkManager {
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    func getLocationAndWeather(forCity address: String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks else {
                print("error geoCoder")
                return
            }
            let lat = placemarks.first?.location?.coordinate.latitude
            let lon = placemarks.first?.location?.coordinate.longitude
            
            self.fetchCurrentWeather(latitude: lat!, longitude: lon!)
            print("\(lat!) and \(lon!)")
        }
    }
    
    func fetchCurrentWeather(latitude lat: CLLocationDegrees?, longitude lon: CLLocationDegrees?) {
        if lat != nil && lon != nil {
           let  latitude = lat!
           let  longitude = lon!
            
            print("\(latitude) and \(longitude) in URL")
            let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
            guard let url = URL(string: urlString) else { return }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    if let currentWeather = self.parseJSON(withData: data) {
                        self.onCompletion?(currentWeather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherDate = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherDate) else {
                return nil
            }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
