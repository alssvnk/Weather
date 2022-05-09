
import UIKit

enum WeatherState: String, CaseIterable {
    case rain = "Rain"
    case snow = "Snow"
    case sunny = "Clear"
    case cloud = "Cloud"
    case overcast = "Overcast"
    case another
    
    var image: UIImage? {
        switch self {
        case .rain:
            return UIImage(systemName: "cloud.rain.fill")
        case .snow:
            return UIImage(systemName: "cloud.snow.fill")
        case .sunny, .overcast:
            return UIImage(systemName: "cloud.sun.fill")
        case .cloud, .another:
            return UIImage(systemName: "cloud.fill")
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
        case .cloud, .overcast, .another:
            return UIImage(named: "cloud")
        }
    }
}
