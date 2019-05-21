//
//  GalaryView.swift
//  Home bride
//
//  Created by Youssef on 4/28/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class AllProvView: BaseView {
    
    lazy var mainCollectionView: UICollectionView = {
        var layout = ArabicCollectionFlow()
        layout.scrollDirection = .vertical
        let coll = UICollectionView (frame: .zero, collectionViewLayout: layout)
        coll.backgroundColor = .clear
        coll.translatesAutoresizingMaskIntoConstraints = false
        coll.register(ProvCell.self, forCellWithReuseIdentifier: "ProvCell")
        return coll
    }()
    
    override func setupView() {
        super.setupView()
        
        addSubview(mainCollectionView)
        mainCollectionView.fillSuperviewSafeArea()
        
    }
    
}
class ProvCell: UICollectionViewCell {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.viewBorderWidth = 0.5
        view.viewBorderColor = #colorLiteral(red: 0.89402318, green: 0.8941735625, blue: 0.89400208, alpha: 1)
        view.backgroundColor = .white
        view.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.19), alpha: 1, x: 0, y: 3, blur: 2, spread: 0)
        return view
    }()
    
    private lazy var onlineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
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
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = .CairoSemiBold(of: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(containerView)
        containerView.fillSuperview(padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        containerView.addSubview(cellImage)
        cellImage.trailingAnchorAnchorSuperView(constant: -10)
        cellImage.centerYInSuperview()
        cellImage.heightAnchorWithMultiplier(multiplier: 0.9)
        cellImage.widthAnchorEqualHeightAnchor()

        containerView.addSubview(onlineView)
        onlineView.trailingAnchorAnchorSuperView(constant: -5)
        onlineView.bottomAnchorSuperView(constant: -5)
        onlineView.widthAnchorConstant(constant: 20)
        onlineView.heightAnchorConstant(constant: 20)
        onlineView.viewCornerRadius = 10
        
        let lab = UILabel()
        lab.font = UIFont.CairoRegular(of: 13)
        lab.textColor = mediumPurple
        lab.text = "عرض الملف الشخصي"
        containerView.addSubview(lab)
        lab.bottomAnchorToView(anchor: cellImage.bottomAnchor)
        lab.trailingAnchorToView(anchor: cellImage.leadingAnchor, constant: -5)

        
        containerView.addSubview(lable)
        lable.topAnchorToView(anchor: cellImage.topAnchor)
        lable.trailingAnchorToView(anchor: cellImage.leadingAnchor, constant: -5)
    }
    
    func configCell(_ item: Providerr) {
        lable.text = "\(item.firstName)  \(item.lastName)"
        cellImage.load(with: item.image)
        item.isOnline ? (onlineView.backgroundColor = .green) : (onlineView.backgroundColor = .lightGray)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
