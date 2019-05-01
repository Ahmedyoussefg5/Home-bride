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
//            self?.navigationController?.pushViewController(RegisterViewController(), animated: true)
        })
//        mainView.loginButton.addTheTarget(action: {[weak self] in
////            self?.present(UINavigationController(rootViewController: HomeViewController()), animated: true, completion: nil)
//        })
    }
    
    func sendNumber() {
        guard let num = mainView.phoneTextView.text else { return }
        let pars = [
            "phone": num
        ]
        callApi(ForgetData.self, url: "http://m4a8el.panorama-q.com/api/auth/forget", parameters: pars) {[weak self] (data) in
            if data != nil {
                self?.navigationController?.pushViewController(VerifyViewController(), animated: true)
            }
        }
    }


}

struct ForgetData: BaseCodable {
    var status: Int
    
    var msg: String?
    
    let data: String
}
