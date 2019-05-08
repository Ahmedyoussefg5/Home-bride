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
        
        mainView.sendButton.addTheTarget {[weak self] in
            self?.sendNumber()
        }
        
        mainView.resendButton.addTheTarget {[weak self] in
            self?.resend()
        }
    }
    
    var phone: String
    
    init(phone: String) {
        self.phone = phone
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sendNumber() {
        
        guard let pass = mainView.passText.text, !pass.isEmpty, pass == mainView.passConfirmText.text, pass.count > 5 else {
            showAlert(title: "خطأ", message: "تأكد من كلمة المرور, اكثر من ٥ حروف")
            return
        }
        guard let code = mainView.phoneTextView.text, !pass.isEmpty else {
//            showAlert(title: "خطأ", message: "تأكد من كلمة المرور, اكثر من ٥ حروف")
            return
        }
        
        let pars = [
            "phone": phone,
            "reset_code": code,
            "password": pass,
            "password_confirmation": pass
        ]
        callApi(UserReset.self, url: "http://m4a8el.panorama-q.com/api/auth/reset", parameters: pars) {[weak self] (data) in
            if let data = data {
                guard let us = data.data else { return }
                AuthService.instance.authToken = us.token
                AuthService.instance.setUserDefaults(reset: us)
                if data.data?.role == "client" {
                    user = u
                    self?.present(UINavigationController(rootViewController: UserHomeViewController()), animated: true, completion: nil)
                } else {
                    user = p
                    self?.present(HomeTabBarController(), animated: true, completion: nil)
                }
            }
        }
    }

    func resend() {
            guard let num = mainView.phoneTextView.text, num.count > 5 else {
                showAlert(title: "خطأ", message: "تأكد من هاتفك")
                return }
            let pars = [
                "phone": num
            ]
            callApi(ForgetData.self, url: "http://m4a8el.panorama-q.com/api/auth/forget", parameters: pars) {[weak self] (data) in
                if data != nil {
                    self?.showAlert(title: "", message: "تم الارسال")
                }
            }
    }
}

struct UserReset: BaseCodable {
    var status: Int
    var msg: String?
    let data: UserSet?
}

struct UserSet: Codable {
    let id: Int?
    let firstName, lastName, email, phone: String?
    let role: String?
    let isVerified: Int?
    let image: String?
    let social: Social?
    let birthDate, gender, job: String?
    let location: Location?
    let regionID: Int?
    let token: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email, phone, role
        case isVerified = "is_verified"
        case image, social
        case birthDate = "birth_date"
        case gender, job, location
        case regionID = "region_id"
        case token
    }
}
