
import UIKit
import CoreLocation

protocol WeatherViewModelProtocol: AnyObject {
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

class WeatherViewModel {
    // MARK: - Closures
    var reloadTableAction: (() -> Void)?
    var updateLocation: (() -> Void)?
    
    // MARK: - Properties
    private var locationManager: LocationManager?
    private var networkService: NetworkService?
    var currentLocation: CLLocation? {
        didSet {
            self.updateLocation?()
        }
    }
    
    private(set) var dataSource: WeatherResponse? {
        didSet {
            self.reloadTableAction?()
        }
    }
    
    // MARK: - Init
    init(locationManager: LocationManager, networkService: WeatherNetworkService) {
        self.locationManager = locationManager
        self.networkService = networkService
    }
}

extension WeatherViewModel: WeatherViewModelProtocol {
    func requestWeather(completion: @escaping (Error?) -> ()) {
        guard let location = self.currentLocation,
              let networkService = self.networkService as? WeatherNetworkService else {
            completion(LocationError.authError)
            return
        }
        
        networkService.getWeather(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.dataSource = data
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
    }
}

extension WeatherViewModel: WeatherTableViewModelProtocol {
    var tableDataSource: [WeatherDayResponse] {
        self.dataSource?.dailyWeather.data ?? []
    }
}

extension WeatherViewModel: WeatherCollectionViewModelProtocol {
    var collectionDataSource: [WeatherHourResponse] {
        self.dataSource?.hourlyWeather.data ?? []
    }
}

extension WeatherViewModel: WeatherCurrentViewViewModelProtocol {
    var currentData: WeatherAtMoment? {
        guard let data = self.dataSource else { return nil }
        return WeatherAtMoment(weatherObject: data)
    }
}
