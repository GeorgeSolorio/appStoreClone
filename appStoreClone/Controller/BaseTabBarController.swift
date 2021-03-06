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
        let musicController = createNavController(viewController: MusicController(), title: "Music", imageName: "music")
        let todayNavController = createNavController(viewController: TodayController(), title: "Today", imageName: "today_icon")
        let appsNavController = createNavController(viewController: CompositionalController(), title: "Apps", imageName: "apps")
        let searchNavController = createNavController(viewController: AppsSearchController(), title: "Search", imageName: "search")
                
        viewControllers = [
            musicController,
            todayNavController,
            appsNavController,
            searchNavController,
        ]
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white

        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.image = UIImage(named: imageName)
        
        return navController
    }
}
