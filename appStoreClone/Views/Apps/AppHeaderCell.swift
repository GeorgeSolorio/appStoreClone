//
//  AppHeaderCell.swift
//  appStoreClone
//
//  Created by George Solorio on 7/7/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit

class AppHeaderCell: UICollectionViewCell {
    
    let companyLabel = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 12))
    
    let titleLabel = UILabel(text: "Keeping up with friends is faster than ever", font: .boldSystemFont(ofSize: 24))

    let imageView = UIImageView(cornerRadius: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.backgroundColor = .red
        titleLabel.numberOfLines = 2
        companyLabel.textColor = .blue
        
        let stackView = VerticalStackView(arrangedSubviews: [
            companyLabel, titleLabel, imageView
        ], spacing: 12)
        
        addSubview(stackView)
        stackView.fillSuperView(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

