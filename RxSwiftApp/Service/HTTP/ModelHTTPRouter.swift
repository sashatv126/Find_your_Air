import Alamofire

enum ModelHTTPRouter {
    
    case getModels
}

extension ModelHTTPRouter : HTTPRouter {
    
    var baseUrlString: String {
        return "http://gist.githubusercontent.com/tdreyno/4278655/raw/7b0762c09b519f40397e4c3e100b097d861f5588"
    }
    
    var path: String {
        switch self {
        case .getModels:
           return "airports.json"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getModels:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    func body() throws -> Data? {
        return nil
    }
}
