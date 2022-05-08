//
//  WeatherResponse.swift
//  Weather
//
//  Created by Alisiya on 7.05.22.
//

import Foundation

struct HourDataResponse: Codable {
    
    let data: [WeatherHourResponse]
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
}
