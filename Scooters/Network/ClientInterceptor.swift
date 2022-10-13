import Alamofire

final class ClientInterceptor: RequestInterceptor {
    func retry(_ request: Alamofire.Request, for session: Alamofire.Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let responseCode = (error as? AFError)?.responseCode else {
            completion(.doNotRetry)
            return
        }
        switch responseCode {
        case 503 where request.retryCount < 3:
            completion(.retryWithDelay(2))
        default:
            completion(.doNotRetry)
        }
    }
}
