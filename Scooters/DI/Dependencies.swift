import Alamofire
import Swinject

final class Dependencies {
    private static let dependencies = Dependencies()
    private let container = Container()
}

// swiftlint:disable identifier_name
extension Dependencies {
    static var resolver: Resolver { dependencies.container }

    static func registerServices() {
        let container = dependencies.container
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
