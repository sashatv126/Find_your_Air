import UIKit

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage?
}

class TabCoordinator: NSObject, Coordinator {
    
    var childCoordinator: [Coordinator] = []

    var navigationController: UINavigationController
    
    var tabBarController: UITabBarController

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }

    func start() {
        
        let pages: [TabBarPage] = [.go, .steady, .ready]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        
        prepareTabBarController(withTabControllers: controllers)
    }
    
    deinit {
        print("TabCoordinator deinit")
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.ready.pageOrderNumber()
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.barTintColor = UIColor(red: 14/255.0,
                                                       green: 15/255.0,
                                                       blue: 13/255.0,
                                                       alpha: 1.0)
        navigationController.isNavigationBarHidden = true
        navigationController.viewControllers = [tabBarController]
    }
      
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController : UINavigationController = {
            
            let navigationController = UINavigationController()
            let navBar = navigationController.navigationBar
            navBar.setBackgroundImage(UIImage(), for: .default)
            navBar.shadowImage = UIImage()
            navBar.barTintColor = UIColor(red: 14/255.0,
                                          green: 15/255.0,
                                          blue: 13/255.0,
                                          alpha: 1.0)
            navBar.tintColor = .white
            navBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: "Avenir-Medium", size: 28.0)!,
            NSAttributedString.Key.foregroundColor : UIColor.white]
            navBar.isTranslucent = false
            
            return navigationController
        }()
    
        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                             image: UIImage(named: "Vector-2"),
                                                             tag: page.pageOrderNumber())
        
        switch page {
        case .ready:
            let vc1 = MainViewController.instantiate()
            let service = ModelService.shared
            
            vc1.viewModelBuilder = {
                MainVIewModel(input: $0, api: service)
            }
                        
            navController.pushViewController(vc1, animated: true)
        case .steady:
            let vc2 = MainViewController.instantiate()
            let service = ModelService.shared
            
            vc2.viewModelBuilder = {
                MainVIewModel(input: $0, api: service)
            }
            
            navController.pushViewController(vc2, animated: true)
        case .go:
            let vc3 = MainViewController.instantiate()
            let service = ModelService.shared
            
            vc3.viewModelBuilder = {
                MainVIewModel(input: $0, api: service)
            }
            
            navController.pushViewController(vc3, animated: true)
        }
        
        return navController
    }
    
    func currentPage() -> TabBarPage? { TabBarPage.init(index: tabBarController.selectedIndex) }

    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }
        
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}

// MARK: - UITabBarControllerDelegate
extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
    }
}

