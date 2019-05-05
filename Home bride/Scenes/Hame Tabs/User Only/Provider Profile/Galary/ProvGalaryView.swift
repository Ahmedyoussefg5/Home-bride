//
//  GalaryView.swift
//  Home bride
//
//  Created by Youssef on 4/28/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class ProvGalaryView: BaseView {
    
    lazy var mainCollectionView: UICollectionView = {
        var layout = ArabicCollectionFlow()
        layout.scrollDirection = .vertical
        let coll = UICollectionView (frame: .zero, collectionViewLayout: layout)
        coll.backgroundColor = .clear
        coll.translatesAutoresizingMaskIntoConstraints = false
        coll.register(cellWithClass: GalaryCollCell.self)
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
    let head = UIView()
    lazy var gradientLayer = LinearGradientLayer(colors: [mediumPurple, lightPurple])

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
        
        head.layer.insertSublayer(gradientLayer, at: 0)
        containerView.addSubview(head)
        head.topAnchorSuperView(constant: 0)
        head.widthAnchorWithMultiplier(multiplier: 1)
        head.heightAnchorWithMultiplier(multiplier: 0.15)
        head.centerXInSuperview()
        
        let lable = UILabel()
        lable.text = "الصور"
        lable.font = UIFont.CairoSemiBold(of: 13)
        lable.textColor = .white
        head.addSubview(lable)
        lable.centerInSuperview()
        
        containerView.addSubview(mainCollectionView)
        mainCollectionView.centerXInSuperview()
        mainCollectionView.topAnchor.constraint(equalTo: head.bottomAnchor).isActive = ya
        mainCollectionView.widthAnchorWithMultiplier(multiplier: 0.95)
        mainCollectionView.bottomAnchorSuperView(constant: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = head.bounds
    }
}
