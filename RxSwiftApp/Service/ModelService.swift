import RxSwift
import Alamofire

class ModelService {
    
    private lazy var httpService = ModelHTTPService()
    static let shared : ModelService = ModelService()
}

extension ModelService : ModelAPI {
    
    func fetchModel() -> Single<ModelResponse> {
        
        return Single.create { [httpService] (single) -> Disposable in
            
            do {
                try  ModelHTTPRouter
                    .getModels
                    .request(usingHTTPService: httpService)
                    .responseDecodable(completionHandler: { (result : DataResponse<ModelResponse, AFError>) in
                        let data = try? result.result.get()
                        single(.success(data!))
                    })
            } catch {
                single(.failure(error))
            }
            
            return Disposables.create()
        }
    }

}
