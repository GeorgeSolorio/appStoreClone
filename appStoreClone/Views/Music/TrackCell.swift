//
//  TrackCell.swift
//  appStoreClone
//
//  Created by George Solorio on 7/31/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit

class TrackCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 16)
    let nameLabel = UILabel(text: "Track name", font: .boldSystemFont(ofSize: 18))
    let subtitleLabel = UILabel(text: "subtitle Label", font: .systemFont(ofSize: 16), numberOfLines: 2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.image = #imageLiteral(resourceName: "garden")
        imageView.constraintWidth(constant: 80)
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            VerticalStackView(arrangedSubviews: [
                nameLabel,
                subtitleLabel
            ], spacing: 16)
        ], customSpacing: 16)
        
        addSubview(stackView)
        stackView.fillSuperView(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        stackView.alignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
