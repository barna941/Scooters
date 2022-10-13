import MapKit

enum HomeModel {
    struct VehicleViewModel {
        let annotation: VehicleAnnotation
        let type: VehicleType
    }

    final class VehicleAnnotation: NSObject, MKAnnotation {
        let coordinate: CLLocationCoordinate2D
        let icon: UIImage

        init(coordinate: CLLocationCoordinate2D, icon: UIImage) {
            self.coordinate = coordinate
            self.icon = icon
        }
    }
}
