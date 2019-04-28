//
//  HomeNewReqViewController.swift
//  Home bride
//
//  Created by Youssef on 4/20/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class ChatHomeView: BaseView {
    
    lazy var mainTableView: UITableView = {
        let tableV = UITableView()
        tableV.isTransperant()
//        tableV.backgroundColor = .clear
//        tableV.isOpaque = false
//        tableV.backgroundView = nil
//        tableV.tableFooterView = UIView()
//        tableV.separatorColor = mediumPurple
        tableV.translatesAutoresizingMaskIntoConstraints = false
        tableV.register(ChatHomeTableCell.self, forCellReuseIdentifier: "ChatHomeTableCell")
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

class ChatHomeViewController: BaseUIViewController<ChatHomeView>, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarApperance(title: "", addImageTitle: ya, showNotifButton: no)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), landscapeImagePhone: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(handleSideMenu))
        setupSideMenu()
        mainView.mainTableView.delegate = self
        mainView.mainTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatHomeTableCell", for: indexPath) as! ChatHomeTableCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = UINavigationController(rootViewController: ChatViewController())
        vc.navbarWithdismiss()
        presentModelyVC(vc: vc)
    }
}


// MARK: - Your Cell

class ChatHomeTableCell: UITableViewCell {
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
        label.text = "اسم المستخدم"
        label.textAlignment = .right
        label.font = .CairoSemiBold(of: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var dateLable: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "١٢-١٢-١٢"
        label.textAlignment = .right
        label.font = .CairoRegular(of: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var messageLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "شيسشي شسيشسي شسيشس شسيشس سشيشسي شسيشس سشي شسي سشي  ق بير يب  ي قفث  ث ققثسيب  سبيس"
        label.textAlignment = .right
        label.font = .CairoRegular(of: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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

        contentView.addSubview(messageLable)
        messageLable.bottomAnchorToView(anchor: userImage.bottomAnchor)
        messageLable.trailingAnchorToView(anchor: userImage.leadingAnchor, constant: -5)
        messageLable.leadingAnchorSuperView(constant: 10)
        
        contentView.addSubview(dateLable)
        dateLable.leadingAnchorSuperView(constant: 10)
        dateLable.topAnchorSuperView(constant: 5)
    }
    
    // MARK: - ConfigurableCell
    func configure(_ item: BaseModel) {
        
        
    }
}
