//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by Sh Hong on 2021/09/02.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weather: WeatherModel)
    func didFailWithError(error: Error)
}
