import RxSwift

protocol ModelAPI {
    
    func fetchModel() -> Single<ModelResponse>
}
