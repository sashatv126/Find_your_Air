import RxSwift
import RxCocoa
import RxRelay
import RxDataSources

protocol GlobalViewModelProtocol {
    
    typealias Input = (
        weight : Driver<Double>, ()
    )
    
    typealias Output = (
        cost : Driver<Double>, ()
    )
    
    typealias ViewModelBuilder = (GlobalViewModelProtocol.Input) -> GlobalViewModelProtocol
    
    var input : GlobalViewModelProtocol.Input { get }
    var output : GlobalViewModelProtocol.Output { get }
}

final class GlobalViewModel : GlobalViewModelProtocol {

    var input: GlobalViewModelProtocol.Input
    var output: GlobalViewModelProtocol.Output
    private let bag = DisposeBag()
    
    init(input : GlobalViewModelProtocol.Input) {
        self.input = input
        self.output = GlobalViewModel.output(input: self.input, bag : bag)
    }
    
}

private extension GlobalViewModel {
    
    static func output(input : GlobalViewModelProtocol.Input, bag : DisposeBag) -> GlobalViewModelProtocol.Output {
        
        
        let price = input
            .weight
            .asObservable()
        
        let output = price
            .map({
                Weight(bagWeight: $0)
            })
            .map({
                return getWeight($0)
            })
            .asDriver(onErrorJustReturn: 0.0)
        
        
        return (
            cost : output, ()
            )
    }
    
    static func getWeight(_ input : Weight) -> Double {
        
        let price = input.bagWeight/2 * input.perKg
        return price
    }
}


