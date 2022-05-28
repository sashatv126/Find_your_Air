import UIKit

class AppCoordinator: BaseCoordinator {
    
    private let window : UIWindow
    
    private let navigationController : UINavigationController = {
        let navigationController = UINavigationController()
        
        return navigationController
    }()
    
    init(window : UIWindow) {
        self.window = window
    }
    
    override func start() {
        
        let mainCoordinator = TabCoordinator(navigationController)
        self.add(coordinator: mainCoordinator)
        
        mainCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
