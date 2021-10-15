//
//  Repository.swift
//  Clima
//
//  Created by Sh Hong on 2021/09/03.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

class Repository {
    
    private var appID : String {
        get {
            // 생성한 .plist 파일 경로 불러오기
            guard let filePath = Bundle.main.path(forResource: "KeyList", ofType: "plist") else {
                fatalError("Couldn't find file 'KeyList.plist'.")
            }
            
            // .plist를 딕셔너리로 받아오기
            let plist = NSDictionary(contentsOfFile: filePath)
            
            // 딕셔너리에서 값 찾기
            guard let value = plist?.object(forKey: "appID") as? String else {
                fatalError("Couldn't find key 'OPENWEATHERMAP_KEY' in 'KeyList.plist'.")
            }
            return value
        }
    }
    
    lazy var baseURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(appID)&units=metric"
    var weatherURL = ""
    
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
