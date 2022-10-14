import CoreLocation

protocol VehicleFinderServiceProtocol {
    func closestVehicle(to location: CLLocation, vehicles: [VehicleDTO]) -> VehicleDTO?
}

final class VehicleFinderService: VehicleFinderServiceProtocol {
    func closestVehicle(to location: CLLocation, vehicles: [VehicleDTO]) -> VehicleDTO? {
        let sortedVehicles = vehicles.sorted(by: { location.distance(from: $0.clLocation) < location.distance(from: $1.clLocation) })
        return sortedVehicles.first
    }
}
