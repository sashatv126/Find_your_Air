import RxCocoa
import RxSwift
import RxRelay
import RxDataSources

protocol MainVIewModelProtocol {
    
    typealias Input = (
        searchText : Driver<String>, ()
    )
    
    typealias Output = (
        cities : Driver<[CityItemsSection]>, ()
    )
    
    typealias ViewModelBuilder = (MainVIewModelProtocol.Input) -> MainVIewModelProtocol
    
    var input : MainVIewModelProtocol.Input { get }
    var output : MainVIewModelProtocol.Output { get }
}

final class MainVIewModel: MainVIewModelProtocol {
    
    var input: MainVIewModelProtocol.Input
    var output: MainVIewModelProtocol.Output
    private let api : ModelAPI
    private let bag = DisposeBag()
    typealias State = (airports : BehaviorRelay<Set<ModelResponseElement>>, ())
    private let state : State = (airports : BehaviorRelay<Set<ModelResponseElement>>(value: []), ())
    
    init(input : MainVIewModelProtocol.Input, api : ModelAPI) {
        self.input = input
        self.output = MainVIewModel.output(input: self.input,
                                           state: self.state)
        self.api = api
        self.process()
    }
}

private extension MainVIewModel {
    
    static func output(input : MainVIewModelProtocol.Input,
                       state : State) -> MainVIewModelProtocol.Output {
        
        let search = input
            .searchText
            .debounce(.milliseconds(300))
            .distinctUntilChanged()
            .skip(1)
            .asObservable()
            .share(replay: 1, scope: .whileConnected)
        
        let airports = state
            .airports
            .skip(1)
            .asObservable()
        
        let sections = Observable
            .combineLatest(
                search,airports
            )
            .map { (searh, airport) in
                
                return airport.filter { (airports) -> Bool in
                    !searh.isEmpty &&
                        airports.city
                        .lowercased()
                        .replacingOccurrences(of: " ", with: "")
                        .hasPrefix(searh.lowercased())
                }
            }
            .map {
                MainVIewModel.uniqueElementFrom(array: $0
                                                    .compactMap({CityViewModel(model: $0)}))
            }
            .map {
                [CityItemsSection(model: 0, items: $0)]
            }
            .asDriver(onErrorJustReturn: [])
        
        return (
            cities : sections, ()
        )
    }
    
    func process() -> Void {
        
        self.api
            .fetchModel()
            .map({ Set($0) })
            .map({ [state] in state.airports.accept($0)
            })
            .subscribe()
            .disposed(by: bag)
    }
    
    
    func get() {
        
        let urlstr = "https://gist.githubusercontent.com/tdreyno/4278655/raw/7b0762c09b519f40397e4c3e100b097d861f5588/airports.json"
        NetworkService.shared.loadData(url : urlstr,complition: {(result : Result<[ModelResponseElement]?,Error>) -> Void in
            
            DispatchQueue.main.async {
                switch result {
                
                case .success(_) :
                    break
                case .failure(let error) :
                    
                    print(error.localizedDescription)
                }
            }
        })
    }
}

private extension MainVIewModel {
    
    static func uniqueElementFrom(array : [CityViewModel]) -> [CityViewModel] {
        
        var set = Set<CityViewModel>()
        let result = array.filter{
            
            guard !set.contains($0) else {
                
                return false
            }
            set.insert($0)
            
            return true
        }
        return result
    }
}
