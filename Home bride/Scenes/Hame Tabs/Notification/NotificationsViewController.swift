//
//  HomeNewReqViewController.swift
//  Home bride
//
//  Created by Youssef on 4/20/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class NotificationsView: BaseView {
    
    lazy var mainTableView: UITableView = {
        let tableV = UITableView()
        tableV.allowsSelection = false
        tableV.applySketchShadow()
        
        tableV.backgroundColor = .clear
        tableV.isOpaque = false
        tableV.backgroundView = nil
        tableV.tableFooterView = UIView()
        tableV.separatorColor = .clear
        tableV.translatesAutoresizingMaskIntoConstraints = false
        tableV.register(NotificaionsCell.self, forCellReuseIdentifier: "NotificaionsCell")
        return tableV
    }()
    
    override func setupView() {
        super.setupView()
        
        backgroundColor = #colorLiteral(red: 0.9371561408, green: 0.9373133779, blue: 0.9371339679, alpha: 1)
        
        addSubview(mainTableView)
        mainTableView.centerXInSuperview()
        mainTableView.topAnchorSuperView()
        mainTableView.widthAnchorWithMultiplier(multiplier: 1)
        mainTableView.bottomAnchorSuperView(constant: 0)
    }
}

class NotificationsViewController: BaseUIViewController<NotificationsView>, UITableViewDelegate, UITableViewDataSource {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarApperance(title: "", addImageTitle: ya, showNotifButton: no)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), landscapeImagePhone: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(handleSideMenu))
        setupSideMenu()
        mainView.mainTableView.delegate = self
        mainView.mainTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificaionsCell", for: indexPath) as! NotificaionsCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


// MARK: - Your Cell

class NotificaionsCell: UITableViewCell {
    private lazy var userImage: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.image = #imageLiteral(resourceName: "facebook")
        img.viewCornerRadius = 25
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    private lazy var userNameLable: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "sadsaddas"
        label.textAlignment = .right
        label.font = .CairoSemiBold(of: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var dateLable: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "asdasd"
        label.textAlignment = .right
        label.font = .CairoRegular(of: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var chatImage: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.image = #imageLiteral(resourceName: "chat").withRenderingMode(.alwaysTemplate)
        img.tintColor = .gray
        img.viewCornerRadius = 40
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setupCell() {
        contentView.addSubview(userImage)
        userImage.widthAnchorConstant(constant: 50)
        userImage.heightAnchorEqualWidthAnchor()
        userImage.trailingAnchorAnchorSuperView(constant: -10)
        userImage.centerYInSuperview()
        
        contentView.addSubview(userNameLable)
        userNameLable.topAnchorToView(anchor: userImage.topAnchor)
        userNameLable.trailingAnchorToView(anchor: userImage.leadingAnchor, constant: -5)
        userNameLable.leadingAnchorSuperView(constant: 10)
        
        contentView.addSubview(dateLable)
        dateLable.bottomAnchorToView(anchor: userImage.bottomAnchor)
        dateLable.trailingAnchorToView(anchor: userImage.leadingAnchor, constant: -5)
        dateLable.leadingAnchorSuperView(constant: 10)

        contentView.addSubview(chatImage)
        chatImage.centerYInSuperview()
        chatImage.widthAnchorConstant(constant: 30)
        chatImage.heightAnchorConstant(constant: 20)
        chatImage.leadingAnchorSuperView(constant: 10)
    }
    
    // MARK: - ConfigurableCell
    func configure(_ item: BaseModel) {
        
        
    }
}
