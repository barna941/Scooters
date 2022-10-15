@testable import Scooters
import SwiftyMocky
import XCTest

final class HomePresenterTests: XCTestCase {
    private var interactor: HomeInteractorProtocolMock!
    private var sut: HomePresenter!

    override func setUpWithError() throws {
        try super.setUpWithError()

        interactor = HomeInteractorProtocolMock()
        sut = HomePresenter(interactor: interactor)
    }

    override func tearDownWithError() throws {
        sut = nil
        interactor = nil

        try super.tearDownWithError()
    }

    func test_WhenViewLoads_ThenLoadingIsDisplayed() {
        var showLoading: Bool?
        sut.updateLoadingVisibility = { showLoading = $0 }

        sut.viewDidLoad()

        XCTAssertEqual(showLoading, true)
    }

    func test_GivenViewLoads_WhenVehiclesAreReturned_ThenLoadingIsDismissed() {
        let dto = responseDto
        Perform(
            interactor,
            .fetchVehicles(
                completion: .any,
                perform: { completion in
                    completion(.success(dto))
                }
            )
        )
        var showLoading: Bool?
        sut.updateLoadingVisibility = { showLoading = $0 }

        sut.viewDidLoad()

        XCTAssertEqual(showLoading, false)
    }

    func test_GivenViewLoads_WhenVehiclesAreReturned_ThenViewModelsAreCreated() {
        let dto = responseDto
        Perform(
            interactor,
            .fetchVehicles(
                completion: .any,
                perform: { completion in
                    completion(.success(dto))
                }
            )
        )
        var viewModels = [HomeModel.VehicleViewModel]()
        sut.vehiclesReceived = { viewModels = $0 }

        sut.viewDidLoad()

        let accuracy = 0.000001
        zip(viewModels, responseDto.data).forEach { viewModel, dto in
            XCTAssertEqual(viewModel.type, dto.attributes.vehicleType)
            XCTAssertEqual(viewModel.annotation.coordinate.latitude, dto.attributes.lat, accuracy: accuracy)
            XCTAssertEqual(viewModel.annotation.coordinate.longitude, dto.attributes.lng, accuracy: accuracy)
        }
    }

    func test_GivenViewLoads_WhenErrorIsReturnedByInteractor_ThenNetworkErrorIsReceived() {
        Perform(
            interactor,
            .fetchVehicles(
                completion: .any,
                perform: { completion in
                    completion(.failure(NSError(domain: "domain", code: 1)))
                }
            )
        )
        var error: PresentableError?
        sut.errorReceived = { error = $0 }

        sut.viewDidLoad()

        XCTAssertEqual(error, .some(.network))
    }
}

extension HomePresenterTests {
    private var responseDto: VehiclesResponseDTO {
        VehiclesResponseDTO(
            data: [
                VehicleDTO.build(with: "1", latitude: 52.475785, longitude: 13.326359),
                VehicleDTO.build(with: "2", latitude: 52.517169, longitude: 13.394245)
            ]
        )
    }
}
