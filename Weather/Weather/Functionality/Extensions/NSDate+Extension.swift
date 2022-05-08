//
//  NSDate+Extension.swift
//  Weather
//
//  Created by Alisiya on 8.05.22.
//

import Foundation

extension NSDate {
    func getcomponent(component: Calendar.Component) -> Int {
        let calendar = Calendar.current
        return calendar.component(component, from: self as Date)
    }
}
