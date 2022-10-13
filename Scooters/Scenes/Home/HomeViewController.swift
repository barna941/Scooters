import MapKit
import UIKit

final class HomeViewController: UIViewController {
    private let presenter: HomePresenterProcotol

    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        mapView.register(VehicleAnnotationView.self, forAnnotationViewWithReuseIdentifier: VehicleAnnotationView.reuseIdentifier)
        mapView.register(VehicleClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: VehicleClusterAnnotationView.reuseIdentifier)
        return mapView
    }()

    init(presenter: HomePresenterProcotol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        customizeViews()
        setupConstraints()
        bindVehicles()

        presenter.viewDidLoad()
    }

    private func customizeViews() {
        title = L10n.homeTitle
        view.backgroundColor = Asset.Colors.primaryBackground.color
        view.addSubview(mapView.usingAutoLayout())
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mapViewConstraints()
        ])
    }

    private func mapViewConstraints() -> [NSLayoutConstraint] {
        [
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
    }

    private func bindVehicles() {
        presenter.didReceiveVehicles = { [weak self] vehicleViewModels in
            self?.showVehicles(viewModels: vehicleViewModels)
        }
    }

    private func showVehicles(viewModels: [HomeModel.VehicleViewModel]) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(viewModels.map { $0.annotation })
    }
}

// MARK: - MKMapViewDelegate

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let vehicleAnnotation = annotation as? HomeModel.VehicleAnnotation else { return nil }
        let annotationView = VehicleAnnotationView(
            annotation: vehicleAnnotation,
            reuseIdentifier: VehicleAnnotationView.reuseIdentifier
        )
        annotationView.configure(with: vehicleAnnotation.icon)
        return annotationView
    }
}
