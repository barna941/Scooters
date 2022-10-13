import CoreLocation
import UIKit

protocol LocationServiceProtocol {
    var isLocationEnabled: Bool { get }
    var shouldRequestLocationAuthorization: Bool { get }
    var authorizationStatusDidChange: (() -> Void)? { get set }
    var didUpdateLocation: ((CLLocation) -> Void)? { get set }

    func requestLocationAuthorization()
}

final class LocationService: NSObject, LocationServiceProtocol {
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 20
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.activityType = .otherNavigation
        locationManager.delegate = self
        return locationManager
    }()

    var authorizationStatusDidChange: (() -> Void)?
    var didUpdateLocation: ((CLLocation) -> Void)?

    var isLocationEnabled: Bool {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        default:
            return false
        }
    }

    var shouldRequestLocationAuthorization: Bool {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            return true
        default:
            return false
        }
    }

    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatusDidChange?()
        switch status {
        case .notDetermined, .restricted, .denied:
            return
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            return
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        didUpdateLocation?(lastLocation)
    }
}
