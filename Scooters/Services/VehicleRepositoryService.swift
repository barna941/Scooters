import Foundation

protocol VehicleRepositoryServiceProtocol: AnyObject {
    var vehiclesUpdated: (() -> Void)? { get set }
    var vehicles: [VehicleDTO] { get }

    func update(vehicles: [VehicleDTO])
}

final class VehicleRepositoryService: VehicleRepositoryServiceProtocol {
    var vehiclesUpdated: (() -> Void)?
    var vehicles = [VehicleDTO]()

    func update(vehicles: [VehicleDTO]) {
        self.vehicles = vehicles
        vehiclesUpdated?()
    }
}
