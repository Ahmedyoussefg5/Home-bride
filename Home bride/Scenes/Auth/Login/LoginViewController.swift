//
//  LoginViewController.swift
//  Awfr Client
//
//  Created by Youssef on 4/14/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit
import FirebaseMessaging

class LoginViewController: BaseUIViewController<LoginView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trasperantNavBar()
        mainView.signUpButton.addTheTarget(action: {[weak self] in
            if user == u {
                self?.navigationController?.pushViewController(UserRegisterViewController(catId: 1, rigonId: 1), animated: true)
                return
            }
            self?.navigationController?.pushViewController(RegisterViewController(), animated: true)
        })
        mainView.loginButton.addTheTarget(action: {[weak self] in
            self?.login()
        })
        
        mainView.forgetButton.addTheTarget(action: {[weak self] in
            self?.navigationController?.pushViewController(ForgetPasswordController(), animated: true)
        })
        
    }
    
    func login(){
        guard let mail = mainView.mailTextView.text, mail.isEmail else {
            showAlert(title: "خطأ", message: "تأكد من البريد الالكتروني")
            return
        }
        guard let pass = mainView.passwordTextView.text, !pass.isEmpty, pass.count > 5 else {
            showAlert(title: "خطأ", message: "تأكد من كلمة المرور, اكثر من ٥ حروف")
            return
        }
        
        let url = "http://m4a8el.panorama-q.com/api/auth/login"
        let pars = [
                    "email": mail,
                    "password": pass,
                    "fcm_token_ios": Messaging.messaging().fcmToken ?? ""
            ] as [String : Any]
        
        callApi(RegisterModel.self, url: url, parameters: pars) {[weak self] (data) in
            if let userr = data {
                guard let userData = userr.data else { return }
                AuthService.instance.setUserDefaults(user: userData)
                if userr.data?.role == "client" {
                    user = u
                    self?.present(UINavigationController(rootViewController: UserHomeViewController()), animated: true, completion: nil)
                } else {
                    user = p
                    self?.present(HomeTabBarController(), animated: true, completion: nil)
                }
            }
        }
        
    }

}
