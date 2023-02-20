//
//  HomeViewController.swift
//  RotatingCells
//
//  Created by Volodymyr D on 15.09.2022.
//

import UIKit

typealias DataMod = [(image: UIImage?, text: String)]


class ViewController: UIViewController {
     
    private let someData: DataMod = [
        (UIImage(named: "bmw"), "Item"),
        (UIImage(named: "town"), "Item"),
        (UIImage(named: "015"), "Item"),
        (UIImage(named: "homee"), "Item"),
        (UIImage(named: "oil"), "Item"),
    ]
     
    private lazy var collectionView: UICollectionView = {
        let collFrame = CGRect(origin: .zero,
                               size: CGSize(width: view.bounds.width,
                                            height: view.bounds.height / 2))
        let collectionView = UICollectionView(frame: collFrame,
                                              collectionViewLayout: createLayout())
        collectionView.center = view.center
        collectionView.backgroundColor = .clear
        collectionView.register(CustomRotatingCell.self,
                                forCellWithReuseIdentifier: CustomRotatingCell.identtifier)
        collectionView.dataSource = self
        return collectionView
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        view.addSubview(collectionView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        doublePulseAnimationForFirstCell()
    }
    
    //MARK: - Metods
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(0.98))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 4, bottom: 0, trailing: 4)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(view.bounds.width - 110),
                                               heightDimension: .absolute(view.bounds.height / 2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func doublePulseAnimationForFirstCell() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.toValue = 1.03
            animation.duration = 0.15
            animation.autoreverses = true
            animation.repeatCount = 2
//            self.collectionView.visibleCells.first?.layer.add(animation, forKey: nil)
            self.collectionView.cellForItem(at: .init(row: 0, section: 0))?.layer.add(animation, forKey: nil)
        }
    }

}
  

//MARK: - CollectionView Data Source
extension ViewController: UICollectionViewDataSource {
   
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
