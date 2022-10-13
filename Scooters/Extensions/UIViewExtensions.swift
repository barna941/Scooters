import UIKit

extension UIView {
    func fill(with subview: UIView) {
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor),
            subview.topAnchor.constraint(equalTo: topAnchor),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @discardableResult
    func usingAutoLayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
