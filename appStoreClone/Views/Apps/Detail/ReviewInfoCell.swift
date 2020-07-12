//
//  ReviewInfoCell.swift
//  appStoreClone
//
//  Created by George Solorio on 7/11/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit

class ReviewInfoCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Review title", font: .boldSystemFont(ofSize: 18))
    let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))
    let startsLabel = UILabel(text: "Stars", font: .systemFont(ofSize: 16))
    let bodyLabel = UILabel(text: "Review body\nReview body\nReview body\n", font: .systemFont(ofSize: 14), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.9247260094, green: 0.9180413485, blue: 0.9298439622, alpha: 1)
        
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [titleLabel, authorLabel], customSpacing: 8),
            startsLabel,
            bodyLabel,
        ], spacing: 12)
        authorLabel.textAlignment = .right
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        addSubview(stackView)
        stackView.fillSuperView(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
