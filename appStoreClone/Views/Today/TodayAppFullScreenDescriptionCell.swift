//
//  TodayAppFullScreenDescriptionCell.swift
//  appStoreClone
//
//  Created by George Solorio on 7/13/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit

class TodayAppFullScreenDescriptionCell: UITableViewCell {
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "DESC"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(descriptionLabel)
        descriptionLabel.fillSuperView(padding: .init(top: 0, left: 24, bottom: 0, right: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
