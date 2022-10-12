import UIKit

final class HomeViewController: UIViewController {
    private let presenter: HomePresenterProcotol

    init(presenter: HomePresenterProcotol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Asset.Colors.accent.color
    }
}
