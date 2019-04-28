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
//        mainView.signUpButton.addTheTarget(action: {[weak self] in
//            self?.navigationController?.pushViewController(RegisterViewController(), animated: true)
//        })
//        mainView.loginButton.addTheTarget(action: {[weak self] in
////            self?.present(UINavigationController(rootViewController: HomeViewController()), animated: true, completion: nil)
//        })
    }
    


}
