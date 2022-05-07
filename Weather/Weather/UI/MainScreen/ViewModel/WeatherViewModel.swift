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
    func registerCells()
    func requestLocation()
    func requestWeather()
    func reloadData()
}

protocol WeatherTableViewModelProtocol {
    var tableDataSource: [WeatherDayResponse] { get }
    func reloadTable()
}

protocol WeatherCollectionViewModelProtocol {
    var collectionDataSource: [WeatherHourResponse] { get }
    func reloadCollection()
}

final class WeatherViewModel: AlertPresentable {
    
    private var locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    private var networkService = WeatherNetworkService()

    var dataSource: WeatherResponse?
    var tableView: UITableView
    var collectionView: UICollectionView
    
    init(tableView: UITableView, collectionView: UICollectionView) {
        self.tableView = tableView
        self.collectionView = collectionView
    }
}

extension WeatherViewModel: WeatherViewModelProtocol {
    
    func registerCells() {
        self.tableView.register(UINib(nibName: "WeatherByDayCell", bundle: nil), forCellReuseIdentifier: "WeatherByDayCell")
        self.collectionView.register(UINib(nibName: "WeatherByHourCell", bundle: nil), forCellWithReuseIdentifier: "WeatherByHourCell")
    }
    
    func requestLocation() {
        switch locationManager.authorizationStatus {
            
        case .notDetermined, .restricted, .denied:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            self.currentLocation = locationManager.location
        @unknown default:
            print("error")
//            self.showSystemAlert(controller: self, title: "Error", message: "Something went wrong", completion: nil)
        }
    }
    
    
    func requestWeather() {
        guard let location = currentLocation else {
            print("Get Location Error")
            return
        }
        
        self.networkService.getWeather(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    self.dataSource = data
                    self.reloadData()
                case .failure(let error):
                    print("error")
//                    self.showSystemAlert(controller: self, title: "Error", message: "Something went wrong", completion: nil)
                }
            }
        
    }

    func reloadData() {
        self.reloadTable()
        self.reloadCollection()
    }
}

extension WeatherViewModel: WeatherTableViewModelProtocol {
    var tableDataSource: [WeatherDayResponse] {
        get {
            guard let data = dataSource else { return [] }
            return data.dailyWeather.data
        }
    }
    
    func reloadTable() {
        self.tableView.reloadData()
    }
}

extension WeatherViewModel: WeatherCollectionViewModelProtocol {
    var collectionDataSource: [WeatherHourResponse] {
        guard let data = dataSource else { return [] }
        return data.hourlyWeather.data
    }
    
    func reloadCollection() {
        self.collectionView.reloadData()
    }
}
