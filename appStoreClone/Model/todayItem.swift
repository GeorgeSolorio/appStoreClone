//
//  todayItem.swift
//  appStoreClone
//
//  Created by George Solorio on 7/16/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit

struct TodayItem {

    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgroundColor: UIColor
    
    let cellType: CellType
    
    enum CellType: String {
        case single, multiple
    }
    let apps: [FeedResult]
}

