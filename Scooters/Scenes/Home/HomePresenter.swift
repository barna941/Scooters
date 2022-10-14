import MapKit

protocol HomePresenterProcotol: ErrorPresenterProtocol, LoadingPresenterProtocol {
    var vehiclesReceived: (([HomeModel.VehicleViewModel]) -> Void)? { get set }

    func viewDidLoad()
}

final class HomePresenter: HomePresenterProcotol {
    private let interactor: HomeInteractorProtocol

    var vehiclesReceived: (([HomeModel.VehicleViewModel]) -> Void)?
    var errorReceived: ((PresentableError) -> Void)?
    var updateLoadingVisibility: ((Bool) -> Void)?

    init(interactor: HomeInteractorProtocol) {
        self.interactor = interactor
    }

    func viewDidLoad() {
        updateLoadingVisibility?(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.interactor.fetchVehicles { [weak self] result in
                self?.updateLoadingVisibility?(false)
                switch result {
                case let .success(dto):
                    self?.handleVehicles(dto: dto)
                case .failure:
                    self?.errorReceived?(.network)
                }
            }
        }
    }
}

extension HomePresenter {
    private func handleVehicles(dto: VehiclesResponseDTO) {
        let viewModels = mapVehicles(dto: dto)
        vehiclesReceived?(viewModels)
    }

    private func mapVehicles(dto: VehiclesResponseDTO) -> [HomeModel.VehicleViewModel] {
        dto.data.map { vehicleDto in
            HomeModel.VehicleViewModel(
                annotation: HomeModel.VehicleAnnotation(
                    coordinate: CLLocationCoordinate2D(latitude: vehicleDto.attributes.lat, longitude: vehicleDto.attributes.lng),
                    icon: vehicleDto.attributes.vehicleType.icon
                ),
                type: vehicleDto.attributes.vehicleType
            )
        }
    }
}
