import Foundation

protocol LoadingPresenterProtocol: AnyObject {
    var updateLoadingVisibility: ((_ show: Bool) -> Void)? { get set }
}
