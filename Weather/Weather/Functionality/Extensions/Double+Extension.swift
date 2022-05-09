
import Foundation

extension Double {
    func fahrenheitToCelsius() -> Double {
        floor((self - 32) * 5/9)
    }
    
    func timestampToDate() -> NSDate {
        NSDate(timeIntervalSince1970: self)
    }
}
