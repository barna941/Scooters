import Foundation

struct VehicleDTO: Decodable {
    let type: String
    let id: String
    let attributes: VehicleAttributesDTO
}
