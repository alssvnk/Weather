//
//  WeatherByDay.swift
//  Weather
//
//  Created by Alisiya on 7.05.22.
//

import Foundation

struct WeatherByDay {
    
    let timestamp: String
    let state: WeatherState
    let maxTemp: String
    let minTemp: String
    
    init(weatherObject: WeatherDayResponse) {
        
        self.state = checkForState(with: weatherObject.state)

        self.timestamp =  (weatherObject .timestamp .timestampToDate() as Date).dayOfWeek()!
        
        
        self.maxTemp = String(
            weatherObject
                .maxTemp
                .fahrenheitToCelsius()
        )
        
        self.minTemp = String(
            weatherObject
                .minTemp
                .fahrenheitToCelsius()
        )
    }
}
