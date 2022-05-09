
import Foundation

extension NSDate {
    func getcomponent(component: Calendar.Component) -> Int {
        Calendar.current.component(component, from: self as Date)
    }
}
