//
//  GalaryView.swift
//  Home bride
//
//  Created by Youssef on 4/28/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class SubCatView: BaseView {
    
    lazy var mainCollectionView: UICollectionView = {
        var layout = ArabicCollectionFlow()
        layout.scrollDirection = .vertical
        let coll = UICollectionView (frame: .zero, collectionViewLayout: layout)
        coll.backgroundColor = .clear
        coll.translatesAutoresizingMaskIntoConstraints = false
        coll.register(SubCatCell.self, forCellWithReuseIdentifier: "SubCatCell")
        return coll
    }()
    
    override func setupView() {
        super.setupView()
        
        addSubview(mainCollectionView)
        mainCollectionView.fillSuperviewSafeArea()
        
    }
    
}

class SubCatCell: UICollectionViewCell {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.viewBorderWidth = 0.5
        view.viewBorderColor = #colorLiteral(red: 0.89402318, green: 0.8941735625, blue: 0.89400208, alpha: 1)
        view.backgroundColor = .white
        view.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.19), alpha: 1, x: 0, y: 3, blur: 2, spread: 0)
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
        cellImage.centerXInSuperview()
        cellImage.centerYInSuperview()
        cellImage.widthAnchorWithMultiplier(multiplier: 0.5)
        cellImage.heightAnchorEqualWidthAnchor()
        
        containerView.addSubview(lable)
        lable.centerXInSuperview()
        lable.topAnchorToView(anchor: cellImage.bottomAnchor)
    }
    
    func configCell(_ item: Categories) {
        lable.text = item.name
        cellImage.load(with: item.image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
