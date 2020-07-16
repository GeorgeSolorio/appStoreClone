//
//  FullScreenController.swift
//  appStoreClone
//
//  Created by George Solorio on 7/13/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit

class TodayFullScreenController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 450
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.item == 0 {
            return TodayAppFullScreenHeaderCell()
        }
        
        let cell = TodayAppFullScreenDescriptionCell()
        return cell
    }
}
