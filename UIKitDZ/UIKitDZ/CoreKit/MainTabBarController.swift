//
//  MainTabBarController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 09.10.2022.
//

import UIKit

/// ТабБарКонтроллер
final class MainTabBarController: UITabBarController {

    // MARK: - Lifeсycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private methods
    
    private func setupUI() {
        let changeLabelViewController = ChangeLabelViewController()
        let fineViewController = FineViewController()

        let changeNavigationViewController = UINavigationController(
            rootViewController: changeLabelViewController
        )
        let fineNavigationController = UINavigationController(
            rootViewController: fineViewController
        )
        
        changeLabelViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        fineViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        tabBar.backgroundColor = .secondarySystemBackground

        viewControllers = [
            changeNavigationViewController,
            fineNavigationController
        ]
    }
}
