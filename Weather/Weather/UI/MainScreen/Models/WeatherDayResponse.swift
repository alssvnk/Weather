//
//  WeatherResponse.swift
//  Weather
//
//  Created by Alisiya on 7.05.22.
//

import Foundation

struct WeatherDayResponse: Codable {
   
    let timestamp: Double
    let state: String
    let maxTemp: Double
    let minTemp: Double

    private enum CodingKeys: String, CodingKey {
        case timestamp = "time"
        case state = "icon"
        case maxTemp = "temperatureMax"
        case minTemp = "temperatureMin"
    }
}
