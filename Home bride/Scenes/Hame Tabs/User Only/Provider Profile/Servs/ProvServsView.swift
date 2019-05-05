//
//  GalaryView.swift
//  Home bride
//
//  Created by Youssef on 4/28/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class ProvServsView: BaseView {

    lazy var mainTableView: UITableView = {
        let tableV = UITableView()
//        tableV.allowsSelection = false
        tableV.backgroundColor = .white
        tableV.isOpaque = false
        tableV.backgroundView = nil
        tableV.tableFooterView = UIView()
        tableV.separatorColor = .clear
        tableV.translatesAutoresizingMaskIntoConstraints = false
        tableV.register(ProvServCell.self, forCellReuseIdentifier: "ProvServCell")
        return tableV
    }()
    lazy var resButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("حجز", for: .normal)
        btn.contentHorizontalAlignment = .center
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .CairoSemiBold(of: 15)
        btn.layer.cornerRadius = 15
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.insertSublayer(gradientLayer, at: 0)
        btn.addTheTarget(action: {[weak self] in
        })
        return btn
    }()
    lazy var gradientLayer = LinearGradientLayer(colors: [mediumPurple, lightPurple])

    override func setupView() {
        super.setupView()
        addSubview(mainTableView)
        mainTableView.fillSuperviewSafeArea(padding: UIEdgeInsets(top: 10, left: 10, bottom: 60, right: 10))
        addSubview(resButton)
        resButton.bottomAnchorSuperView(constant: -5)
        resButton.centerXInSuperview()
        resButton.widthAnchorWithMultiplier(multiplier: 0.85)
        resButton.heightAnchorConstant(constant: 40)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = resButton.bounds
        gradientLayer.cornerRadius = 15
    }
}
class ProvServCell: UITableViewCell {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.viewBorderWidth = 0.5
//        view.viewBorderColor = #colorLiteral(red: 0.89402318, green: 0.8941735625, blue: 0.89400208, alpha: 1)
        view.backgroundColor = mediumPurple
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
    
    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .CairoSemiBold(of: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var priceLable: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .CairoSemiBold(of: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = mediumPurple
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.fillSuperview(padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        containerView.addSubview(cellImage)
        cellImage.trailingAnchorAnchorSuperView(constant: -10)
        cellImage.centerYInSuperview()
        cellImage.heightAnchorWithMultiplier(multiplier: 0.75)
        cellImage.widthAnchorEqualHeightAnchor()
        
        containerView.addSubview(titleLable)
        titleLable.topAnchorToView(anchor: cellImage.topAnchor)
        titleLable.trailingAnchorToView(anchor: cellImage.leadingAnchor, constant: -5)
        
        containerView.addSubview(priceLable)
        priceLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 20).isActive = ya
        priceLable.trailingAnchorToView(anchor: cellImage.leadingAnchor, constant: -5)
        
        containerView.addSubview(reqButton)
        reqButton.widthAnchorConstant(constant: 100)
        reqButton.heightAnchorConstant(constant: 35)
        reqButton.leadingAnchorSuperView(constant: 10)
        reqButton.bottomAnchorSuperView(constant: -5)
        
        containerView.addSubview(callButton)
        callButton.widthAnchorConstant(constant: 40)
        callButton.heightAnchorConstant(constant: 35)
        callButton.leadingAnchor.constraint(equalTo: reqButton.trailingAnchor, constant: 10).isActive = ya
        callButton.bottomAnchorSuperView(constant: -5)
    }

    private lazy var reqButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("طلب الخدمة", for: .normal)
        btn.contentHorizontalAlignment = .center
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .CairoSemiBold(of: 13)
        btn.backgroundColor = lightPurple.withAlphaComponent(0.5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTheTarget(action: {[weak self] in
            self?.pressReq?()
        })
        return btn
    }()
    private lazy var callButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setBackgroundImage(#imageLiteral(resourceName: "calendar-with-a-clock-time-tools"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTheTarget(action: {[weak self] in
            self?.pressCalender?()
        })
        return btn
    }()
    
    var pressCalender: (() -> Void)?
    var pressReq: (() -> Void)?

    func configCell(_ item: ScheduleDataViewModel) {
        titleLable.text = item.name
        priceLable.text = "\(item.price)"
        cellImage.load(with: item.image)
        
        if item.isSelected {
            accessoryType = .checkmark
        } else {
            accessoryType = .none
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
