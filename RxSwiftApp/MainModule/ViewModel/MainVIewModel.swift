import Foundation
import RxCocoa
import RxSwift

protocol MainVIewModelProtocol {
    typealias Input = (
        searchText : Driver<String>, ()
    )
    typealias Output = ()
    typealias ViewModelBuilder = (MainVIewModelProtocol.Input) -> MainVIewModelProtocol
    
    var input : MainVIewModelProtocol.Input { get }
    var output : MainVIewModelProtocol.Output { get }
}

final class MainVIewModel: MainVIewModelProtocol {
    
    var input: MainVIewModelProtocol.Input
    var output: MainVIewModelProtocol.Output
    private let api : ModelAPI
    private let bag = DisposeBag()
    
    init(input : MainVIewModelProtocol.Input, api : ModelAPI) {
        self.input = input
        self.output = MainVIewModel.output(input : self.input)
        self.api = api
        self.process()
    }
}

private extension MainVIewModel {
    
    static func output(input : MainVIewModelProtocol.Input) -> MainVIewModelProtocol.Output {
        
        return ()
    }
    
    func process() -> Void {
        
        self.api
            .fetchModel()
            .map({ (model) in
                print("Airports: \(model)")
            })
            .subscribe()
            .disposed(by: bag)
    }
    
    
    func get() {
            let urlstr = "https://gist.githubusercontent.com/tdreyno/4278655/raw/7b0762c09b519f40397e4c3e100b097d861f5588/airports.json"
        NetworkService.shared.loadData(url : urlstr,complition: {(result : Result<[ModelResponseElement]?,Error>) -> Void in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let stations) :
                        print(stations)
                    case .failure(let error) :
                        print("FUCJ \(error)")
                    }
                }
            })
        }
}
