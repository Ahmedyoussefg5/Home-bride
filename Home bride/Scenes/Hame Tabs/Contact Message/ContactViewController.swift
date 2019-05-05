//
//  ContactViewController.swift
//  Home bride
//
//  Created by Youssef on 5/1/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "تواصل معنا"
        
        view.backgroundColor = .white
        
        view.addSubview(messageTextView)
        messageTextView.centerXInSuperview()
        messageTextView.topAnchorSuperView(constant: 50)
        messageTextView.widthAnchorWithMultiplier(multiplier: 0.9)
        messageTextView.bottomAnchorSuperView(constant: -100)
        
        view.addSubview(confirmButton)
        confirmButton.centerXInSuperview()
        confirmButton.widthAnchorWithMultiplier(multiplier: 0.9)
        confirmButton.heightAnchorConstant(constant: 45)
        confirmButton.bottomAnchorSuperView(constant: -30)
        
        // Do any additional setup after loading the view.
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
        return txtView
    }()
    lazy var confirmButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("ارسال", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .CairoSemiBold(of: 15)
        btn.layer.cornerRadius = 15
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.9285544753, green: 0.3886299729, blue: 0.6461874247, alpha: 1)
        btn.addTheTarget(action: {[weak self] in
            self?.send()
        })
        return btn
    }()

    func send() {
        guard messageTextView.text.count > 2 else {
            return
        }
        
        callApi(SendMess.self, url: "http://m4a8el.panorama-q.com/api/contact", parameters: ["message": messageTextView.text]) {[weak self] (data) in
            self?.showAlert(title: "", message: data?.data)
        }
    }

}

struct SendMess: BaseCodable {
    var status: Int
    
    var msg: String?
    
    let data: String
}
