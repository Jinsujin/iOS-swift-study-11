//
//  WeatherViewModel.swift
//  Clima
//
//  Created by Sh Hong on 2021/09/03.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit

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
        service.fetchNow { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.temperatureString = model.tempString
                self.cityName = model.cityName
                self.conditionImageView = UIImage(systemName: model.conditionName)
                
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    func fetchWeather(cityName: String) {
        service.fetchWeather(cityName: cityName)
        reload()
    }
    
    func fetchWeather(latitude: String, lognitude: String) {
        service.fetchWeather(latitude: latitude, lognitude: lognitude)
        reload()
    }
    
}
