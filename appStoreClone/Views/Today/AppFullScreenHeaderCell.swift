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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(todayCell)
        todayCell.fillSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
