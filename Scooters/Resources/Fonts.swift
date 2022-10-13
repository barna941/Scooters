import UIKit

struct Fonts {
    enum FontType {
        case regular
        case bold
    }

    enum FontSize {
        case heading
        case body1
        case body2
        var value: CGFloat {
            switch self {
            case .heading:
                return 20
            case .body1:
                return 18
            case .body2:
                return 16
            }
        }
    }

    static func font(with type: FontType, size: FontSize) -> UIFont {
        switch type {
        case .regular:
            return UIFont.systemFont(ofSize: size.value)
        case .bold:
            return UIFont.boldSystemFont(ofSize: size.value)
        }
    }
}
