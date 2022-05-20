import Alamofire

class ModelHTTPService: HTTPService {
    
    var session: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return session.request(urlRequest).validate(statusCode: 200..<400)
    }
}
