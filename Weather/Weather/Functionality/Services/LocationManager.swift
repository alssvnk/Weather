
import CoreLocation

class LocationManager: NSObject {
    // MARK: - Closures
    var askPermissionAction: (() -> Void)?
    var locationChangedAction: ((CLLocation?) -> Void)?
    
    // MARK: - Location
    private var currentLocation: CLLocation? {
        didSet {
            self.locationChangedAction?(self.currentLocation)
        }
    }

    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        manager.allowsBackgroundLocationUpdates = false
        DispatchQueue.main.async { [weak manager] in
            manager?.startMonitoringSignificantLocationChanges()
        }
        
        return manager
    }()
    
    // MARK: - Init
    override init() {
        super.init()
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            self.locationManager.requestLocation()
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        default:
            self.askPermissionAction?()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.first else { return }
        self.currentLocation = lastLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard manager.authorizationStatus != .notDetermined else { return }
        debugPrint("!!! - \(error.localizedDescription)")
    }
}
