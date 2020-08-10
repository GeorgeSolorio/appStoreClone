//
//  AppsCompositionalView.swift
//  appStoreClone
//
//  Created by George Solorio on 7/31/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import SwiftUI

class CompositionalController: UICollectionViewController {
    
    let cellId = "cellId"
    let cellId2 = "cellId2"
    let headerId = "headerId"
    var socialApps = [SocialApp]()
    var games: AppGroup?
    var topGrossingApps: AppGroup?
    var freeApps: AppGroup?
    
    class CompositionalHeader: UICollectionReusableView {
        
        let label = UILabel(text: "Editor's choice games", font: .boldSystemFont(ofSize: 32))
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(label)
            label.fillSuperView()
        }
        
        required init?(coder: NSCoder) {
            fatalError()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(CompositionalHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(AppHeaderCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: cellId2)
        collectionView.backgroundColor = .systemBackground
        navigationItem.title = "Apps"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        fetchApps()
    }
    
    init() {
        
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                return CompositionalController.topSection()
            } else {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)))
                
                item.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 16)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(300)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets.leading = 16
                
                let kind = UICollectionView.elementKindSectionHeader
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: kind, alignment: .topLeading)
                ]
                return section
            }
            
        }
        
        super.init(collectionViewLayout: layout)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        
        return header
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
    
    private func fetchApps() {
        fetchAppsDispatchGroup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appId: String
        
        if indexPath.section == 0 {
            appId = socialApps[indexPath.item].id
        } else if indexPath.section == 1 {
            appId = games?.feed.results[indexPath.item].id ?? ""
        } else if indexPath.section == 2 {
            appId = topGrossingApps?.feed.results[indexPath.item].id ?? ""
        } else {
            appId = freeApps?.feed.results[indexPath.item].id ?? ""
        }
        
        let appDetailController = AppDetailController(appId: appId)
        navigationController?.pushViewController(appDetailController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return socialApps.count
        }
        return games?.feed.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppHeaderCell
            let socialApp = socialApps[indexPath.item]
            cell.companyLabel.text = socialApp.name
            cell.titleLabel.text = socialApp.tagline
            cell.imageView.sd_setImage(with: URL(string: socialApp.imageUrl))
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId2, for: indexPath) as! AppRowCell
            let appGroup: AppGroup?
            if indexPath.section == 1 {
                appGroup = games
            } else if indexPath.section == 2 {
                appGroup = topGrossingApps
            } else {
                appGroup = freeApps
            }
            cell.app = appGroup?.feed.results[indexPath.item]
            return cell
        }
    }
}

struct AppsView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = CompositionalController()
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


extension CompositionalController {
    
    func fetchAppsDispatchGroup() {
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (appGroup, error) in
            self.games = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { (appGroup, error) in
            self.topGrossingApps = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopFreeApps { (appGroup, error) in
            self.freeApps = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchSocialApps { (apps, error) in
            self.socialApps = apps ?? []
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }
}
