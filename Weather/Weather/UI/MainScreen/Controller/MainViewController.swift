//
//  ViewController.swift
//  Weather
//
//  Created by Alisiya on 7.05.22.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, AlertPresentable {
    
    @IBOutlet weak private var cityNameLabel: UILabel!
    @IBOutlet weak private var currentTempLabel: UILabel!
    @IBOutlet weak private var weatherColletionView: UICollectionView!
    @IBOutlet weak private var weatherTableView: UITableView!
        
    private var viewModel: WeatherViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = WeatherViewModel(
            tableView: self.weatherTableView,
            collectionView: self.weatherColletionView
        )
        viewModel?.registerCells()
        viewModel?.requestLocation()
        viewModel?.requestWeather()
//        self.registerCells()
//        self.requestLocation()
//        self.requestWeather()
    }
    
    
//    func requestLocation() {
//        switch locationManager.authorizationStatus {
//
//        case .notDetermined, .restricted, .denied:
//            locationManager.requestWhenInUseAuthorization()
//        case .authorizedAlways, .authorizedWhenInUse:
//            self.currentLocation = locationManager.location
//        @unknown default:
//            self.showSystemAlert(controller: self, title: "Error", message: "Something went wrong", completion: nil)
//        }
//    }
//
//    func requestWeather() {
//        guard let location = currentLocation else {
//            print("Get Location Error")
//            return
//        }
//
//        self.networkService.getWeather(
//            latitude: location.coordinate.latitude,
//            longitude: location.coordinate.longitude) { [weak self] result in
//                guard let self = self else { return }
//                switch result {
//                case .success(let data):
//                    self.viewModel = WeatherViewModel(
//                        data: data,
//                        tableView: self.weatherTableView,
//                        collectionView: self.weatherColletionView
//                    )
//                    self.viewModel?.reloadData()
//
//                case .failure(let error):
//                    self.showSystemAlert(controller: self, title: "Error", message: "Something went wrong", completion: nil)
//                }
//            }
//
//    }
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.tableDataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherByDayCell") as? WeatherByDayCell else { return UITableViewCell()}
        let model = viewModel?.tableDataSource[indexPath.row]
        cell.configure(model: model)
        return cell
        
    }
}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.collectionDataSource.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherByHourCell", for: indexPath) as? WeatherByHourCell else { return UICollectionViewCell()}
        let model = viewModel?.collectionDataSource[indexPath.row]
        cell.configure(model: model)
        return cell
    }
}
