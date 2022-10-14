import Foundation

protocol HomeInteractorProtocol {
    func fetchVehicles(completion: @escaping ((Result<VehiclesResponseDTO, Error>) -> Void))
}

final class HomeInteractor: HomeInteractorProtocol {
    private let vehiclesApi: VehiclesApiProtocol
    private let vehicleRepositoryService: VehicleRepositoryServiceProtocol

    init(vehiclesApi: VehiclesApiProtocol, vehicleRepositoryService: VehicleRepositoryServiceProtocol) {
        self.vehiclesApi = vehiclesApi
        self.vehicleRepositoryService = vehicleRepositoryService
    }

    func fetchVehicles(completion: @escaping ((Result<VehiclesResponseDTO, Error>) -> Void)) {
        vehiclesApi.fetchVehicles { [weak self] result in
            switch result {
            case let .success(dto):
                self?.vehicleRepositoryService.update(vehicles: dto.data)
                completion(.success(dto))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
