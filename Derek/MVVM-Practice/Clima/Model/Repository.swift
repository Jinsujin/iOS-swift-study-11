//
//  Repository.swift
//  Clima
//
//  Created by Sh Hong on 2021/09/03.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

class Repository {
        
    let baseURL = "https://api.openweathermap.org/data/2.5/weather?appid=221706d3365a1e354a40e045c80b7666&units=metric"
    var weatherURL : String?
    
    func fetchNow(onCompleted: @escaping (Result<WeatherData, MyError>) -> Void) {
        let urlString = weatherURL
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession(configuration: .default).dataTask(with: url) { data, response, error in
            guard error == nil else {
                onCompleted(.failure(.error))
                return }
            guard let safeData = data else {
                onCompleted(.failure(.error))
                return }
            guard let weather = try? JSONDecoder().decode(WeatherData.self, from: safeData) else {
                onCompleted(.failure(.error))
                return }
            
            onCompleted(.success(weather))
        }.resume()
    }
    
    func fetchWeather(cityName: String) {
        weatherURL = "\(baseURL)&q=\(cityName)"
    }
    
    func fetchWeather(latitude: String, lognitude: String) {
        weatherURL = "\(baseURL)&lat=\(latitude)&lon=\(lognitude)"
    }
    
}
