struct WeatherDayResponse: Codable {
   
    let timestamp: Double
    let state: String
    let maxTemp: Double
    let minTemp: Double

    private enum CodingKeys: String, CodingKey {
        case timestamp = "time"
        case state = "summary"
        case maxTemp = "temperatureMax"
        case minTemp = "temperatureMin"
    }
}
