//
//  TodayController.swift
//  appStoreClone
//
//  Created by George Solorio on 7/12/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit

class TodayController: BaseListController {
    
    // MARK: Properties
    static let cellSize: CGFloat = 500
    var startingFrame: CGRect?
    var todayAppFullScreenController: TodayFullScreenController!
    var item = [TodayItem]()
    var anchoredConstraint: AnchoredConstraints?
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        aiv.color = .darkGray
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    // MARK: Lifecyle
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
    
    
    // MARK: Collection view methods
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch item[indexPath.item].cellType {
        case .multiple:
            showDailyListFullScreen(indexPath)
        default:
            showSingleAppFullScreen(indexPath: indexPath)
        }
    }
    
}

// MARK: Private Helper Methods
extension TodayController {
    
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
                TodayItem.init(category: "LIFE HACk", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to inteligently organize your life the right way", backgroundColor: .white, cellType: .single, apps: []),
                TodayItem.init(category: "Daily List", title: topGrossingGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: topGrossingGroup?.feed.results ?? []),
                TodayItem.init(category: "Daily List", title: gamesGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: gamesGroup?.feed.results ?? []),
                TodayItem.init(category: "HOLIDAYS", title: "Travel on a budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know about how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.982437551, green: 0.9632169604, blue: 0.7271876931, alpha: 1), cellType: .single, apps: []),
            ]
            self.collectionView.reloadData()
        }
    }
    
    
    fileprivate func showDailyListFullScreen(_ indexPath: IndexPath) {
        let fullController = TodayMultipleAppsController(mode: .fullScreen)
        fullController.results = self.item[indexPath.item].apps
        present(DimissNavigationController(rootViewController: fullController), animated: true)
        return
    }
    
    fileprivate func setupFullScreenController(indexPath: IndexPath) {
        let todayAppFullScreenController = TodayFullScreenController()
        todayAppFullScreenController.dismissHandler = {
            self.handleRemoveView()
        }
        
        todayAppFullScreenController.todayItem = item[indexPath.item]
        todayAppFullScreenController.view.layer.cornerRadius = 16
        self.todayAppFullScreenController = todayAppFullScreenController
    }
    
    fileprivate func setupStartingFrame(indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath), let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
    }
    
    fileprivate func setuFullScreenStartingPosition(indexPath: IndexPath) {
        let fullScreenView = todayAppFullScreenController.view!
        view.addSubview(fullScreenView)
        addChild(todayAppFullScreenController)
        self.collectionView.isUserInteractionEnabled = false
        setupStartingFrame(indexPath: indexPath)
        
        guard let startingFrame = self.startingFrame else { return }
        
        // Auto layout constraint animations
        self.anchoredConstraint = fullScreenView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0), size: .init(width: startingFrame.width, height: startingFrame.height))
    }
    
    fileprivate func beginAnimationTransitionToFullScreen() {
        self.view.layoutIfNeeded() // starts the animation
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.anchoredConstraint?.top?.constant = 0
            self.anchoredConstraint?.leading?.constant = 0
            self.anchoredConstraint?.width?.constant = self.view.frame.width
            self.anchoredConstraint?.height?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height
            
            guard let cell = self.todayAppFullScreenController.tableView.cellForRow(at: [0, 0]) as? TodayAppFullScreenHeaderCell else { return }
            cell.todayCell.topConstraint.constant = 48
            cell.layoutIfNeeded()
        }, completion: nil)
    }
    
    fileprivate func showSingleAppFullScreen(indexPath: IndexPath) {
        
        setupFullScreenController(indexPath: indexPath)
        setuFullScreenStartingPosition(indexPath: indexPath)
        beginAnimationTransitionToFullScreen()
    }
}

// MARK: Helper Methods
extension TodayController {

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
    
    func handleRemoveView() {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            //self.todayAppFullScreenController.tableView.scrollsToTop = true
            
            guard let startingFrame = self.startingFrame else { return }
            
            self.anchoredConstraint?.top?.constant = startingFrame.origin.y
            self.anchoredConstraint?.leading?.constant = startingFrame.origin.x
            self.anchoredConstraint?.width?.constant = startingFrame.width
            self.anchoredConstraint?.height?.constant = startingFrame.height
            
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

// MARK: UICollectionViewDelegateFlowLayout
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
