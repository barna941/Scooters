import UIKit

protocol ErrorHandlingView: AnyObject {
    func showError(error: PresentableError)
}

extension ErrorHandlingView where Self: UIViewController {
    func showError(error: PresentableError) {
        let alert = UIAlertController(title: error.title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: L10n.okTitle, style: .default))
        present(alert, animated: true, completion: nil)
    }
}
