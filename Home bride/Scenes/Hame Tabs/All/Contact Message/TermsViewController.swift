//
//  ContactViewController.swift
//  Home bride
//
//  Created by Youssef on 5/1/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController {
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        openedViewController = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "الشروط والاحكام"
        
        view.backgroundColor = .white
        
        view.addSubview(messageTextView)
        messageTextView.centerXInSuperview()
        messageTextView.topAnchorSuperView(constant: 50)
        messageTextView.widthAnchorWithMultiplier(multiplier: 0.9)
        messageTextView.bottomAnchorSuperView(constant: -100)
        
        send()
    }
    let messageTextView: UITextView = {
        let txtView = UITextView()
        txtView.backgroundColor = .paleGrey
        txtView.layer.cornerRadius = 8
        txtView.layer.borderWidth = 1
        txtView.layer.borderColor = UIColor.paleGreyTwo.cgColor
        txtView.font = .CairoBold(of: 14)
        txtView.textColor = .blueGrey
        txtView.textAlignment = .natural
        txtView.translatesAutoresizingMaskIntoConstraints = false
        txtView.isEditable = no
        return txtView
    }()

    func send() {
        callApi(Terms.self, url: "http://homebride-sa.com/api/terms", method: .get, parameters: nil) {[weak self] (data) in
            self?.messageTextView.text = data?.data
        }
    }

}
struct Terms: BaseCodable {
    var status: Int
    var msg: String?
    let data: String?
}
