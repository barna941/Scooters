import Swinject

// swiftlint:disable identifier_name
struct VehicleDetailsAssembly: Assembly {
    func assemble(container: Container) {
        container.register(VehicleDetailsPresenterProcotol.self) { r in
            VehicleDetailsPresenter(interactor: r.resolve(VehicleDetailsInteractorProtocol.self)!)
        }
        container.register(VehicleDetailsViewController.self) { r in
            VehicleDetailsViewController(presenter: r.resolve(VehicleDetailsPresenterProcotol.self)!)
        }
        container.register(VehicleDetailsInteractorProtocol.self) { r in
            VehicleDetailsInteractor(
                vehicleRepositoryService: r.resolve(VehicleRepositoryServiceProtocol.self)!,
                locationService: r.resolve(LocationServiceProtocol.self)!,
                vehicleFinderService: r.resolve(VehicleFinderServiceProtocol.self)!
            )
        }
    }
}
