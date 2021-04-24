//
//  TabBarController.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 05.03.2021.
//

import UIKit

class TabBarController: UITabBarController {
    // MARK: - Properties
    private let requestFactory: RequestFactory
    private let user: User
    
    // MARK: - Init
    init(requestFactory: RequestFactory, user: User) {
        self.requestFactory = requestFactory
        self.user = user
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = createViewControllers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarController()
    }
    
    //MARK: - Configuration Methods
    func configureTabBarController() {
        self.tabBar.tintColor = .rsnPurpleColor
    }
    
    func createViewControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()
        
        //1. ProductListScreen
        let productListScreenViewController = ProductListScreenViewController(requestFactory: requestFactory, user: user)
        productListScreenViewController.tabBarItem = UITabBarItem(title: "Product", image: UIImage(systemName: "cube.box"), selectedImage: UIImage(systemName: "cube.box.fill"))
        
        let productListNavigationController = UINavigationController(rootViewController: productListScreenViewController)
        productListNavigationController.navigationBar.tintColor = .rsnPurpleColor
        productListNavigationController.navigationBar.barTintColor = .rsnLightBlueColor
        productListNavigationController.navigationBar.prefersLargeTitles = false;
        
        viewControllers.append(productListNavigationController)
        
        //2. BasketScreen
        let basketScreenViewController = BasketScreenViewController(requestFactory: requestFactory, user: user)
        basketScreenViewController.tabBarItem = UITabBarItem(title: "Basket", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
        
        let basketNavigationController = UINavigationController(rootViewController: basketScreenViewController)
        basketNavigationController.navigationBar.tintColor = .rsnPurpleColor
        basketNavigationController.navigationBar.barTintColor = .rsnLightBlueColor
        basketNavigationController.navigationBar.prefersLargeTitles = false;
        
        viewControllers.append(basketNavigationController)
        
        //3. UserInfoScreen
        let userInfoScreenViewController = UserInfoScreenViewController(requestFactory: requestFactory, user: user)
        userInfoScreenViewController.tabBarItem = UITabBarItem(title: "User info", image: UIImage(systemName: "person.circle"), selectedImage: UIImage(systemName: "person.circle.fill"))
        
        let userInfoNavigationController = UINavigationController(rootViewController: userInfoScreenViewController)
        userInfoNavigationController.navigationBar.tintColor = .rsnPurpleColor
        userInfoNavigationController.navigationBar.barTintColor = .rsnLightBlueColor
        userInfoNavigationController.navigationBar.prefersLargeTitles = false;
        
        viewControllers.append(userInfoNavigationController)
        
        return viewControllers
    }
}
