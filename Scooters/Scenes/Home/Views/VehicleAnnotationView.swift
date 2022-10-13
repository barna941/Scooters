import MapKit

final class VehicleAnnotationView: MKAnnotationView, ReusableView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        clusteringIdentifier = VehicleClusterAnnotationView.reuseIdentifier
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForDisplay() {
        super.prepareForDisplay()

        displayPriority = .defaultLow
        canShowCallout = false
    }

    func configure(with image: UIImage) {
        self.image = image
        frame = CGRect(x: 0, y: 0, width: 32, height: 32)
    }
}
