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
    
    var messages = [String]() {
        didSet {
            mainView.mainTableView.reloadData()
            if self.messages.count > 3 {
                mainView.mainTableView.scrollToBottom()
            }
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }; required init?(coder aDecoder: NSCoder) {
        fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.mainTableView.delegate = self
        mainView.mainTableView.dataSource = self
        mainView.chatTxt.delegate = self
        mainView.sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideKeyboardWhenTappedAround()
    }

    @objc private func sendMessage() {
        guard let message = mainView.chatTxt.text , message.count > 0 else { return }
        mainView.chatTxt.text = ""
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
