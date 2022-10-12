import Alamofire
import Foundation

protocol NetworkClientProtocol {
    func request<T: Encodable, U: Decodable>(
        url: URL,
        method: HTTPMethod,
        parameters: T?,
        encoder: ParameterEncoder,
        completion: @escaping ((Result<U, Error>) -> Void)
    )
}

final class NetworkClient: NetworkClientProtocol {
    private let session = Session()

    func request<T: Encodable, U: Decodable>(
        url: URL,
        method: HTTPMethod,
        parameters: T?,
        encoder: ParameterEncoder = JSONParameterEncoder.default,
        completion: @escaping ((Result<U, Error>) -> Void)
    ) {
        session
            .request(url, method: method, parameters: parameters, encoder: encoder)
            .cURLDescription(calling: { description in
                print(description)
            })
            .validate()
            .responseDecodable(of: U.self) { dataResponse in
                switch dataResponse.result {
                case let .success(value):
                    completion(.success(value))
                case let .failure(afError):
                    completion(.failure(afError))
                }
            }
    }
}

extension NetworkClient {
    private func debugLog(data: Data) {
        guard
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
            let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        else {
            return
        }
        print(String(decoding: jsonData, as: UTF8.self))
    }
}
