import UIKit
import Foundation

class SecondCoordinator : BaseCoordinator {
    
    private let navigationController : UINavigationController?
    
    init(navigationController : UINavigationController?) {
        self.navigationController = navigationController
    }
    
    override func start() {
        
        let vc1 = MainViewController.instantiate()
        let service = ModelService.shared
        
        vc1.viewModelBuilder = {
            MainVIewModel(input: $0, api: service)
        }
        
        navigationController?.pushViewController(vc1, animated: true)
    }
}

