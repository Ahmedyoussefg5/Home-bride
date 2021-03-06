//
//  LoginViewController.swift
//  Awfr Client
//
//  Created by Youssef on 4/14/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class ForgetPasswordController: BaseUIViewController<ForgetPasswordView> {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trasperantNavBar()
        mainView.sendButton.addTheTarget(action: {[weak self] in
            self?.sendNumber()
        })
    }
    
    func sendNumber() {
        guard let num = mainView.phoneTextView.text, num.count > 5 else {
            showAlert(title: "خطأ", message: "تأكد من هاتفك")
            return }
        let pars = [
            "phone": num
        ]
        callApi(ForgetData.self, url: "http://homebride-sa.com/api/auth/forget", parameters: pars) {[weak self] (data) in
            if data != nil {
                self?.navigationController?.pushViewController(VerifyViewController(phone: num), animated: true)
            }
        }
    }


}

struct ForgetData: BaseCodable {
    var status: Int
    
    var msg: String?
    
    let data: String
}
