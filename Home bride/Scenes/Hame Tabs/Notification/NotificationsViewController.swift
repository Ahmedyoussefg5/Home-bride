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
    
    private var nots: [Notifications]? {
        didSet {
            mainView.mainTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarApperance(title: "", addImageTitle: no, showNotifButton: no)
        title = "الاشعارات"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), landscapeImagePhone: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(handleSideMenu))
        setupSideMenu()
        mainView.mainTableView.delegate = self
        mainView.mainTableView.dataSource = self
        
        let url = "http://m4a8el.panorama-q.com/api/notifications"
        callApi(AllNotification.self, url: url, method: .get, parameters: nil) { (data) in
            if let data = data {
                self.nots = data.data.notifications
                self.lastPage = data.data.paginate.totalPages
                self.currentPage = 1
                self.isLoading = false
            }
        }
    }
    
    var currentPage = 1
    var lastPage = 2
    var isLoading = true
    private func paginate() {
        
        guard !isLoading else { return }
        guard lastPage > currentPage else { return }
        isLoading = true
        
        let url = "http://m4a8el.panorama-q.com/api/notifications?page=\(currentPage + 1)"
        callApi(AllNotification.self, url: url, method: .get, parameters: nil) { (data) in
            if let data = data {
                self.nots?.append(contentsOf: data.data.notifications)
                self.currentPage += 1
                self.isLoading = false
                print("self.currentPage \(self.currentPage)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificaionsCell", for: indexPath) as! NotificaionsCell
        if let not = nots?[indexPath.row] {
            cell.configure(not)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nots?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = nots?.count ?? -1
        if indexPath.row == count - 1 {
            paginate()
        }
    }
}


// MARK: - Your Cell

class NotificaionsCell: UITableViewCell {
    private lazy var userNameLable: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
//        label.text = "اسم المستخدم"
        label.textAlignment = .right
        label.font = .CairoSemiBold(of: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var dateLable: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
//        label.text = "١٢-١٢-١٢"
        label.textAlignment = .right
        label.font = .CairoRegular(of: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var messageLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray
//        label.text = "شيسشي شسيشسي شسيشس شسيشس سشيشسي شسيشس سشي شسي سشي  ق بير يب  ي قفث  ث ققثسيب  سبيس"
        label.textAlignment = .right
        label.font = .CairoRegular(of: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//    private lazy var userImage: UIImageView = {
//        let img = UIImageView()
//        img.clipsToBounds = true
//        img.contentMode = .scaleToFill
//        img.image = #imageLiteral(resourceName: "facebook")
//        img.viewCornerRadius = 25
//        img.translatesAutoresizingMaskIntoConstraints = false
//        return img
//    }()
//    private lazy var userNameLable: UILabel = {
//        let label = UILabel()
//        label.textColor = .darkGray
//        label.text = "sadsaddas"
//        label.textAlignment = .right
//        label.font = .CairoSemiBold(of: 14)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    private lazy var dateLable: UILabel = {
//        let label = UILabel()
//        label.textColor = .lightGray
//        label.text = "asdasd"
//        label.textAlignment = .right
//        label.font = .CairoRegular(of: 14)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    private lazy var chatImage: UIImageView = {
//        let img = UIImageView()
//        img.clipsToBounds = true
//        img.contentMode = .scaleToFill
//        img.image = #imageLiteral(resourceName: "chat").withRenderingMode(.alwaysTemplate)
//        img.tintColor = .gray
//        img.viewCornerRadius = 40
//        img.translatesAutoresizingMaskIntoConstraints = false
//        return img
//    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setupCell() {
        contentView.addSubview(userNameLable)
        userNameLable.topAnchorSuperView(constant: 10)
        userNameLable.trailingAnchorAnchorSuperView(constant: -10)
//        userNameLable.leadingAnchorSuperView(constant: 10)
        
        contentView.addSubview(messageLable)
        messageLable.bottomAnchorSuperView(constant: -10)
        messageLable.trailingAnchorAnchorSuperView(constant: -10)
//        messageLable.leadingAnchorSuperView(constant: 10)
        
        contentView.addSubview(dateLable)
        dateLable.leadingAnchorSuperView(constant: 10)
        dateLable.topAnchorSuperView(constant: 5)
//        contentView.addSubview(userImage)
//        userImage.widthAnchorConstant(constant: 50)
//        userImage.heightAnchorEqualWidthAnchor()
//        userImage.trailingAnchorAnchorSuperView(constant: -10)
//        userImage.centerYInSuperview()
//
//        contentView.addSubview(userNameLable)
//        userNameLable.topAnchorToView(anchor: userImage.topAnchor)
//        userNameLable.trailingAnchorToView(anchor: userImage.leadingAnchor, constant: -5)
//        userNameLable.leadingAnchorSuperView(constant: 10)
//
//        contentView.addSubview(dateLable)
//        dateLable.bottomAnchorToView(anchor: userImage.bottomAnchor)
//        dateLable.trailingAnchorToView(anchor: userImage.leadingAnchor, constant: -5)
//        dateLable.leadingAnchorSuperView(constant: 10)
//
//        contentView.addSubview(chatImage)
//        chatImage.centerYInSuperview()
//        chatImage.widthAnchorConstant(constant: 30)
//        chatImage.heightAnchorConstant(constant: 20)
//        chatImage.leadingAnchorSuperView(constant: 10)
    }
    
    // MARK: - ConfigurableCell
    func configure(_ item: Notifications) {
        userNameLable.text = item.title
        dateLable.text = item.createdAt
        messageLable.text = item.body

    }
}

struct AllNotification: BaseCodable {
    var status: Int
    
    var msg: String?
    

    let data: NotificationClass
}

struct NotificationClass: Codable {
    let notifications: [Notifications]
    let paginate: Paginate
}

struct Notifications: Codable {
    let id: Int
    let title, body, receiver, createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, body, receiver
        case createdAt = "created_at"
    }
}
