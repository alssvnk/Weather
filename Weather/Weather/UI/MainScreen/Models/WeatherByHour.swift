
struct WeatherByHour {
    let timestamp: String
    let state: WeatherState
    let temperature: String
    
    init(weatherObject: WeatherHourResponse) {
        self.state = Utilities.checkForState(with: weatherObject.state)
        
        self.timestamp = String(
            weatherObject
                .timestamp
                .timestampToDate()
                .getcomponent(component: .hour)
        )
       
        self.temperature = String(
            weatherObject
                .temp
                .fahrenheitToCelsius()
        )
    }
}
