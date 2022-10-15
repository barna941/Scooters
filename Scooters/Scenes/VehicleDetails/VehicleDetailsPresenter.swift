import Foundation

protocol VehicleDetailsPresenterProcotol: AnyObject {
    var viewModelReceived: ((VehicleDetailsViewModel) -> Void)? { get set }
    var authorizationStatusDisabled: (() -> Void)? { get set }
}

final class VehicleDetailsPresenter: VehicleDetailsPresenterProcotol {
    private let interactor: VehicleDetailsInteractorProtocol
    private var vehicle: VehicleDetailsViewModel.Vehicle?

    var viewModelReceived: ((VehicleDetailsViewModel) -> Void)?
    var authorizationStatusDisabled: (() -> Void)?

    init(interactor: VehicleDetailsInteractorProtocol) {
        self.interactor = interactor

        interactor.didFindClosestVehicle = { [weak self] vehicle in
            self?.handleClosestVehicle(vehicleDto: vehicle)
        }
        interactor.authorizationStatusDisabled = { [weak self] in
            self?.viewModelReceived?(.disabled)
        }
    }
}

extension VehicleDetailsPresenter {
    private func handleClosestVehicle(vehicleDto: VehicleDTO) {
        guard vehicle?.id != vehicleDto.id else {
            return
        }
        let vehicle = VehicleDetailsViewModel.Vehicle(
            id: vehicleDto.id,
            type: vehicleDto.attributes.vehicleType.title,
            batteryLevel: "\(vehicleDto.attributes.batteryLevel)\(L10n.percent)",
            helmetBoxText: vehicleDto.attributes.hasHelmetBox ? L10n.vehicleDetailsHasHelmetbox : L10n.vehicleDetailsHasNoHelmetbox,
            maxSpeed: "\(vehicleDto.attributes.maxSpeed) \(L10n.kilometersPerHour)"
        )
        viewModelReceived?(.enabled(vehicle: vehicle))
        self.vehicle = vehicle
    }
}
