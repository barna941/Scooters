import Swinject

// swiftlint:disable identifier_name
struct HomeAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeCoordinatorProtocol.self) { r in
            HomeCoordinator(homeViewController: r.resolve(HomeViewController.self)!)
        }
        container.register(HomePresenterProcotol.self) { r in
            HomePresenter(interactor: r.resolve(HomeInteractorProtocol.self)!)
        }
        container.register(HomeViewController.self) { r in
            HomeViewController(presenter: r.resolve(HomePresenterProcotol.self)!)
        }
        container.register(HomeInteractorProtocol.self) { r in
            HomeInteractor(
                vehiclesApi: r.resolve(VehiclesApiProtocol.self)!,
                locationService: r.resolve(LocationServiceProtocol.self)!
            )
        }
    }
}
