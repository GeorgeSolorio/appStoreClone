//
//  TodayMultipleAppsController.swift
//  appStoreClone
//
//  Created by George Solorio on 7/16/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit

class TodayMultipleAppsController: BaseListController {
    
    enum Mode {
        case small, fullScreen
    }
    override var prefersStatusBarHidden: Bool { return true }
    fileprivate let spacing: CGFloat = 16
    fileprivate let mode: Mode
    let cellId = "cellId"
    var results = [FeedResult]()
//    let closeButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
//        button.tintColor = .darkGray
//        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
//        return button
//    }()
//
//    @objc func handleDismiss() {
//        dismiss(animated: true)
//    }
    
    init(mode: Mode) {
        self.mode = mode
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mode == .small {
            collectionView.isScrollEnabled = false
        }
        collectionView.backgroundColor = .white
        collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: cellId)
    }
    
//    func setupCloseButton() {
//        view.addSubview(closeButton)
//        closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding:.init(top: 16, left: 0, bottom: 0, right: 8), size: .init(width: 44, height: 44))
//    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mode == .fullScreen {
            return results.count
        }
        return min(4, results.count)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleAppCell
        cell.app = self.results[indexPath.item]
        return cell
    }
}

extension TodayMultipleAppsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height: CGFloat = 68
        
        if mode == .fullScreen {
            return .init(width: view.frame.width - 48, height: height)
        }
        
        return .init(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if mode == .fullScreen {
            return .init(top: 12, left: 24, bottom: 12, right: 24)
        }
        return .zero
    }
}
