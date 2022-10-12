import UIKit

protocol HomeCoordinatorProtocol {
    func start(in viewController: UIViewController)
}

final class HomeCoordinator: HomeCoordinatorProtocol {
    private let homeViewController: HomeViewController

    init(homeViewController: HomeViewController) {
        self.homeViewController = homeViewController
    }

    func start(in viewController: UIViewController) {
        viewController.add(childViewController: homeViewController)
    }
}
