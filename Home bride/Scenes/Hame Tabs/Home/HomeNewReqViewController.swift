//
//  HomeNewReqViewController.swift
//  Home bride
//
//  Created by Youssef on 4/20/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class VV: BaseView{}

class HomeNewReqViewController: BaseUIViewController<VV>, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    lazy var mainTableView: UITableView = {
        let tableV = UITableView()
        tableV.isTransperant()
        tableV.separatorColor = .clear
//        tableV.allowsSelection = false
        tableV.delegate = self
        tableV.dataSource = self
        tableV.register(HomeNewReqCell.self, forCellReuseIdentifier: "UITableViewCell")
        return tableV
    }()
    
    let data = [
        BaseStruct(msg: "asd", status: 1),
        BaseStruct(msg: "asd", status: 1),
        BaseStruct(msg: "asd", status: 1),
        BaseStruct(msg: "asd", status: 1),
        BaseStruct(msg: "asd", status: 1),
        BaseStruct(msg: "asd", status: 1),
        BaseStruct(msg: "asd", status: 1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSideMenu()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), landscapeImagePhone: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(handleSideMenu))
        setupNavBarApperance(title: "", addImageTitle: ya, showNotifButton: no)

        view.addSubview(mainTableView)
        mainTableView.fillSuperview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarApperance(title: "", addImageTitle: ya, showNotifButton: no)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) as! HomeNewReqCell
        cell.setupCell(item: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UINavigationController(rootViewController: NewRequestDetailsViewController())
        vc.navbarWithdismiss()
        presentModelyVC(vc: vc)
    }
}

class HomeNewReqCell: BaseCell<BaseStruct> {
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
        img.image = #imageLiteral(resourceName: "girl")
        img.viewCornerRadius = 40
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .right
        label.text = "شسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشس"
        label.font = .CairoBold(of: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var discLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .right
        label.text = "شسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشسشسيشيسيشس"
        label.numberOfLines = 4
        label.font = .CairoRegular(of: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLable: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.text = "12 may"
        label.backgroundColor = #colorLiteral(red: 0.9132761359, green: 0.3805814981, blue: 0.6425676346, alpha: 1)
        label.font = .CairoRegular(of: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = ya
        return label
    }()
    
    override func setupCell() {
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.fillSuperview(padding: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))

        containerView.addSubview(cellImage)
        cellImage.heightAnchorWithMultiplier(multiplier: 0.9)
        cellImage.widthAnchorEqualHeightAnchor()
        cellImage.centerYInSuperview()
        cellImage.trailingAnchorAnchorSuperView(constant: 0)
        
        containerView.addSubview(titleLable)
        titleLable.leadingAnchorSuperView(constant: 0)
        titleLable.trailingAnchor.constraint(equalTo: cellImage.leadingAnchor, constant: -10).isActive = ya
        titleLable.topAnchorSuperView(constant: 5)
        
        containerView.addSubview(discLable)
        discLable.leadingAnchorSuperView(constant: 5)
        discLable.trailingAnchor.constraint(equalTo: cellImage.leadingAnchor, constant: -10).isActive = ya
        discLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 5).isActive = ya
        discLable.bottomAnchorSuperView(constant: -5)

        containerView.addSubview(dateLable)
        dateLable.widthAnchorConstant(constant: 65)
        dateLable.topAnchorSuperView(constant: 15)
        dateLable.heightAnchorConstant(constant: 20)
        dateLable.trailingAnchorAnchorSuperView(constant: 0)
        
    }
    override func setupCell<T>(item: T) {
        
    }
    
    
}
