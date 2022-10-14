import Foundation

protocol VehicleDetailsPresenterProcotol: AnyObject {
    var vehicleReceived: ((VehicleDetailsViewModel) -> Void)? { get set }

    func viewDidLoad()
}

final class VehicleDetailsPresenter: VehicleDetailsPresenterProcotol {
    private let interactor: VehicleDetailsInteractorProtocol
    private var viewModel: VehicleDetailsViewModel?

    var vehicleReceived: ((VehicleDetailsViewModel) -> Void)?

    init(interactor: VehicleDetailsInteractorProtocol) {
        self.interactor = interactor

        interactor.didFindClosestVehicle = { [weak self] vehicle in
            self?.handleClosestVehicle(vehicle: vehicle)
        }
    }

    func viewDidLoad() {
        interactor.requestLocationAuthorizationIfNeeded()
    }
}

extension VehicleDetailsPresenter {
    private func handleClosestVehicle(vehicle: VehicleDTO) {
        guard vehicle.id != viewModel?.id else {
            return
        }
        let vehicleViewModel = VehicleDetailsViewModel(
            id: vehicle.id,
            type: vehicle.attributes.vehicleType.title,
            batteryLevel: "\(vehicle.attributes.batteryLevel)\(L10n.percent)",
            helmetBoxText: vehicle.attributes.hasHelmetBox ? L10n.vehicleDetailsHasHelmetbox : L10n.vehicleDetailsHasNoHelmetbox,
            maxSpeed: "\(vehicle.attributes.maxSpeed) \(L10n.kilometersPerHour)"
        )
        vehicleReceived?(vehicleViewModel)
        viewModel = vehicleViewModel
    }
}
