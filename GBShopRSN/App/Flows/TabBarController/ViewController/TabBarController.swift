//
//  TabBarController.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 05.03.2021.
//

import UIKit

class TabBarController: UITabBarController {
    let requestFactory: RequestFactory
    
    // MARK: - Init
    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
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
    
    func configureTabBarController() {
        self.tabBar.tintColor = .rsnPurpleColor
    }
    func createViewControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()
        
        //1. UserInfoScreenViewController
        let userInfoScreenViewController = UserInfoScreenViewController(requestFactory: requestFactory)
        userInfoScreenViewController.tabBarItem = UITabBarItem(title: "User info", image: UIImage(systemName: "person.circle"), selectedImage: UIImage(systemName: "person.circle.fill"))
        
        let userInfoNavigationController = UINavigationController(rootViewController: userInfoScreenViewController)
        userInfoNavigationController.navigationBar.tintColor = .rsnPurpleColor
        userInfoNavigationController.navigationBar.barTintColor = .rsnLightBlueColor
        userInfoNavigationController.navigationBar.prefersLargeTitles = false;
        
        viewControllers.append(userInfoNavigationController)
        
        return viewControllers
    }
}
