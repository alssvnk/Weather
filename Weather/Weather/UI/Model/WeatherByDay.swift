//
//  WeatherByDay.swift
//  Weather
//
//  Created by Alisiya on 7.05.22.
//

import Foundation

struct WeatherByDay {
    
    let timestamp: Double
    let state: WeatherState
    let maxTemp: Double
    let minTemp: Double
    
    init(weatherObject: WeatherDayResponse) {
        self.timestamp = weatherObject.timestamp
        self.state = WeatherState.init(rawValue: weatherObject.state) ?? WeatherState.another
        self.maxTemp = weatherObject.maxTemp - 273.15
        self.minTemp = weatherObject.minTemp - 273.15
    }
}
