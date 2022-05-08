//
//  WeatherByHour.swift
//  Weather
//
//  Created by Alisiya on 7.05.22.
//

import Foundation

struct WeatherAtMoment {
    let state: WeatherState
    let temperature: String
    let city: String
    
    init(weatherObject: WeatherResponse) {
        
        self.state = checkForState(with: weatherObject.currentWeather.state)

        self.city = weatherObject
            .city
//            .sub
        
        self.temperature = String(
            weatherObject
                .currentWeather
                .temp
                .fahrenheitToCelsius()
        )
    }
}
