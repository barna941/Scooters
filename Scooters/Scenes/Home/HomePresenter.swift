import MapKit

protocol HomePresenterProcotol: AnyObject {
    var didReceiveVehicles: (([HomeModel.VehicleViewModel]) -> Void)? { get set }

    func viewDidLoad()
}

final class HomePresenter: HomePresenterProcotol {
    private let interactor: HomeInteractorProtocol

    var didReceiveVehicles: (([HomeModel.VehicleViewModel]) -> Void)?

    init(interactor: HomeInteractorProtocol) {
        self.interactor = interactor
    }

    func viewDidLoad() {
        interactor.fetchVehicles { [weak self] result in
            switch result {
            case let .success(dto):
                self?.handleVehicles(dto: dto)
            case let .failure(error):
                print(error)
            }
        }
    }
}

extension HomePresenter {
    private func handleVehicles(dto: VehiclesResponseDTO) {
        let viewModels = mapVehicles(dto: dto)
        didReceiveVehicles?(viewModels)
    }

    private func mapVehicles(dto: VehiclesResponseDTO) -> [HomeModel.VehicleViewModel] {
        dto.data.map { vehicleDto in
            HomeModel.VehicleViewModel(
                annotation: HomeModel.VehicleAnnotation(
                    coordinate: CLLocationCoordinate2D(latitude: vehicleDto.attributes.lat, longitude: vehicleDto.attributes.lng),
                    icon: icon(for: vehicleDto.attributes.vehicleType)
                ),
                type: vehicleDto.attributes.vehicleType
            )
        }
    }

    private func icon(for vehicleType: VehicleType) -> UIImage {
        switch vehicleType {
        case .escooter:
            return Asset.Icons.scooterIcon.image
        case .emoped:
            return Asset.Icons.scooterIcon.image
        case .ebicycle:
            return Asset.Icons.scooterIcon.image
        case .unknown:
            return Asset.Icons.scooterIcon.image
        }
    }
}
