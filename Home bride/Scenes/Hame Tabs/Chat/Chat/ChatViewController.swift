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
    
    init(orderId: Int) {
        self.orderId = orderId
        super.init(nibName: nil, bundle: nil)
    }; required init?(coder aDecoder: NSCoder) {
        fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "رجوع", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissMePlease))
        mainView.mainTableView.delegate = self
        mainView.mainTableView.dataSource = self
        mainView.chatTxt.delegate = self
        mainView.sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
    }
    
    func getMess() {

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideKeyboardWhenTappedAround()
    }
    
    var messages: [Message]? {
        didSet {
            mainView.mainTableView.reloadData()
            if self.messages?.count ?? 0 > 3 {
                mainView.mainTableView.scrollToBottom()
            }
        }
    }

    @objc private func sendMessage() {
        guard let message = mainView.chatTxt.text , message.count > 0 else { return }
        self.mainView.chatTxt.text = ""
        let pars = [
            "order_id": orderId,
            "message": message
            ] as [String : Any]
        callApi(AllMessData.self, url: "http://m4a8el.panorama-q.com/api/chat", parameters: pars) {[weak self] (data) in
            if let data = data {
                self?.messages = data.data.messages.messages.reversed()
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

// To parse the JSON, add this file to your project and do:
//
//   let allSalonsData = try? newJSONDecoder().decode(AllSalonsData.self, from: jsonData)

import Foundation

struct AllMessData: BaseCodable {
    var status: Int
    var msg: String?
    let data: MessClass
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
    let paginate: Paginate
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
