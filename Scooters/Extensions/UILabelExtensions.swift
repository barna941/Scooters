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

    @discardableResult
    func with(text: String) -> Self {
        self.text = text
        return self
    }

    @discardableResult
    func with(textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
}
