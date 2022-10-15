import CoreLocation

protocol VehicleDetailsInteractorProtocol: AnyObject {
    var didFindClosestVehicle: ((VehicleDTO) -> Void)? { get set }
    var authorizationStatusDisabled: (() -> Void)? { get set }
}

final class VehicleDetailsInteractor: VehicleDetailsInteractorProtocol {
    private let vehicleRepositoryService: VehicleRepositoryServiceProtocol
    private let locationService: LocationServiceProtocol
    private let vehicleFinderService: VehicleFinderServiceProtocol

    var didFindClosestVehicle: ((VehicleDTO) -> Void)?
    var authorizationStatusDisabled: (() -> Void)?

    init(
        vehicleRepositoryService: VehicleRepositoryServiceProtocol,
        locationService: LocationServiceProtocol,
        vehicleFinderService: VehicleFinderServiceProtocol
    ) {
        self.vehicleRepositoryService = vehicleRepositoryService
        self.locationService = locationService
        self.vehicleFinderService = vehicleFinderService

        locationService.didUpdateLocation = { [weak self] location in
            self?.findClosestVehicle(to: location)
        }
        locationService.authorizationStatusDidChange = { [weak self] in
            self?.handleAuthorizationStatusChange()
        }
        vehicleRepositoryService.vehiclesUpdated = { [weak self] in
            guard let location = self?.locationService.location else { return }
            self?.findClosestVehicle(to: location)
        }
    }
}

extension VehicleDetailsInteractor {
    private func findClosestVehicle(to userLocation: CLLocation) {
        guard let closestVehicle = vehicleFinderService.closestVehicle(to: userLocation, vehicles: vehicleRepositoryService.vehicles) else {
            return
        }
        didFindClosestVehicle?(closestVehicle)
    }

    private func handleAuthorizationStatusChange() {
        if locationService.shouldRequestLocationAuthorization {
            locationService.requestLocationAuthorization()
        } else if !locationService.isLocationEnabled {
            authorizationStatusDisabled?()
        }
    }
}
