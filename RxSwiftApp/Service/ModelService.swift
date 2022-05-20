import RxSwift

class ModelService {
    
    private lazy var httpService = ModelHTTPService()
    static let shared : ModelService = ModelService()
}

extension ModelService : ModelAPI {
    
    func fetchModel() -> Single<[ModelResponseElement]> {
        
        return Single.create { [httpService] (single) -> Disposable in
            
            do {
                try  ModelHTTPRouter
                    .getModels
                    .request(usingHTTPService: httpService)
                    .responseJSON {(result) in
                    
                    guard let data = result.data else { return }
                    
                    do {
                        let model = try JSONDecoder().decode(
                            [ModelResponseElement].self, from: data)
                        single(.success(model))
                        print("Airports: \(model)")
                    } catch {
                        print("NO (")
                    }
            
                }
            } catch {
                
            }
            
           
            
            return Disposables.create()
        }
    }

}
