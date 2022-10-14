import UIKit

final class AppCoordinator {
    private let window: UIWindow?
    private let rootNavigationController = UINavigationController()

    init(window: UIWindow?) {
        self.window = window
    }

    func start() {
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
        let homeCoordinator = Dependencies.resolver.resolve(HomeCoordinatorProtocol.self, argument: rootNavigationController)!
        homeCoordinator.start()
        configureNavBarAppearance()
    }
}

extension AppCoordinator {
    private func configureNavBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Asset.Colors.primaryBackground.color
        appearance.titleTextAttributes = [
            .foregroundColor: Asset.Colors.textPrimary.color as Any,
            .font: Fonts.font(with: .bold, size: .heading)
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
