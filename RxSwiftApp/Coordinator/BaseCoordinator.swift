import Foundation

class BaseCoordinator : Coordinator {
    
    var childCoordinator: [Coordinator] = []
    
    func start() {
        fatalError("Children coordinators should implement 'start'.")
    }
    
}
