//
//  TodayController.swift
//  appStoreClone
//
//  Created by George Solorio on 7/12/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit

class TodayController: BaseListController {
    
    static let cellSize: CGFloat = 500
    var startingFrame: CGRect?
    var todayAppFullScreenController: TodayFullScreenController!
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint:  NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    var item = [TodayItem]()
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        aiv.color = .darkGray
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperView()
        fetchData()
        collectionView.backgroundColor = #colorLiteral(red: 0.8932284713, green: 0.8867718577, blue: 0.8981721401, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMutipleAppsCell.self, forCellWithReuseIdentifier:TodayItem.CellType.multiple.rawValue)
    }
    
    fileprivate func fetchData() {
        let dispatchGroup = DispatchGroup()
        var topGrossingGroup: AppGroup?
        var gamesGroup: AppGroup?
        
        dispatchGroup.enter()
        Service.shared.fetchTopFreeApps { (appGroup, error) in
            topGrossingGroup = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (appGroup, error) in
            gamesGroup = appGroup
            dispatchGroup.leave()
        }
        
        //completion block
        dispatchGroup.notify(queue: .main) {
            self.activityIndicatorView.stopAnimating()
            self.item = [
                TodayItem.init(category: "Daily List", title: topGrossingGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: topGrossingGroup?.feed.results ?? []),
                TodayItem.init(category: "LIFE HACk", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to inteligently organize your life the right way", backgroundColor: .white, cellType: .single, apps: []),
                TodayItem.init(category: "Daily List", title: gamesGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: gamesGroup?.feed.results ?? []),
                TodayItem.init(category: "HOLIDAYS", title: "Travel on a budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know about how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.982437551, green: 0.9632169604, blue: 0.7271876931, alpha: 1), cellType: .single, apps: []),
            ]
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cellId = item[indexPath.item].cellType.rawValue
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
        cell.todayItem = item[indexPath.item]
        
        (cell as? TodayMutipleAppsCell)?.multiplesAppsController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleApps)))
        
        return cell
    }
    
    @objc func handleMultipleApps(gesture: UITapGestureRecognizer) {
        let collectionView = gesture.view
        
        var superview = collectionView?.superview
        while superview != nil {
            if let cell = superview as? TodayMutipleAppsCell {
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                let apps = self.item[indexPath.item].apps
                let fullController = TodayMultipleAppsController(mode: .fullScreen)
                fullController.results = apps
                present(DimissNavigationController(rootViewController: fullController), animated: true)
                return
            }
            superview = superview?.superview
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if item[indexPath.item].cellType == .multiple {
            let fullController = TodayMultipleAppsController(mode: .fullScreen)
            fullController.results = self.item[indexPath.item].apps
            present(DimissNavigationController(rootViewController: fullController), animated: true)
            return
        }
        
        let todayAppFullScreenController = TodayFullScreenController()
        todayAppFullScreenController.dismissHandler = {
            self.handleRemoveView()
        }
        todayAppFullScreenController.todayItem = item[indexPath.item]
        
        let fullScreenView = todayAppFullScreenController.view!
        view.addSubview(fullScreenView)
        addChild(todayAppFullScreenController)
        self.todayAppFullScreenController = todayAppFullScreenController
        self.collectionView.isUserInteractionEnabled = false
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }

        self.startingFrame = startingFrame
        
        // Auto layout constraint animations
        fullScreenView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = fullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = fullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = fullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = fullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({ $0?.isActive = true })
        
        self.view.layoutIfNeeded() // starts the animation
         
        fullScreenView.layer.cornerRadius = 16
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {

            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height

            guard let cell = self.todayAppFullScreenController.tableView.cellForRow(at: [0, 0]) as? TodayAppFullScreenHeaderCell else { return }
            cell.todayCell.topConstraint.constant = 48
            cell.layoutIfNeeded()
        }, completion: nil)
    }
    
    func handleRemoveView() {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            //self.todayAppFullScreenController.tableView.scrollsToTop = true

            guard let startingFrame = self.startingFrame else { return }
            
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            
            self.view.layoutIfNeeded()

            if let tabBarFrame = self.tabBarController?.tabBar.frame {
                self.tabBarController?.tabBar.frame.origin.y = self.view.frame.height - tabBarFrame.height
            }
            
            guard let cell = self.todayAppFullScreenController.tableView.cellForRow(at: [0, 0]) as? TodayAppFullScreenHeaderCell else { return }
               cell.todayCell.topConstraint.constant = 24
               cell.layoutIfNeeded()
        }, completion: { _ in
            self.todayAppFullScreenController.view.removeFromSuperview()
            self.todayAppFullScreenController.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        })
    }
}

extension TodayController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: TodayController.cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
}
