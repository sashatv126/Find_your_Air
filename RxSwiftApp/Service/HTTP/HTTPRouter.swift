import Alamofire

protocol HTTPRouter {
    
    var baseUrlString : String { get }
    var path : String { get }
    var method : HTTPMethod { get }
    var headers : HTTPHeaders? { get }
    var parameters : Parameters? { get }
    func body() throws -> Data?
    
    func request(usingHTTPService service : HTTPService) throws -> DataRequest
}

extension HTTPRouter {
    
    var parameters : Parameters? { return nil }
    func body() throws -> Data? { return nil }
    var headers : HTTPHeaders? { return nil }
    
    func urlRequest() throws -> URLRequest {
        var url = try baseUrlString.asURL()
        
        url.appendPathComponent(path)
        
        print(url)
        
        var request = try URLRequest(url: url, method: method, headers: headers)
        request.httpBody = try body()
        
        return request
    }
    
    func request(usingHTTPService service : HTTPService) throws -> DataRequest {
        return try service.request(urlRequest())
    }
}
