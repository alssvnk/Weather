//
//  ApiRouter.swift
//  Weather
//
//  Created by Alisiya on 7.05.22.
//

import Foundation
import Alamofire

enum ApiRouter {
    
    case getWeatherByLocation(_ latitude: Double, _ longitude: Double)
    
    var scheme: String {
        switch self {
        case .getWeatherByLocation:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .getWeatherByLocation:
            return "api.darksky.net"
        }
    }
    
    var path: String {
        switch self {
        case .getWeatherByLocation(let latitude, let longitude):
            let apiKey = "2bb07c3bece89caf533ac9a5d23d8417"
            return "/forecast/\(apiKey)/\(latitude),\(longitude)"
        }
    }
    
    var method: HTTPMethod  {
        switch self {
        case .getWeatherByLocation:
            return .get
        }
    }
    
    var query: [URLQueryItem] {
        switch self {
        case .getWeatherByLocation:
            return [URLQueryItem]()
        }
    }
}
