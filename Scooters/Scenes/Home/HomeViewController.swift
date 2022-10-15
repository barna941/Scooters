import MapKit
import UIKit

final class HomeViewController: UIViewController, ErrorHandlingView {
    private let presenter: HomePresenterProcotol

    private let indicatorView: ActivityIndicatorView = {
        let view = ActivityIndicatorView()
        view.isHidden = true
        return view
    }()

    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        mapView.register(VehicleAnnotationView.self, forAnnotationViewWithReuseIdentifier: VehicleAnnotationView.reuseIdentifier)
        mapView.register(VehicleClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: VehicleClusterAnnotationView.reuseIdentifier)
        mapView.userTrackingMode = .follow
        return mapView
    }()
    private var mapCenteredToUser = false

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
        bindPresenter()

        presenter.viewDidLoad()
    }

    private func customizeViews() {
        navigationController?.navigationBar.isHidden = true
        title = L10n.homeTitle
        view.backgroundColor = Asset.Colors.primaryBackground.color

        view.addSubview(mapView.usingAutoLayout())
        view.addSubview(indicatorView.usingAutoLayout())
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mapViewConstraints(),
            indicatorViewConstraints()
        ])
    }

    private func bindPresenter() {
        presenter.vehiclesReceived = { [weak self] vehicleViewModels in
            self?.showVehicles(viewModels: vehicleViewModels)
        }
        presenter.errorReceived = { [weak self] error in
            self?.showError(error: error)
        }
        presenter.updateLoadingVisibility = { [weak self] show in
            if show {
                self?.showLoading()
            } else {
                self?.hideLoading()
            }
        }
    }

    private func showVehicles(viewModels: [HomeModel.VehicleViewModel]) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(viewModels.map { $0.annotation })
    }
}

// MARK: - Layout

extension HomeViewController {
    private func indicatorViewConstraints() -> [NSLayoutConstraint] {
        [
            indicatorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            indicatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            indicatorView.widthAnchor.constraint(equalToConstant: 48),
            indicatorView.heightAnchor.constraint(equalToConstant: 48)
        ]
    }

    private func mapViewConstraints() -> [NSLayoutConstraint] {
        [
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
    }
}

// MARK: LoadingView

extension HomeViewController: LoadingView {
    func showLoading() {
        indicatorView.startAnimating()
        indicatorView.isHidden = false
    }

    func hideLoading() {
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
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

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        guard !mapCenteredToUser else { return }
        mapView.centerCoordinate = userLocation.coordinate
        let coordinate = mapView.convert(CGPoint(x: mapView.frame.midX, y: mapView.frame.height * 0.75), toCoordinateFrom: mapView)
        mapView.setCenter(coordinate, animated: true)
        mapCenteredToUser = true
    }
}
