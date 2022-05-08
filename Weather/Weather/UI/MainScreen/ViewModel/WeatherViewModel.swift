//
//  WeatherrViewModel.swift
//  Weather
//
//  Created by Alisiya on 8.05.22.
//

import Foundation
import UIKit
import CoreLocation

protocol WeatherViewModelProtocol {
    func requestLocation(completion: @escaping (Error?) -> ())
    func requestWeather(completion: @escaping (Error?) -> ())
}

protocol WeatherCurrentViewViewModelProtocol {
    var currentData: WeatherAtMoment? { get }
}

protocol WeatherTableViewModelProtocol {
    var tableDataSource: [WeatherDayResponse] { get }
}

protocol WeatherCollectionViewModelProtocol {
    var collectionDataSource: [WeatherHourResponse] { get }
}


final class WeatherViewModel {
    
    private var locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    private var networkService = WeatherNetworkService()

    var dataSource: WeatherResponse?
    
    init() {}

}

extension WeatherViewModel: WeatherViewModelProtocol {
    
    func requestLocation(completion: @escaping (Error?) -> ()) {
        switch locationManager.authorizationStatus {
        case .notDetermined, .restricted, .denied:
            //TODO: - UserDefaults
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            self.currentLocation = locationManager.location
        @unknown default:
            completion(LocationError.authError)
        }
    }
    
    
    func requestWeather(completion: @escaping (Error?) -> ()) {
        guard let location = currentLocation else {
            completion(LocationError.authError)
            return
        }
        
        self.networkService.getWeather(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    self.dataSource = data
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
    }
}

extension WeatherViewModel: WeatherTableViewModelProtocol {
    var tableDataSource: [WeatherDayResponse] {
        guard let data = dataSource else { return [] }
        return data.dailyWeather.data
    }
}

extension WeatherViewModel: WeatherCollectionViewModelProtocol {
    var collectionDataSource: [WeatherHourResponse] {
        guard let data = dataSource else { return [] }
        return data.hourlyWeather.data
    }
}

extension WeatherViewModel: WeatherCurrentViewViewModelProtocol {
    var currentData: WeatherAtMoment? {
        guard let data = dataSource else { return nil }
        return WeatherAtMoment(weatherObject: data)
    }
}
