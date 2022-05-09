struct HourDataResponse: Codable {
    
    let data: [WeatherHourResponse]
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
}
