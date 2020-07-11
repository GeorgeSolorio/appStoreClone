//
//  ReviewCell.swift
//  appStoreClone
//
//  Created by George Solorio on 7/11/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {
    
    let reviewController = ReviewsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow
        addSubview(reviewController.view)
        reviewController.view.fillSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
