struct WeatherHourResponse: Codable {
   
    let timestamp: Double
    let state: String
    let temp: Double
    
    private enum CodingKeys: String, CodingKey {
        case timestamp = "time"
        case state = "summary"
        case temp = "temperature"
    }
}
