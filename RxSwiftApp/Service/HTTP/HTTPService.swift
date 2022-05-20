import Alamofire

protocol HTTPService {
    
    var session : Session { get set }
    func request(_ urlRequest : URLRequestConvertible) -> DataRequest
}
