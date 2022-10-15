import CoreLocation
@testable import Scooters
import XCTest

final class VehicleFinderServiceTests: XCTestCase {
    private var sut: VehicleFinderService!

    override func setUpWithError() throws {
        try super.setUpWithError()

        sut = VehicleFinderService()
    }

    override func tearDownWithError() throws {
        sut = nil

        try super.tearDownWithError()
    }

    func test_GivenUserLocation_WhenVehiclesArePresent_ThenClosestIsReturned() {
        let userLocation = CLLocation(latitude: 52.475786, longitude: 13.326358)
        let vehicles = [
            VehicleDTO.build(with: "1", latitude: 52.475785, longitude: 13.326359),
            VehicleDTO.build(with: "2", latitude: 52.517169, longitude: 13.394245)
        ]

        let vehicle = sut.closestVehicle(to: userLocation, vehicles: vehicles)

        XCTAssertEqual(vehicle?.id, .some(vehicles[0].id))
    }
}
