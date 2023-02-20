//
//  CustomRotatingCell.swift
//  RotatingCells
//
//  Created by Volodymyr D on 15.09.2022.
//

import UIKit

class CustomRotatingCell: UICollectionViewCell {
    
    //MARK: - Properties
    static var identtifier: String { String(describing: self) }
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var label: UILabel = {
//        let origin = CGPoint(x: bounds.width / 2,
//                             y:  bounds.height / 2)
        let label = UILabel(frame: CGRect(origin: .zero ,
                                          size: CGSize(width: 200,
                                                       height: 50)) )
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let tapRec = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap))
        tapRec.numberOfTapsRequired = 2
        return tapRec
    }()
    
    //MARK: - Life Cycle 
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    required init?(coder: NSCoder) { fatalError() }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        label.center = center
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        imageView.image = nil
        label.isHidden = false
        imageView.isHidden = true
    }
    
    //MARK: - Metods
    public func setItem(withText text: String, image: UIImage?, index: IndexPath) {
        label.text = text
        imageView.image = image
    }
    
    private func toggleItem() {
        label.isHidden.toggle()
        imageView.isHidden.toggle()
        layer.transform = contentView.layer.transform
    }
    
    private func configureView() {
        addGestureRecognizer(tapRecognizer)
        layer.cornerRadius = 18
        clipsToBounds = true
        backgroundColor = .separator
        let origin = CGPoint(x: (bounds.width / 2) - (label.bounds.width / 2),
                             y:  (bounds.height / 2) - (label.bounds.height / 2))
        label.frame.origin = origin
        contentView.addSubview(label)
        contentView.addSubview(imageView)
    }
    
    //MARK: - Actions
    @objc private func didDoubleTap() {
        guard (label.isHidden && !imageView.isHidden) || (!label.isHidden && imageView.isHidden) else { return }
        UIView.animate(withDuration: 2) { [unowned self] in
            self.layer.transform = CATransform3DRotate(self.layer.transform, CGFloat.pi, 0, 1, 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { [unowned self] in
                self.toggleItem()
            }
        }
    }
    
}
