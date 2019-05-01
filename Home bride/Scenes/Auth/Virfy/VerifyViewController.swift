//
//  LoginViewController.swift
//  Awfr Client
//
//  Created by Youssef on 4/14/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class VerifyViewController: BaseUIViewController<VerifyView> {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trasperantNavBar()
    }
    
    func sendNumber() {
        
        guard let pass = mainView.passText.text, !pass.isEmpty, pass == mainView.passConfirmText.text, pass.count > 5 else {
            showAlert(title: "خطأ", message: "تأكد من كلمة المرور, اكثر من ٥ حروف")
            return
        }
        guard let code = mainView.phoneTextView.text, !pass.isEmpty, pass.count > 1 else {
//            showAlert(title: "خطأ", message: "تأكد من كلمة المرور, اكثر من ٥ حروف")
            return
        }
        
        guard let num = mainView.phoneTextView.text else { return }
        let pars = [
            "phone": num,
            "reset_code": code,
            "password": pass,
            "password_confirmation": pass
        ]
        callApi(ForgetData.self, url: "http://m4a8el.panorama-q.com/api/auth/reset", parameters: pars) {[weak self] (data) in
            if data != nil {
                self?.showAlert(title: nil, message: "قم بتسجيل الدخول بحسابك")
            }
        }
    }

}
