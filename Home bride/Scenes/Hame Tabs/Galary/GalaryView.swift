//
//  GalaryView.swift
//  Home bride
//
//  Created by Youssef on 4/28/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class GalaryView: BaseView {
    
//    var selected = 0 {
//        didSet {
//            mainCollectionView.reloadData()
//        }
//    } // Pics
//    // 1 = vids
    
    lazy var photoButton: menuButton = {
        let btn = menuButton(title: "البوم الصور")
        btn.setTitleColor(lightPurple, for: .normal)
        btn.addTheTarget(action: {[weak self] in
//            self?.asd(sender: btn)
//            self?.selected = 0
        })
        return btn
    }()
    
//    func asd(sender: menuButton) {
//        [photoButton, vidButton].forEach { (btn) in
//            btn.isMenuSelected = no
//        }
//        sender.isMenuSelected = ya
//    }
    
//    lazy var vidButton: menuButton = {
//        let btn = menuButton(title: "البوم الفيديوهات")
//        btn.addTheTarget(action: {[weak self] in
//            self?.asd(sender: btn)
//            self?.selected = 1
//        })
//        return btn
//    }()
    lazy var mainCollectionView: UICollectionView = {
        var layout = ArabicCollectionFlow()
        layout.scrollDirection = .vertical
        let coll = UICollectionView (frame: .zero, collectionViewLayout: layout)
        coll.backgroundColor = .clear
        coll.translatesAutoresizingMaskIntoConstraints = false
        coll.register(cellWithClass: GalaryCollCell.self)
        return coll
    }()
    override func setupView() {
        super.setupView()
//        addSubview(vidButton)
//        vidButton.leadingAnchorSuperView()
//        vidButton.topAnchorSuperView()
//        vidButton.widthAnchorWithMultiplier(multiplier: 0.5)
//        vidButton.heightAnchorConstant(constant: 50)
        
        addSubview(photoButton)
        photoButton.trailingAnchorAnchorSuperView()
        photoButton.topAnchorSuperView()
        photoButton.widthAnchorWithMultiplier(multiplier: 0.5)
        photoButton.heightAnchorConstant(constant: 50)
        
        addSubview(mainCollectionView)
        mainCollectionView.centerXInSuperview()
        mainCollectionView.topAnchor.constraint(equalTo: photoButton.bottomAnchor).isActive = ya
        mainCollectionView.widthAnchorWithMultiplier(multiplier: 0.95)
        mainCollectionView.bottomAnchorSuperView(constant: 0)
        
    }
    
}

class menuButton: UIButton {
    
    let selectionView = SelectionView()
    
    var isMenuSelected: Bool = false {
        didSet {
            if isMenuSelected {
                selectionView.backgroundColor = lightPurple
                addSubview(selectionView)
                selectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = ya
                selectionView.centerXInSuperview()
                selectionView.widthAnchorWithMultiplier(multiplier: 0.9)
                setTitleColor(lightPurple, for: .normal)
            } else {
                selectionView.removeFromSuperview()
                setTitleColor(#colorLiteral(red: 0.4744570851, green: 0.4745410085, blue: 0.4744452834, alpha: 1), for: .normal)
            }
        }
    }
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        contentHorizontalAlignment = .center
        setTitleColor(#colorLiteral(red: 0.4744570851, green: 0.4745410085, blue: 0.4744452834, alpha: 1), for: .normal)
        titleLabel?.font = .CairoSemiBold(of: 15)
        backgroundColor = #colorLiteral(red: 0.89402318, green: 0.8941735625, blue: 0.89400208, alpha: 1)
        selectionView.backgroundColor = .clear
        selectionView.clipsToBounds = ya
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = ya
        addSubview(selectionView)
        selectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = ya
        selectionView.centerXInSuperview()
        selectionView.widthAnchorWithMultiplier(multiplier: 0.9)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SelectionView: UIView {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: 1)
    }
}
