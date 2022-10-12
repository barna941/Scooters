import UIKit

extension UIViewController {
    func add(childViewController: UIViewController) {
        addChild(childViewController)
        view.addSubview(childViewController.view)
        view.fill(with: childViewController.view)
        childViewController.didMove(toParent: self)
    }
}
