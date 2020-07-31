//
//  MusicLoadingFooter.swift
//  appStoreClone
//
//  Created by George Solorio on 7/31/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit

class MusicLoadingFooter: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let aiv = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        aiv.color = .darkGray
        aiv.startAnimating()
        
        let label = UILabel(text: "Loading more...", font: .systemFont(ofSize: 16))
        label.textAlignment = .center
        
        let stackView = VerticalStackView(arrangedSubviews: [
            aiv, label
        ], spacing: 8)
        
        addSubview(stackView)
        stackView.centerInSuperView(size: .init(width: 200, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

