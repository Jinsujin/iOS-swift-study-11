//
//  Service.swift
//  Clima
//
//  Created by Sh Hong on 2021/09/03.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

class Service {
    let repository : Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    var weatherModel = WeatherModel(conditionID: 200, cityName: "Seoul", temperature: 0.0)
    
    func fetchNow(onCompleted: @escaping (Result<WeatherModel, MyError>) -> Void) {
        repository.fetchNow { result in
            switch result {
            case .success(let weatherdata):
                let id = weatherdata.weather[0].id
                let temp = weatherdata.main.temp
                let name = weatherdata.name
                
                self.weatherModel = WeatherModel(conditionID: id, cityName: name, temperature: temp)
                onCompleted(.success(self.weatherModel))
            case .failure(.error):
                onCompleted(.failure(.error))
                break
            }
      
        }
    }
    
    func fetchWeather(cityName: String) {
        repository.fetchWeather(cityName: cityName)
    }
    
    func fetchWeather(latitude: String, lognitude: String) {
        repository.fetchWeather(latitude: latitude, lognitude: lognitude)
    }
}
