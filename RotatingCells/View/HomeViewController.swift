//
//  HomeViewController.swift
//  RotatingCells
//
//  Created by Volodymyr D on 15.09.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    var presenter: HomeVCPresenterOutput! {
        didSet{
            presenter.delegate = self
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let collFrame = CGRect(origin: .zero,
                           size: CGSize(width: view.bounds.width,
                                        height: view.bounds.height / 2))
        let collectionView = UICollectionView(frame: collFrame,
                                              collectionViewLayout: presenter.createLayout(from: view.bounds))
        collectionView.center = view.center
        collectionView.backgroundColor = .clear
        presenter.register(collectionView: collectionView)
        return collectionView
    }()
     
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        doublePulseAnimation()
    }
    
    //MARK: - Metods
    private func doublePulseAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.toValue = 1.03
            animation.duration = 0.15
            animation.autoreverses = true
            animation.repeatCount = 2
            self.collectionView.cellForItem(at: .init(row: 0, section: 0))?.layer.add(animation, forKey: nil)
        }
    }

}
  

extension HomeViewController: HomeVCPresenterInput {
    
}

 
