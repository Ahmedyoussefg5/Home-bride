//
//  GalaryView.swift
//  Home bride
//
//  Created by Youssef on 4/28/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class AllCatView: BaseView {
    
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
