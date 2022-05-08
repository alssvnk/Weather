//
//  DayDataResponse.swift
//  Weather
//
//  Created by Alisiya on 7.05.22.
//

import Foundation

struct DayDataResponse: Codable {
    
    let data: [WeatherDayResponse]
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
}
