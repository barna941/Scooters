import Foundation

struct VehicleAttributesDTO: Decodable {
    let batteryLevel: Int
    let lat: Double
    let lng: Double
    let maxSpeed: Int
    let vehicleType: VehicleType
    let hasHelmetBox: Bool
}
