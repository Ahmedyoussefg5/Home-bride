//
//  GalaryView.swift
//  Home bride
//
//  Created by Youssef on 4/28/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class ProvProfileView: BaseView {
    lazy var userImage: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.image = #imageLiteral(resourceName: "girl")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    lazy var mainCollectionView: UICollectionView = {
        var layout = ArabicCollectionFlow()
        layout.scrollDirection = .vertical
        let coll = UICollectionView (frame: .zero, collectionViewLayout: layout)
        coll.backgroundColor = .clear
        coll.translatesAutoresizingMaskIntoConstraints = false
        coll.register(cellWithClass: QualCollCell.self)
        return coll
    }()
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.viewBorderWidth = 0.5
        view.viewBorderColor = #colorLiteral(red: 0.89402318, green: 0.8941735625, blue: 0.89400208, alpha: 1)
        view.backgroundColor = .white
        view.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.19), alpha: 1, x: 0, y: 3, blur: 2, spread: 0)
        return view
    }()
    lazy var nameLable: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = .CairoSemiBold(of: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var addressLable: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = .CairoSemiBold(of: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func setupView() {
        super.setupView()
        backgroundColor = .clear
        isUserInteractionEnabled = true
        
        addSubview(containerView)
        containerView.backgroundColor = .white
        containerView.centerXInSuperview()
        containerView.widthAnchorWithMultiplier(multiplier: 0.9)
        containerView.heightAnchorWithMultiplier(multiplier: 0.5)
        containerView.centerYInSuperview()
        
        
        containerView.addSubview(userImage)
        userImage.centerXInSuperview()
        userImage.widthAnchorWithMultiplier(multiplier: 0.3)
        userImage.heightAnchorEqualWidthAnchor()
        userImage.topAnchorSuperView(constant: 10)
        
        containerView.addSubview(nameLable)
        nameLable.centerXInSuperview()
        nameLable.topAnchorToView(anchor: userImage.bottomAnchor, constant: 5)
        
        containerView.addSubview(addressLable)
        addressLable.centerXInSuperview()
        addressLable.topAnchorToView(anchor: nameLable.bottomAnchor, constant: 1)
        addressLable.widthAnchorWithMultiplier(multiplier: 1)
        addressLable.numberOfLines = 0
        
        containerView.addSubview(mainCollectionView)
        mainCollectionView.centerXInSuperview()
        mainCollectionView.topAnchor.constraint(equalTo: addressLable.bottomAnchor).isActive = ya
        mainCollectionView.widthAnchorWithMultiplier(multiplier: 0.95)
        mainCollectionView.bottomAnchorSuperView(constant: -5)
    }
}

// MARK: - Your Cell
class QualCollCell: UICollectionViewCell {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = mediumPurple.withAlphaComponent(0.5)
//        view.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.19), alpha: 1, x: 0, y: 3, blur: 2, spread: 0)
        return view
    }()
    private lazy var cellImage: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    private lazy var lable: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .CairoSemiBold(of: 14)
        label.adjustsFontSizeToFitWidth = ya
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setupCell() {
        backgroundColor = mediumPurple.withAlphaComponent(0.5)
        
        contentView.addSubview(containerView)
        containerView.fillSuperview(padding: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        
        containerView.addSubview(cellImage)
        cellImage.centerXInSuperview()
        cellImage.widthAnchorWithMultiplier(multiplier: 0.75)
        cellImage.heightAnchorWithMultiplier(multiplier: 0.6)
        cellImage.topAnchorSuperView(constant: 5)
        
        containerView.addSubview(lable)
        lable.centerXInSuperview()
        lable.topAnchorToView(anchor: cellImage.bottomAnchor, constant: 5)
        lable.bottomAnchorSuperView(constant: -2)
        lable.widthAnchorWithMultiplier(multiplier: 1)
    }
    
    func config(item: Qualification) {
        lable.text = item.name
        cellImage.load(with: item.image)
    }
}
