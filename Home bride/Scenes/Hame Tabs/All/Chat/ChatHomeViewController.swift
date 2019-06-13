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
        sendMessage()
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendMessage), name: .didReciveMessage, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sendMessage()
    }
    
    var chat: [Chat]? {
        didSet {
            mainView.mainTableView.reloadData()
        }
    }
    
    @objc private func sendMessage() {
        callApi(AllChat.self, url: "http://m4a8el.panorama-q.com/api/chat", method: .get, parameters: nil) {[weak self] (data) in
            if let data = data {
                self?.chat = data.data?.chats
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatHomeTableCell", for: indexPath) as! ChatHomeTableCell
        if let data = chat?[indexPath.row] {
            cell.configure(data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let data = chat?[indexPath.row] {
            var name = ""
            if user == p {
                name = data.clientName ?? ""
            } else {
                name = data.providerName ?? ""
            }
            let vc = UINavigationController(rootViewController: ChatViewController(orderId: data.orderID ?? 0, name: name))
//            vc.navbarWithdismiss()
            present(vc, animated: ya, completion: nil)
        }
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
    func configure(_ item: Chat) {
        if user == p {
            userImage.load(with: item.clientImage)
            userNameLable.text = item.clientName
            messageLable.text = item.lastMessage?.message
            dateLable.text = item.lastMessage?.createdAt
        } else {
            userImage.load(with: item.providerImage)
            userNameLable.text = item.providerName
            messageLable.text = item.lastMessage?.message
            dateLable.text = item.lastMessage?.createdAt
        }
        
    }
}

struct AllChat: BaseCodable {
    var status: Int
    
    var msg: String?
    
    let data: Chats?
}

struct Chats: Codable {
    let chats: [Chat]?
    let paginate: Paginate?
}

struct Chat: Codable {
    let status: Int?
    let providerName: String?
    let providerID, chatID: Int?
    let lastMessage: LastMessage?
    let clientID, orderID: Int?
    let clientName: String?
    let clientImage, providerImage: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case providerName = "provider_name"
        case providerID = "provider_id"
        case chatID = "chat_id"
        case lastMessage = "last_message"
        case clientID = "client_id"
        case orderID = "order_id"
        case clientName = "client_name"
        case clientImage = "client_image"
        case providerImage = "provider_image"
    }
}

struct LastMessage: Codable {
    let message, createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case message
        case createdAt = "created_at"
    }
}
