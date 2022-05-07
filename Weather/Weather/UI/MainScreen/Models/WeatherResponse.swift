//
//  WeatherResponse.swift
//  Weather
//
//  Created by Alisiya on 7.05.22.
//

import Foundation

struct WeatherResponse: Codable {
   
    let city: String
    let currentWeather: WeatherHourResponse
    let hourlyWeather: HourDataResponse
    let dailyWeather: DayDataResponse
    
    private enum CodingKeys: String, CodingKey {
        case city = "timezone"
        case currentWeather = "currently"
        case hourlyWeather = "hourly"
        case dailyWeather = "daily"

    }
}
