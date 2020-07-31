//
//  FullScreenController.swift
//  appStoreClone
//
//  Created by George Solorio on 7/13/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit

class TodayFullScreenController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dismissHandler: (() -> ())?
    var todayItem: TodayItem?
    let tableView = UITableView(frame: .zero, style: .plain)
    let floatingContainerView = UIView()
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.clipsToBounds = true
        tableView.fillSuperView()
        tableView.dataSource = self
        tableView.delegate = self
        setupCloseButton()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        if let height = self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height {
            tableView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)
        }
        
        setupFloatinControls()
    }
    
    fileprivate func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 80, height: 40))
        closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
        }
        
        let height = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let translationY = -90 - height
        let transfrom = scrollView.contentOffset.y > 100 ? CGAffineTransform(translationX: 0, y: translationY) : .identity
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.floatingContainerView.transform = transfrom
        })
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return TodayController.cellSize
        }
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.item == 0 {
            let headerCell = TodayAppFullScreenHeaderCell()
            headerCell.todayCell.todayItem = todayItem!
            headerCell.todayCell.layer.cornerRadius = 0
            headerCell.clipsToBounds = true
            headerCell.todayCell.backgroundView = nil
            return headerCell
        }
        
        let cell = TodayAppFullScreenDescriptionCell()
        return cell
    }
    
    @objc func handleDismiss(button: UIButton) {
        button.isHidden = true
        dismissHandler?()
    }
    
    fileprivate func setupFloatinControls() {
        
        let getButton = UIButton(title: "GET")
        getButton.setTitleColor(.white, for: .normal)
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        getButton.backgroundColor = .darkGray
        getButton.layer.cornerRadius = 16
        getButton.constraintWidth(constant: 90)
        getButton.constraintHeight(constant: 32)
        
        floatingContainerView.layer.cornerRadius = 16
        floatingContainerView.clipsToBounds = true
        view.addSubview(floatingContainerView)
        floatingContainerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: -90, right: 16), size: .init(width: 0, height: 100))
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        floatingContainerView.addSubview(visualEffectView)
        visualEffectView.fillSuperView()
                
        // Add our subviews
        let imageView = UIImageView(cornerRadius: 16)
        imageView.image = #imageLiteral(resourceName: "garden")
        imageView.constraintHeight(constant: 68)
        imageView.constraintWidth(constant: 68)
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView, 
            VerticalStackView(arrangedSubviews: [
                UILabel(text: "Life Hack", font: .boldSystemFont(ofSize: 18)),
                UILabel(text: "Utilizing Your Time", font: .systemFont(ofSize: 16), numberOfLines: 0),
            ]),
            getButton,
        ], customSpacing: 16)
        
        floatingContainerView.addSubview(stackView)
        stackView.fillSuperView(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        stackView.alignment = .center
    }
}
