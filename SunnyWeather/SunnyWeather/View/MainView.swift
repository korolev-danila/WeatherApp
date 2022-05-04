//
//  View.swift
//  SunnyWeather
//
//  Created by Данила on 28.04.2022.
//

import Foundation
import UIKit

class MainView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "25"
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-Bold", size: 70)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let celsiusLabel: UILabel = {
        let label = UILabel()
        label.text = "°C"
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 70)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.text = "Feels like"
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let feelsLikeTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "25 °C"
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cityNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Moscow"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let buttonX: CGFloat = 46
    
    let cityFindButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.tintColor = .white
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - StackView
    
    let globalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.trailing
        stackView.spacing   = 4.0
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    let stackTemperatureView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let stackFeelsView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let stackFindView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 4.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    func configure(){
        
        setConstreints()
        
    }
    
    func setConstreints() {
        
        stackTemperatureView.addArrangedSubview(temperatureLabel)
        stackTemperatureView.addArrangedSubview(celsiusLabel)
        
        stackFeelsView.addArrangedSubview(feelsLikeLabel)
        stackFeelsView.addArrangedSubview(feelsLikeTemperatureLabel)
        
        stackFindView.addArrangedSubview(cityNameLabel)
        stackFindView.addArrangedSubview(cityFindButton)
        
        stackView.addArrangedSubview(stackTemperatureView)
        stackView.addArrangedSubview(stackFeelsView)
        
        globalStackView.addArrangedSubview(imageView)
        globalStackView.addArrangedSubview(stackView)
     
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height / 3),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height / 3)
        ])
        
        NSLayoutConstraint.activate([
            cityFindButton.heightAnchor.constraint(equalToConstant: buttonX),
            cityFindButton.widthAnchor.constraint(equalToConstant: buttonX)
        ])
        
        self.addSubview(globalStackView)
        NSLayoutConstraint.activate([
            globalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 64),
            globalStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
        ])
        
        self.addSubview(stackFindView)
        NSLayoutConstraint.activate([
            stackFindView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackFindView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32),
            stackFindView.heightAnchor.constraint(equalToConstant: 60),
            stackFindView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width / 2)
        ])
    }
    
}

