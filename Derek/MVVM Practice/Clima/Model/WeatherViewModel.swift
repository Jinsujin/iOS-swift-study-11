//
//  WeatherViewModel.swift
//  Clima
//
//  Created by Sh Hong on 2021/09/03.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewModel {
    
    let service = Service()
    
    var onUpdate: () -> Void = {}
    
    var conditionImageView: UIImage?
    var temperatureString: String?
    var cityName: String? {
        didSet {
            onUpdate()
        }
    }
    
    func reload() {
        service.fetchNow { [weak self] model in
            guard let self = self else { return }
            self.temperatureString = model.tempString
            self.cityName = model.cityName
            self.conditionImageView = UIImage(systemName: model.conditionName)
        }
    }
    
    func fetchWeather(cityName: String) {
        service.fetchWeather(cityName: cityName)
        reload()
    }
    
    func fetchWeather(latitude: CLLocationDegrees, lognitude: CLLocationDegrees) {
        service.fetchWeather(latitude: "\(latitude)", lognitude: "\(lognitude)")
        reload()
    }
    
}
