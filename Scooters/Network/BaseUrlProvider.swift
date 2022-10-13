import Foundation

protocol BaseUrlProviderProtocol {
    var baseUrl: URL { get }
}

final class BaseUrlProvider: BaseUrlProviderProtocol {
    var baseUrl: URL {
        let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String
        return URL(string: baseUrl ?? "")!
    }
}
