import UIKit

class AppCoordinator: BaseCoordinator {
    
    private let window : UIWindow
    
    private let navigationController : UINavigationController = {
        let navigationController = UINavigationController()
        
        let navBar = navigationController.navigationBar
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.barTintColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        navBar.tintColor = .white
        navBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: "Avenir-Medium", size: 28.0)!,
        NSAttributedString.Key.foregroundColor : UIColor.white]
        navBar.isTranslucent = false
        
        return navigationController
    }()
    
    init(window : UIWindow) {
        self.window = window
    }
    
    override func start() {
        
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        self.add(coordinator: mainCoordinator)
        
        mainCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
