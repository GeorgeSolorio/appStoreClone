//
//  AppRowCell.swift
//  appStoreClone
//
//  Created by George Solorio on 7/7/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit

class AppRowCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 8)
    let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    let getButton = UIButton(title: "GET")
    var app: FeedResult! {
        didSet {
            imageView.sd_setImage(with: URL(string: app.artworkUrl100))
            nameLabel.text = app.name
            companyLabel.text = app.artistName
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.backgroundColor = .purple
        imageView.constraintWidth(constant: 64)
        imageView.constraintHeight(constant: 64)
        
        getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
        getButton.constraintWidth(constant: 80)
        getButton.constraintHeight(constant: 32)
        getButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        getButton.layer.cornerRadius = 32 / 2
        
        let stackView = UIStackView(arrangedSubviews: [imageView, VerticalStackView(arrangedSubviews: [nameLabel, companyLabel], spacing: 4), getButton])
        stackView.spacing = 16
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
