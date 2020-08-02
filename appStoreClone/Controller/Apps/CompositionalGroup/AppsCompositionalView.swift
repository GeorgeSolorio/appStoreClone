//
//  AppsCompositionalView.swift
//  appStoreClone
//
//  Created by George Solorio on 7/31/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import SwiftUI

class ComposionalController: UICollectionViewController {
    
    let cellId = "cellId"
    let cellId2 = "cellId2"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(AppHeaderCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId2)
        collectionView.backgroundColor = .systemBackground
        navigationItem.title = "Apps"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    init() {
        
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                return ComposionalController.topSection()
            } else {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)))
                
                item.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 16)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(300)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets.leading = 16
                return section
            }
            
        }
        
        super.init(collectionViewLayout: layout)
    }
    
    static func topSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
         
         item.contentInsets.bottom = 16
         item.contentInsets.trailing = 16
         
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(300)), subitems: [item])
         let section = NSCollectionLayoutSection(group: group)
         section.orthogonalScrollingBehavior = .groupPaging
         section.contentInsets.leading = 16
        
        return section
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId2, for: indexPath)
            cell.backgroundColor = .blue
            return cell
        }
    }
}

struct AppsView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = ComposionalController()
        return UINavigationController(rootViewController: controller)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

struct AppsCompositionalView_Previews: PreviewProvider {
    static var previews: some View {
        AppsView()
            .edgesIgnoringSafeArea(.all)
    }
}
