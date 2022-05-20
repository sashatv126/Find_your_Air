import UIKit
import Foundation

class MainCoordinator : BaseCoordinator {
    
    private let navigationController : UINavigationController?
    
    init(navigationController : UINavigationController?) {
        self.navigationController = navigationController
    }
    
    override func start() {
        
        let view = MainViewController.instantiate()
        
        let service = ModelService.shared
            
        view.viewModelBuilder = {
            MainVIewModel(input: $0, api: service)
        }
        
        navigationController?.pushViewController(view, animated: true)
    }
}
