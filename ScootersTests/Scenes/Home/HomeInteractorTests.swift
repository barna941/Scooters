@testable import Scooters
import SwiftyMocky
import XCTest

final class HomeInteractorTests: XCTestCase {
    private var vehiclesApi: VehiclesApiProtocolMock!
    private var vehicleRepositoryService: VehicleRepositoryServiceProtocolMock!
    private var sut: HomeInteractor!

    override func setUpWithError() throws {
        try super.setUpWithError()

        vehiclesApi = VehiclesApiProtocolMock()
        vehicleRepositoryService = VehicleRepositoryServiceProtocolMock()
        sut = HomeInteractor(
            vehiclesApi: vehiclesApi,
            vehicleRepositoryService: vehicleRepositoryService
        )
    }

    override func tearDownWithError() throws {
        sut = nil
        vehiclesApi = nil
        vehicleRepositoryService = nil

        try super.tearDownWithError()
    }

    func test_GivenVehicleApiReturnsVehicles_WhenVehiclesAreFetched_ThenRepositoryGetsUpdated() {
        let dto = responseDto
        Perform(
            vehiclesApi,
            .fetchVehicles(
                completion: .any,
                perform: { completion in
                    completion(.success(dto))
                }
            )
        )

        sut.fetchVehicles { result in
            switch result {
            case .success:
                Verify(self.vehicleRepositoryService, .update(vehicles: .matching({ $0 == dto.data })))

            case let .failure(error):
                XCTFail("fetchVehicles failed with error: \(error.localizedDescription)")
            }
        }
    }

    func test_GivenVehicleApiReturnsVehicles_WhenVehiclesAreFetched_ThenTheyAreReturned() {
        let dto = responseDto
        Perform(
            vehiclesApi,
            .fetchVehicles(
                completion: .any,
                perform: { completion in
                    completion(.success(dto))
                }
            )
        )

        sut.fetchVehicles { result in
            switch result {
            case let .success(value):
                XCTAssertEqual(value, dto)

            case let .failure(error):
                XCTFail("fetchVehicles failed with error: \(error.localizedDescription)")
            }
        }
    }

    func test_GivenVehicleApiReturnsError_WhenVehiclesAreFetched_ThenErrorIsReturned() {
        let error = NSError(domain: "test", code: 1)
        Perform(
            vehiclesApi,
            .fetchVehicles(
                completion: .any,
                perform: { completion in
                    completion(.failure(error))
                }
            )
        )

        sut.fetchVehicles { result in
            switch result {
            case .success:
                XCTFail("fetchVehicles should have failed")

            case let .failure(err):
                XCTAssertEqual((err as NSError).code, error.code)
            }
        }
    }
}

extension HomeInteractorTests {
    private var responseDto: VehiclesResponseDTO {
        VehiclesResponseDTO(
            data: [
                VehicleDTO.build(with: "1", latitude: 52.475785, longitude: 13.326359),
                VehicleDTO.build(with: "2", latitude: 52.517169, longitude: 13.394245)
            ]
        )
    }
}
