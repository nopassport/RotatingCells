//
//  HomeVCPresenter.swift
//  RotatingCells
//
//  Created by Volodymyr D on 15.09.2022.
//

import UIKit
 
typealias DataMod = [(image: UIImage?, text: String)]

protocol HomeVCPresenterInput: AnyObject {
//    func fetch(data: DataMod)
}

protocol HomeVCPresenterOutput {
    var delegate: HomeVCPresenterInput! {get set}
    func register(collectionView: UICollectionView)
    func createLayout(from bounds: CGRect) -> UICollectionViewLayout
}



class HomeVCPresenter: NSObject {
    
    weak var delegate: HomeVCPresenterInput!
    
    let someData: DataMod = [
        (UIImage(named: "bmw"), "Item"),
        (UIImage(named: "town"), "Item"),
        (UIImage(named: "015"), "Item"),
        (UIImage(named: "homee"), "Item"),
        (UIImage(named: "oil"), "Item"),
    ]
     
}

//MARK: - Presenter Output
extension HomeVCPresenter: HomeVCPresenterOutput {
    
    public func createLayout(from bounds: CGRect) -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(0.98))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 4, bottom: 0, trailing: 4)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(bounds.width - 110),
                                               heightDimension: .absolute(bounds.height / 2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return UICollectionViewCompositionalLayout(section: section)
    }
 
    public func register(collectionView: UICollectionView) {
        collectionView.register(CustomRotatingCell.self,
                                forCellWithReuseIdentifier: CustomRotatingCell.identtifier)
        collectionView.dataSource = self
    }
    
}
 
//MARK: - CollectionView Data Source
extension HomeVCPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        someData.count
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: CustomRotatingCell.identtifier,
                                                      for: indexPath) as! CustomRotatingCell 
        let data = someData[indexPath.row]
        item.setItem(withText: "\(data.text) - \(indexPath.row)", image: data.image, index: indexPath)
        return item
    }
     
}
