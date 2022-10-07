//
//  SceneDelegate.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 21.09.2022.
//

import UIKit
/// SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let changeLabelViewController = ChangeLabelViewController()
        let fineViewController = FineViewController()
        
        changeLabelViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        fineViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let changeNavigationViewController = UINavigationController(
            rootViewController: changeLabelViewController
        )
        let fineNavigationController = UINavigationController(
            rootViewController: fineViewController
        )
        
        let tabBarViewController = UITabBarController()
        
        tabBarViewController.setViewControllers(
            [changeNavigationViewController, fineNavigationController],
            animated: true
        )
        window?.rootViewController = tabBarViewController
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        
    }
}
