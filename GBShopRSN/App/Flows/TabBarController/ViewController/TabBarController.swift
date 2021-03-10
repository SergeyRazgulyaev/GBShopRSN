//
//  TabBarController.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 05.03.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Init
    init() {
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
        self.tabBar.tintColor = UIColor(red: 120.0/255.0,
                                        green: 80.0/255.0,
                                        blue: 155.0/255.0,
                                        alpha: 1.0)
    }
    func createViewControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()
        
        //1. UserInfoScreenViewController
        let userInfoScreenViewController = UserInfoScreenViewController()
        userInfoScreenViewController.tabBarItem = UITabBarItem(title: "User info", image: UIImage(systemName: "person.circle"), selectedImage: UIImage(systemName: "person.circle.fill"))
        
        let userInfoNavigationController = UINavigationController(rootViewController: userInfoScreenViewController)
        userInfoNavigationController.navigationBar.tintColor = UIColor(red: 120.0/255.0,
                                                                       green: 80.0/255.0,
                                                                       blue: 155.0/255.0,
                                                                       alpha: 1.0)
        userInfoNavigationController.navigationBar.barTintColor = UIColor(red: 100.0/255.0,
                                                                        green: 180.0/255.0,
                                                                        blue: 220.0/255.0,
                                                                        alpha: 1.0)
        userInfoNavigationController.navigationBar.prefersLargeTitles = false;
        
        viewControllers.append(userInfoNavigationController)
        
        return viewControllers
    }
}
