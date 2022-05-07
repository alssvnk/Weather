//
//  WeatherByHour.swift
//  Weather
//
//  Created by Alisiya on 7.05.22.
//

import Foundation

struct WeatherByHour {
    let timestamp: Double
    let state: WeatherState
    let temperature: Double
    
    init(weatherObject: WeatherHourResponse) {
        self.timestamp = weatherObject.timestamp
        self.state = WeatherState.init(rawValue: weatherObject.state) ?? WeatherState.another
        self.temperature = weatherObject.temp - 273.15
    }
}
