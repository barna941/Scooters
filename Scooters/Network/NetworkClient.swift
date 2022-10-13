import Alamofire
import Foundation

protocol NetworkClientProtocol {
    func request<T: Encodable, U: Decodable>(
        url: URL,
        method: HTTPMethod,
        parameters: T?,
        encoder: ParameterEncoder?,
        completion: @escaping ((Result<U, Error>) -> Void)
    )
}

extension NetworkClientProtocol {
    func request<U: Decodable>(url: URL, completion: @escaping ((Result<U, Error>) -> Void)) {
        request(url: url, method: .get, parameters: Empty.value, encoder: nil, completion: completion)
    }
}

final class NetworkClient: NetworkClientProtocol {
    private let session = Session(interceptor: ClientInterceptor())

    func request<T: Encodable, U: Decodable>(
        url: URL,
        method: HTTPMethod,
        parameters: T?,
        encoder: ParameterEncoder?,
        completion: @escaping ((Result<U, Error>) -> Void)
    ) {
        session
            .request(url, method: method, parameters: parameters, encoder: encoder ?? URLEncodedFormParameterEncoder.default)
            .cURLDescription(calling: { description in
                #if DEBUG
                print(description)
                #endif
            })
            .validate()
            .responseDecodable(of: U.self) { [weak self] dataResponse in
                self?.debugLogResponse(data: dataResponse.data)
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
    private func debugLogResponse(data: Data?) {
        #if DEBUG
        guard
            let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
            let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        else {
            return
        }
        print(String(decoding: jsonData, as: UTF8.self))
        #endif
    }
}
