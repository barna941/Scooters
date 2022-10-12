import Foundation

protocol ScootersApiProtocol {
}

final class ScootersApi: ScootersApiProtocol {
    private let netwworkClient: NetworkClientProtocol

    init(netwworkClient: NetworkClientProtocol) {
        self.netwworkClient = netwworkClient
    }
}
