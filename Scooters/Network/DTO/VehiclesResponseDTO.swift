import Foundation

struct VehiclesResponseDTO: Decodable, Equatable {
    let data: [VehicleDTO]
}
