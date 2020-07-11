//
//  AppsDetailCell.swift
//  appStoreClone
//
//  Created by George Solorio on 7/9/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit

class AppDetailCell: UICollectionViewCell {

    let appIconImageView = UIImageView(cornerRadius: 16)
    let nameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
    let priceButton = UIButton(title: "$4.99")
    let whatsNewLabel = UILabel(text: "Whats new", font: .boldSystemFont(ofSize: 20))
    let releaseNotesLabel = UILabel(text: "Release Notes", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    var app: Result! {
        didSet {
            nameLabel.text = app?.trackName
            releaseNotesLabel.text = app?.releaseNotes
            appIconImageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
            priceButton.setTitle(app?.formattedPrice, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        appIconImageView.backgroundColor = .red
        appIconImageView.constraintHeight(constant: 140)
        appIconImageView.constraintWidth(constant: 140)
        
        priceButton.backgroundColor = #colorLiteral(red: 0.0857751593, green: 0.4185282588, blue: 0.9467077851, alpha: 1)
        priceButton.constraintHeight(constant: 32)
        priceButton.layer.cornerRadius = 32 / 2
        priceButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        priceButton.setTitleColor(.white, for: .normal)
        priceButton.constraintWidth(constant: 80)
                
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                appIconImageView,
                VerticalStackView(arrangedSubviews: [
                    nameLabel,
                    UIStackView(arrangedSubviews: [priceButton, UIView()]),
                    UIView(),
                ], spacing: 12)
            ], customSpacing: 20),
            whatsNewLabel,
            releaseNotesLabel,
        ], spacing: 16)
        addSubview(stackView)
        stackView.fillSuperView(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}
