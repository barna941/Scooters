import Foundation

enum VehicleType: String, Decodable, Equatable {
    case escooter
    case emoped
    case ebicycle
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawType = try? container.decode(String.self)
        if let type = rawType, let vehicleType = VehicleType(rawValue: type) {
            self = vehicleType
        } else {
            self = .unknown
        }
    }
}
