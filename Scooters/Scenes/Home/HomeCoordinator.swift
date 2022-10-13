import UIKit

protocol HomeCoordinatorProtocol {
    func start(in navigationController: UINavigationController)
}

final class HomeCoordinator: HomeCoordinatorProtocol {
    private let homeViewController: HomeViewController

    init(homeViewController: HomeViewController) {
        self.homeViewController = homeViewController
    }

    func start(in navigationController: UINavigationController) {
        navigationController.setViewControllers([homeViewController], animated: false)
    }
}
