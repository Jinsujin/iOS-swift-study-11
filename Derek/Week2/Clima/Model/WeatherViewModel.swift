//
//  WeatherViewModel.swift
//  Clima
//
//  Created by Sh Hong on 2021/09/03.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewModel: ViewModelType {
    
    let service : Service

    struct Input {
        
    }
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    
    init(service: Service) {
        self.service = service
        
        self.input = Input()
        self.output = Output()
    }
    
    var onUpdate: () -> Void = {}
    
    var temperatureString: String?
    var cityName: String? {
        didSet {
            onUpdate()
        }
    }
    var conditionImageView: UIImage?
    
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
