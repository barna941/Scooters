import Foundation

enum VehicleDetailsViewModel {
    case disabled
    case enabled(vehicle: Vehicle)

    struct Vehicle {
        let id: String
        let type: String
        let batteryLevel: String
        let helmetBoxText: String
        let maxSpeed: String
    }
}
