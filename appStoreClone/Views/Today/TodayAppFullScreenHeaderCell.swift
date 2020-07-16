//
//  AppFullScreenHeaderCell.swift
//  appStoreClone
//
//  Created by George Solorio on 7/15/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit

class TodayAppFullScreenHeaderCell: UITableViewCell {
    
    let todayCell = TodayCell()
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(todayCell)
        todayCell.fillSuperView()

        addSubview(closeButton)
        closeButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,
                           padding: .init(top: 12, left: 0, bottom: 0, right: 12),
                           size: .init(width: 80, height: 38))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
