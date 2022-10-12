import Swinject

// swiftlint:disable identifier_name
struct HomeAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeCoordinatorProtocol.self) { r in
            HomeCoordinator(homeViewController: r.resolve(HomeViewController.self)!)
        }
        container.register(HomePresenterProcotol.self) { _ in
            HomePresenter()
        }
        container.register(HomeViewController.self) { r in
            HomeViewController(presenter: r.resolve(HomePresenterProcotol.self)!)
        }
    }
}
