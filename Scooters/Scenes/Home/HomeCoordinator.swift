import UIKit

protocol HomeCoordinatorProtocol {
    func start()
}

final class HomeCoordinator: HomeCoordinatorProtocol {
    private let rootNavigationController: UINavigationController
    private let homeViewController: HomeViewController

    init(rootNavigationController: UINavigationController, homeViewController: HomeViewController) {
        self.rootNavigationController = rootNavigationController
        self.homeViewController = homeViewController
    }

    func start() {
        rootNavigationController.setViewControllers([homeViewController], animated: false)
        showVehicleDetailsSheet()
    }
}

extension HomeCoordinator {
    private func showVehicleDetailsSheet() {
        let viewController = Dependencies.resolver.resolve(VehicleDetailsViewController.self)!
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .pageSheet
        navController.isModalInPresentation = true

        let sheet = navController.sheetPresentationController
        sheet?.detents = [.medium()]
        sheet?.selectedDetentIdentifier = .medium
        sheet?.largestUndimmedDetentIdentifier = .medium
        sheet?.prefersGrabberVisible = true
        sheet?.preferredCornerRadius = 16

        rootNavigationController.present(navController, animated: true)
    }
}
