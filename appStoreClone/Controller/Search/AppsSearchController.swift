//
//  appsSearchControllerCollectionViewController.swift
//  appStoreClone
//
//  Created by George Solorio on 6/29/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit
import SDWebImage

class AppsSearchController: BaseListController {

    // Creates a thottle
    var timer: Timer?
    
    fileprivate let cellID = "id1234"
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellID)
        setupSearchBar()
        
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperView(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
        
        //fetchItunesApp()
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    fileprivate var appResults = [Result]()    
    
    //2 Extract this function fetchItunesApp() outside of this controller file
    
    fileprivate func fetchItunesApp() {
        
        Service.shared.fetchApps(searchTerm: "twitter") { results, error in
            
            if let error = error {
                print("Failed to fetch apps:", error)
                return
            }
            
            self.appResults = results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = appResults.count != 0
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchResultCell
        
        cell.appResult = appResults[indexPath.item]

        return cell
    }
}

extension AppsSearchController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 350)
    }
}

extension AppsSearchController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            // This will fire my search
            Service.shared.fetchApps(searchTerm: searchText) { (results, error) in
                self.appResults = results
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
}
