//
//  WeatherState.swift
//  Weather
//
//  Created by Alisiya on 7.05.22.
//

import Foundation
import UIKit

enum WeatherState: String {
    
    case rain = "rain"
    case snow = "snow"
    case sunny = "clear"
    case cloud = "clouds"
    case another
    
    var image: UIImage? {
        switch self {
        case .rain:
            return UIImage(systemName: "cloud.rain.fill")
        case .snow:
            return UIImage(systemName: "cloud.snow.fill")
        case .sunny:
            return UIImage(systemName: "cloud.sun.fill")
        case .cloud:
            return UIImage(systemName: "cloud.fill")
        case .another:
            return UIImage(systemName: "cloud")
        }
    }
    
    var backgroundImage: UIImage? {
        switch self {
        case .rain:
            return UIImage(named: "rain")
        case .snow:
            return UIImage(named: "snow")
        case .sunny:
            return UIImage(named: "sun")
        case .cloud:
            return UIImage(named: "cloud")
        case .another:
            return UIImage(named: "cloud")
        }
    }
}
