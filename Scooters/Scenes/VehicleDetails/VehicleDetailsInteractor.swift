import CoreLocation

protocol VehicleDetailsInteractorProtocol: AnyObject {
    var didFindClosestVehicle: ((VehicleDTO) -> Void)? { get set }

    func requestLocationAuthorizationIfNeeded()
}

final class VehicleDetailsInteractor: VehicleDetailsInteractorProtocol {
    private let vehicleRepositoryService: VehicleRepositoryServiceProtocol
    private let locationService: LocationServiceProtocol
    private let vehicleFinderService: VehicleFinderServiceProtocol

    var didFindClosestVehicle: ((VehicleDTO) -> Void)?

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
        vehicleRepositoryService.vehiclesUpdated = { [weak self] in
            guard let location = self?.locationService.location else { return }
            self?.findClosestVehicle(to: location)
        }
    }

    func requestLocationAuthorizationIfNeeded() {
        guard locationService.shouldRequestLocationAuthorization else { return }
        locationService.requestLocationAuthorization()
    }
}

extension VehicleDetailsInteractor {
    private func findClosestVehicle(to userLocation: CLLocation) {
        guard let closestVehicle = vehicleFinderService.closestVehicle(to: userLocation, vehicles: vehicleRepositoryService.vehicles) else {
            return
        }
        didFindClosestVehicle?(closestVehicle)
    }
}
