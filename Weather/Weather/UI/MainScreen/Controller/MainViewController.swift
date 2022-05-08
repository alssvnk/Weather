//
//  ViewController.swift
//  Weather
//
//  Created by Alisiya on 7.05.22.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, AlertPresentable {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var weatherAtMomentView: CurrentWeatherView!
    @IBOutlet weak private var weatherColletionView: UICollectionView!
    @IBOutlet weak private var weatherTableView: UITableView!

    private var viewModel: WeatherViewModel? {
        didSet {
            DispatchQueue.main.async { self.updateView() }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = WeatherViewModel()
        
        self.registerCells()
        self.requestLocation()
        self.requestWeather()
    }
    
    private func updateView() {
        self.weatherTableView.reloadData()
        self.weatherColletionView.reloadData()
        guard let weatherResponse = viewModel?.dataSource else { return }
        let object = WeatherAtMoment(weatherObject: weatherResponse)
        weatherAtMomentView.setupView(model: object)
        mainImageView.image = object.state.backgroundImage
    }
    
    private func registerCells() {
        self.weatherTableView.register(UINib(nibName: "WeatherByDayCell", bundle: nil), forCellReuseIdentifier: "WeatherByDayCell")
        self.weatherColletionView.register(UINib(nibName: "WeatherByHourCell", bundle: nil), forCellWithReuseIdentifier: "WeatherByHourCell")
    }
    
    private func requestLocation() {
        viewModel?.requestLocation(completion: { [weak self] error in
            guard let _ = error,
                  let self = self else { return }
            self.showSystemAlert(controller: self, title: "Error", message: "Something went wrong", completion: nil)
        })
    }
    
    private func requestWeather() {
        viewModel?.requestWeather(completion: { [weak self] error in
            guard let _ = error,
                  let self = self else { return }
            self.showSystemAlert(controller: self, title: "Error", message: "Something went wrong", completion: nil)
        })
    }
    
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.tableDataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherByDayCell") as? WeatherByDayCell,
              let weatherObject = viewModel?.tableDataSource[indexPath.row]
        else {
            return UITableViewCell()
        }
        
        let model = WeatherByDay(weatherObject: weatherObject)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherByHourCell", for: indexPath) as? WeatherByHourCell,
              let weatherObject = viewModel?.collectionDataSource[indexPath.row]
        else { return UICollectionViewCell()}
        let model = WeatherByHour(weatherObject: weatherObject)
        cell.configure(model: model)
        return cell
    }
}
