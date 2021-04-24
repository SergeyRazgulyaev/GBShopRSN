//
//  SceneDelegate.swift
//  GBShopRSN
//
//  Created by Sergey Razgulyaev on 14.02.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let baseURL = URL(string: "https://thawing-wildwood-54540.herokuapp.com/")!
        let requestFactory = RequestFactory(baseURL: baseURL)
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let entryViewController = EntranceScreenViewController(requestFactory: requestFactory)
        window?.rootViewController = entryViewController
        window?.makeKeyAndVisible()
    }
}

