//
//  BaseTabBarController.swift
//  appStoreClone
//
//  Created by George Solorio on 6/27/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let redViewController = UIViewController()
        redViewController.navigationItem.title = "Apps"
        redViewController.view.backgroundColor = .white
        
        let redNavController = UINavigationController(rootViewController: redViewController)
        redNavController.navigationBar.prefersLargeTitles = true
        redNavController.tabBarItem.title = "Apps"
        redNavController.tabBarItem.image = #imageLiteral(resourceName: "apps")
                
        let blueViewController = UIViewController()
        blueViewController.navigationItem.title = "Search"
        blueViewController.view.backgroundColor = .white
        
        let blueNavController = UINavigationController(rootViewController: blueViewController)
        blueNavController.tabBarItem.image = #imageLiteral(resourceName: "search")
        blueNavController.tabBarItem.title = "Search"
        blueNavController.navigationBar.prefersLargeTitles = true
        blueNavController.navigationBar.tintColor = .blue
        
        
        viewControllers = [
            redNavController,
            blueNavController,
        ]
    }
}
