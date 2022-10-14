import UIKit

extension VehicleType {
    var icon: UIImage {
        switch self {
        case .escooter, .emoped, .ebicycle, .unknown:
            return Asset.Icons.scooterIcon.image
        }
    }

    var title: String {
        switch self {
        case .escooter:
            return L10n.vehicleTypeEscooter
        case .emoped:
            return L10n.vehicleTypeEmoped
        case .ebicycle:
            return L10n.vehicleTypeEbicyle
        case .unknown:
            return ""
        }
    }
}
