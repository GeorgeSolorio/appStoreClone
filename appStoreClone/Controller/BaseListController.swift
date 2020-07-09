//
//  BaseListController.swift
//  appStoreClone
//
//  Created by George Solorio on 7/7/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit

// A conveniant class that will provide the initializers to any inhereted object
class BaseListController: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
