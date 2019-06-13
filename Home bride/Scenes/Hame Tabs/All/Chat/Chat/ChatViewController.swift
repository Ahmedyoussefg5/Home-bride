//
//  CardPageVC.swift
//  Gawla
//
//  Created by Youssef on 11/11/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    var mainView = ChatView()
    override func loadView() {
        view = mainView
    }
    
    var orderId: Int
    var name: String

    init(orderId: Int, name: String) {
        self.orderId = orderId
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }; required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
//    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMess()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "رجوع", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissMePlease))
        setupNavBarApperance(title: "", addImageTitle: no, showNotifButton: no)
        title = name
        mainView.mainTableView.delegate = self
        mainView.mainTableView.dataSource = self
        mainView.mainTableView.keyboardDismissMode = .onDrag
        mainView.chatTxt.delegate = self
        mainView.sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(getMess), name: .didReciveMessage, object: nil)
    }
    
    @objc func getMess() {
        
        callApi(AllMessData.self, url: "http://m4a8el.panorama-q.com/api/chat/\(orderId)", method: .get, parameters: nil) {[weak self] (data) in
//            if self?.messages == nil {
                if let data = data, self?.messages?.count ?? 0 != data.data?.messages.messages.count ?? 0 {
                    self?.lastPage = data.data?.messages.paginate?.totalPages ?? 1
                    self?.currentPage = 1
                    self?.isLoading = false
                    self?.messages = data.data?.messages.messages.reversed()
                    self?.paginate()
                }
//            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.applicationIconBadgeNumber = 0
//        hideKeyboardWhenTappedAround()
    }
    
    var messages: [Message]? {
        didSet {
            mainView.mainTableView.reloadData()
            if self.messages?.count ?? 0 > 3 {
//                if !isLoading {
                    mainView.mainTableView.scrollToBottom()
//                }
            }
        }
    }

    @objc private func sendMessage() {
        guard let message = mainView.chatTxt.text , message.trimmedString.count > 0 else { return }
        
        mainView.chatTxt.text = ""
        
        let pars = [
            "order_id": orderId,
            "message": message
            ] as [String : Any]
        
        callApi(AllMessData.self, url: "http://m4a8el.panorama-q.com/api/chat", parameters: pars) {[weak self] (data) in
            if let data = data {
                self?.messages = data.data?.messages.messages.reversed()
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
        
        let url = "http://m4a8el.panorama-q.com/api/chat/\(orderId)?page=\(currentPage + 1)"
        
        callApi(AllMessData.self, url: url, method: .get, parameters: nil) {[weak self] (data) in
            guard let self = self else { return }
            if let data = data, let da = data.data {
                self.messages?.insert(contentsOf: da.messages.messages, at: 0)
                self.currentPage += 1
                self.isLoading = false
                self.paginate()
            }
        }
    }
}

extension ChatViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = textField.text?.count ?? 0 + string.count - range.length
        return newLength <= 250
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
}

struct AllMessData: BaseCodable {
    var status: Int
    var msg: String?
    let data: MessClass?
}

struct MessClass: Codable {
    let status, chatID, orderID, providerID: Int
    let providerName: String
    let providerImage: String
    let clientID: Int
    let clientName: String
    let clientImage: String
    let messages: Messages
    
    enum CodingKeys: String, CodingKey {
        case status
        case chatID = "chat_id"
        case orderID = "order_id"
        case providerID = "provider_id"
        case providerName = "provider_name"
        case providerImage = "provider_image"
        case clientID = "client_id"
        case clientName = "client_name"
        case clientImage = "client_image"
        case messages
    }
}

struct Messages: Codable {
    let messages: [Message]
    let paginate: Paginate?
}

struct Message: Codable {
    let userToID: Int
    let userToName, userToRole: String
    let userFromID: Int
    let userFrom, userFromRole, message, createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case userToID = "user_to_id"
        case userToName = "user_to_name"
        case userToRole = "user_to_role"
        case userFromID = "user_from_id"
        case userFrom = "user_from"
        case userFromRole = "user_from_role"
        case message
        case createdAt = "created_at"
    }
}
