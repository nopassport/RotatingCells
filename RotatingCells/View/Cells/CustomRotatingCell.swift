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
    private var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.contentMode = .scaleAspectFill
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
        addGestureRecognizer(tapRecognizer)
        layer.cornerRadius = 18
        clipsToBounds = true
        backgroundColor = .separator
        contentView.addSubview(label)
        contentView.addSubview(imageView)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let heightLbl =  bounds.height / 22
        let widthLbl = bounds.width / 4
        let originPoint = CGPoint(x: (bounds.width / 2) - (widthLbl / 2),
                                  y: (bounds.height / 2) - (heightLbl / 2))
        label.frame = CGRect(origin: originPoint ,
                              size: CGSize(width: widthLbl,
                                           height: heightLbl))
//        label.center = center    //MARK: chekkk
        imageView.frame = bounds
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
    }
    
    //MARK: - Actions
    @objc private func didDoubleTap() {
        guard (label.isHidden && !imageView.isHidden) || (!label.isHidden && imageView.isHidden) else { return }
        UIView.animate(withDuration: 2) { [weak self] in
            guard let self = self else { return }
            self.layer.transform = CATransform3DRotate(self.layer.transform, CGFloat.pi, 0, 1, 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { [weak self] in
                guard let self = self else { return }
                self.toggleItem()
                self.layer.transform = self.contentView.layer.transform
            }
        }
    }
    
}
