//
//  HomeVC.swift
//  SampleProject
//
//  Created by Manish Tard on 28/09/20.
//  Copyright © 2020 Manish Tard. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    var collectionView: UICollectionView!
    
    var sections: [Section] = []
    var dataSource: UICollectionViewDiffableDataSource<Section, App>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        getSectionsData()
        configureDataSource()
        reloadData()
    }
    
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.reuseId)
        collectionView.register(MediumTableCell.self, forCellWithReuseIdentifier: MediumTableCell.reuseId)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        collectionView.register(SmallTableCell.self, forCellWithReuseIdentifier: SmallTableCell.resueId)
    }
    
    
    private func getSectionsData(){
        DataManger.shared.getDataFromFile(fileName: "appstore.json") { (sections, error) in
            guard let sections = sections, error == nil else{
                print(error!)
                return
            }
            
            self.sections = sections
            reloadData()
        }
    }
    
    
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, App>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, app) -> UICollectionViewCell? in
            let section = self.sections[indexPath.section]
            switch section.type {
            case "mediumTable":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediumTableCell.reuseId, for: indexPath) as! MediumTableCell
                cell.setValuesFromModel(app: app)
                return cell
                
            case "smallTable":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallTableCell.resueId, for: indexPath) as! SmallTableCell
                cell.setValuesFromModel(app: app)
                return cell
                
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedCell.reuseId, for: indexPath) as! FeaturedCell
                cell.setValuesForCellElements(app: app)
                return cell
            }
        })
        
        dataSource?.supplementaryViewProvider = { [weak self]
            collectionView, kind, IndexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: IndexPath) as? SectionHeader else {
                return nil
            }
            guard let firstApp = self?.dataSource?.itemIdentifier(for: IndexPath) else{ return nil }
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstApp) else { return nil }
            if section.title.isEmpty{ return nil }
            
            sectionHeader.title.text = section.title
            sectionHeader.subtitle.text = section.subtitle
            return sectionHeader
        }
    }
    

    private func reloadData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, App>()
        snapshot.appendSections(sections)
        
        for section in sections{
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource?.apply(snapshot)
    }
    
    
    func createCompositionalLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout{ sectionIndex, layoutEnvironment in
            let section = self.sections[sectionIndex]
            switch section.type {
            case "mediumTable":
                return self.setupMediumCellSection()
                
            case "smallTable":
                return self.setupSmallCellSection()
                
            default:
                return self.setupFeaturedCellSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    
    func setupFeaturedCellSection() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        //item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(350))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        return section
    }
    
    
    func setupMediumCellSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalWidth(0.55))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    
    func setupSmallCellSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(80))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return sectionHeader
    }
}

enum SectionType: Int{
    case firstSection, secondSection, thirdSection
}
