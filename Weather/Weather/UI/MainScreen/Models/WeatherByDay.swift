
import Foundation

struct WeatherByDay {
    
    let timestamp: String
    let state: WeatherState
    let maxTemp: String
    let minTemp: String
    
    init(weatherObject: WeatherDayResponse) {
        self.state = Utilities.checkForState(with: weatherObject.state)

        self.timestamp = (weatherObject
            .timestamp
            .timestampToDate() as Date)
        .dayOfWeek() ?? String.empty
        
        
        self.maxTemp = String(
            weatherObject
                .maxTemp
                .fahrenheitToCelsius()
        )
        
        self.minTemp = String(
            weatherObject
                .minTemp
                .fahrenheitToCelsius()
        )
    }
}
