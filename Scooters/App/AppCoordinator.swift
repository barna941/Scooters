import UIKit

final class AppCoordinator {
    private let window: UIWindow?
    private let containerViewController = RootContainerViewController()

    init(window: UIWindow?) {
        self.window = window
    }

    func start() {
        window?.rootViewController = containerViewController
        window?.makeKeyAndVisible()
        let homeCoordinator = Dependencies.resolver.resolve(HomeCoordinatorProtocol.self)!
        homeCoordinator.start(in: containerViewController)
    }
}
