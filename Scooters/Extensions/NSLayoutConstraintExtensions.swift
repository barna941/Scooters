import UIKit

extension NSLayoutConstraint {
    static func activate(_ constraints: [[NSLayoutConstraint]]) {
        NSLayoutConstraint.activate(constraints.flatMap { $0 })
    }
}
