//
//  appsSearchControllerCollectionViewController.swift
//  appStoreClone
//
//  Created by George Solorio on 6/29/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class appsSearchController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .red
    }

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
