import CoreLocation

extension VehicleDTO {
    var clLocation: CLLocation {
        CLLocation(latitude: attributes.lat, longitude: attributes.lng)
    }
}
