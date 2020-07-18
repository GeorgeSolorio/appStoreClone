//
//  DimissNavigationController.swift
//  appStoreClone
//
//  Created by George Solorio on 7/17/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit

class DimissNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1
    }
}
