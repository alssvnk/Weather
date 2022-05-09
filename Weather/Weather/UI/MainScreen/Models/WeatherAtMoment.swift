struct WeatherAtMoment {
    let state: WeatherState
    let temperature: String
    let city: String
    
    init(weatherObject: WeatherResponse) {
        self.state = Utilities.checkForState(with: weatherObject.currentWeather.state)
        self.city = weatherObject
            .city
            .replacingOccurrences(of: String.dash, with: String.space)
            .components(separatedBy: String.slash)
            .last ?? String.empty
        self.temperature = String(
            weatherObject
                .currentWeather
                .temp
                .fahrenheitToCelsius()
        )
    }
}
