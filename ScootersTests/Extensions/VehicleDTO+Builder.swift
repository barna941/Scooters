import CoreLocation
@testable import Scooters

extension VehicleDTO {
    static func build(with id: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> VehicleDTO {
        VehicleDTO(
            type: "type",
            id: id,
            attributes: VehicleAttributesDTO(
                batteryLevel: 50,
                lat: latitude,
                lng: longitude,
                maxSpeed: 30,
                vehicleType: .escooter,
                hasHelmetBox: true
            )
        )
    }
}
