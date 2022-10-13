import Foundation

protocol HomeInteractorProtocol {
    func fetchVehicles(completion: @escaping ((Result<VehiclesResponseDTO, Error>) -> Void))
}

final class HomeInteractor: HomeInteractorProtocol {
    private let vehiclesApi: VehiclesApiProtocol
    private let locationService: LocationServiceProtocol

    init(vehiclesApi: VehiclesApiProtocol, locationService: LocationServiceProtocol) {
        self.vehiclesApi = vehiclesApi
        self.locationService = locationService
    }

    func fetchVehicles(completion: @escaping ((Result<VehiclesResponseDTO, Error>) -> Void)) {
        vehiclesApi.fetchVehicles(completion: completion)
    }
}
