//
//  WeatherNetworkService.swift
//  Weather
//
//  Created by Alisiya on 8.05.22.
//

import Foundation

class WeatherNetworkService: NetworkService {
    
//    override func getCurrentWeather(_ router: ApiRouter, completion: @escaping NetworkService.Completion) {
//        super.getCurrentWeather(router, completion: completion)
//    }
    
    func getWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponse, NetworkError>) -> ()) {
        self.getCurrentWeather(.getWeatherByLocation(latitude, longitude)) { result in
            switch result {
            case .success(let data):
                guard let data = try? JSONDecoder().decode(WeatherResponse.self, from: data) else {
                    completion(.failure(NetworkError.unwrap))
                    return
                }
                completion(.success(data))
            case .failure(_):
                completion(.failure(NetworkError.network))
            }
        }
    }
}
