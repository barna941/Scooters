import Foundation

struct VehicleDTO: Decodable, Equatable {
    let type: String
    let id: String
    let attributes: VehicleAttributesDTO
}
