import Foundation

protocol ErrorPresenterProtocol: AnyObject {
    var errorReceived: ((PresentableError) -> Void)? { get set }
}

enum PresentableError {
    case network
    case other

    var title: String {
        switch self {
        case .network:
            return L10n.networkError
        case .other:
            return L10n.otherError
        }
    }
}
