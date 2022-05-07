//
//  WeatherResponse.swift
//  Weather
//
//  Created by Alisiya on 7.05.22.
//

import Foundation

struct WeatherHourResponse: Codable {
   
    let timestamp: Double
    let state: String
    let temp: Double
    
    private enum CodingKeys: String, CodingKey {
        case timestamp = "time"
        case state = "summary"
        case temp = "temperature"
    }
}
