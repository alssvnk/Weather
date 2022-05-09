struct DayDataResponse: Codable {
    
    let data: [WeatherDayResponse]
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
}
