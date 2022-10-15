import Foundation

// sourcery: AutoMockable
protocol VehiclesApiProtocol {
    func fetchVehicles(completion: @escaping (Result<VehiclesResponseDTO, Error>) -> Void)
}

final class VehiclesApi: VehiclesApiProtocol {
    private let netwworkClient: NetworkClientProtocol
    private let baseUrlProvider: BaseUrlProviderProtocol

    init(netwworkClient: NetworkClientProtocol, baseUrlProvider: BaseUrlProviderProtocol) {
        self.netwworkClient = netwworkClient
        self.baseUrlProvider = baseUrlProvider
    }

    func fetchVehicles(completion: @escaping (Result<VehiclesResponseDTO, Error>) -> Void) {
        netwworkClient.request(
            url: baseUrlProvider.baseUrl.appendingPathComponent("public/take_home_test_data.json"),
            completion: completion
        )
    }
}
