//
//  Service.swift
//  Clima
//
//  Created by Sh Hong on 2021/09/03.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

class Service {
    let repository = Repository()
    
    var weatherModel : WeatherModel?
    
    func fetchNow(onCompleted: @escaping (WeatherModel) -> Void) {
        repository.fetchNow { weatherdata in
            let id = weatherdata.weather[0].id
            let temp = weatherdata.main.temp
            let name = weatherdata.name
            
            self.weatherModel = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            
            onCompleted(self.weatherModel!)
        }
    }
    
    func fetchWeather(cityName: String) {
        repository.fetchWeather(cityName: cityName)
    }
    
    func fetchWeather(latitude: String, lognitude: String) {
        repository.fetchWeather(latitude: latitude, lognitude: lognitude)
    }
}
