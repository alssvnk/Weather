//
//  Double+Extension.swift
//  Weather
//
//  Created by Alisiya on 8.05.22.
//

import Foundation

extension Double {

    func fahrenheitToCelsius() -> Double {
        return floor((self - 32) * 5/9)
    }
    
    func timestampToDate() -> NSDate {
        return NSDate(timeIntervalSince1970: self)
    }
}
