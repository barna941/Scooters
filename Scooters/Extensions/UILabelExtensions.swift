import UIKit

extension UILabel {
    @discardableResult
    func with(font type: Fonts.FontType, size: Fonts.FontSize) -> Self {
        self.font = Fonts.font(with: type, size: size)
        return self
    }

    @discardableResult
    func with(textColor: UIColor) -> Self {
        self.textColor = textColor
        return self
    }
}
