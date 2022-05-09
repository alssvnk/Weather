
import UIKit
import CoreLocation

class MainViewController: UIViewController, AlertPresentable {
    
    @IBOutlet weak private var mainImageView: UIImageView!
    @IBOutlet weak private var weatherAtMomentView: CurrentWeatherView!
    @IBOutlet weak private var blurView: UIView! {
        didSet {
            self.blurView.blur()
        }
    }
    @IBOutlet weak private var weatherColletionView: UICollectionView! {
        didSet {
            self.weatherColletionView.register(WeatherByHourCell.nib, forCellWithReuseIdentifier: WeatherByHourCell.identifier)
        }
    }
    @IBOutlet weak private var weatherTableView: UITableView! {
        didSet {
            self.weatherTableView.register(WeatherByDayCell.nib, forCellReuseIdentifier: WeatherByDayCell.identifier)
        }
    }
    
    // MARK: - Services
    private lazy var locationManager: LocationManager = {
        let manager = LocationManager()
        manager.locationChangedAction = { [weak self] location in
            self?.viewModel?.currentLocation = location
        }
        manager.askPermissionAction = { [weak self] in
            guard let self = self else { return }
            self.showGoSettingsAlert(
                controller: self,
                title: "Error",
                message: "Please change location privacy at settings",
                completion: nil
            )
        }
        return manager
    }()
    
    private let weatherNetworkService = WeatherNetworkService()

    // MARK: - ViewModels
    var viewModel: WeatherViewModel?

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupViewModel()
    }
    
    // MARK: - Setup
    private func setupViewModel() {
        self.viewModel = WeatherViewModel(
            locationManager: self.locationManager,
            networkService: self.weatherNetworkService
        )
        self.viewModel?.reloadTableAction = { [weak self] in
            self?.updateView()
        }
        
        self.viewModel?.updateLocation = { [weak self] in
            self?.requestWeather()
        }
    }
    
    // MARK: - Methods
    private func updateView() {
        self.weatherTableView.reloadData()
        self.weatherColletionView.reloadData()
        
        guard let data = self.viewModel?.currentData else { return }
        self.weatherAtMomentView.setupView(model: data)
        self.mainImageView.image = data.state.backgroundImage
    }
    
    private func requestWeather() {
        self.viewModel?.requestWeather(completion: { [weak self] error in
            guard let _ = error,
                  let self = self else { return }
            self.showSystemAlert(controller: self, title: "Error", message: "Something went wrong", completion: nil)
        })
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel?.tableDataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherByDayCell.identifier) as? WeatherByDayCell,
              let weatherObject = self.viewModel?.tableDataSource[indexPath.row]
        else { return UITableViewCell() }
        
        let model = WeatherByDay(weatherObject: weatherObject)
        cell.configure(model: model)
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel?.collectionDataSource.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherByHourCell.identifier, for: indexPath) as? WeatherByHourCell,
              let weatherObject = self.viewModel?.collectionDataSource[indexPath.row]
        else { return UICollectionViewCell()}
        
        let model = WeatherByHour(weatherObject: weatherObject)
        cell.configure(model: model)
        return cell
    }
}
