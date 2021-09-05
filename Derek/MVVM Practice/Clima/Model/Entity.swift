//
//  WeatherData.swift
//  Clima
//
//  Created by Sh Hong on 2021/09/01.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let weather: [Weather]
    let main: Main
}

struct Main: Codable {
    let temp : Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
}
