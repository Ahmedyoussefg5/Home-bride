//
//  LoginViewController.swift
//  Awfr Client
//
//  Created by Youssef on 4/14/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit
import FirebaseMessaging

class UserRegisterViewController: BaseUIViewController<UserRegisterView>, SendResult, SendMapResult {
    
    func location(name: String, lat: String, long: String) {
        mainView.locationButton.setTitleNormalState(name)
        self.long = long
        self.lat = lat
    }
    
    weak var sender: CreateAccountButton?
    
    func result(name: String) {
        sender?.setTitleNormalState(name)
    }
    
    var rigonId: Int
    var catId: Int
    var long: String = ""
    var lat: String = ""

    func reg(){
        guard let fName = mainView.firstNameText.text, fName.count > 2 else {
            showAlert(title: "خطأ", message: "تأكد من اسمك الاول")
            return
        }
        guard let sName = mainView.secNameText.text, sName.count > 2 else {
            showAlert(title: "خطأ", message: "تأكد من اسمك الثاني")
            return
        }
        guard let mail = mainView.mailText.text, mail.isEmail else {
            showAlert(title: "خطأ", message: "تأكد من البريد الالكتروني")
            return
        }
        guard let pass = mainView.passText.text, !pass.isEmpty, pass == mainView.passConfirmText.text, pass.count > 5 else {
            showAlert(title: "خطأ", message: "تأكد من كلمة المرور, اكثر من ٥ حروف")
            return
        }
        guard let phone = mainView.phoneText.text, phone.count > 4, phone.isInt else {
            showAlert(title: "خطأ", message: "تأكد من هاتفك الصحيح")
            return
        }
        
        var url = "http://m4a8el.panorama-q.com/api/auth/register/provider"
        var pars = ["first_name": fName,
                    "last_name": sName,
                    "email": mail,
                    "phone": phone,
                    "password": pass,
                    "region_id": rigonId,
                    "sub_category_id": catId,
                    "fcm_token_ios": Messaging.messaging().fcmToken ?? "",
                    "location[lat]": lat,
                    "location[long]": long
            ] as [String : Any]
        
        if user == u {
            url = "http://m4a8el.panorama-q.com/api/auth/register/client"
            pars.removeAll()
            pars = ["first_name": fName,
                    "last_name": sName,
                    "email": mail,
                    "phone": phone,
                    "password": pass,
                    "fcm_token_ios": Messaging.messaging().fcmToken ?? ""
            ]
        }
        
        callApi(RegisterModel.self, url: url, parameters: pars) {[weak self](data) in
            if let userr = data {
                guard let userData = userr.data else { return }
                AuthService.instance.setUserDefaults(user: userData)
                if user == u {
                    self?.present(UINavigationController(rootViewController: UserHomeViewController()), animated: true, completion: nil)
                } else {
                    self?.present(HomeTabBarController(), animated: true, completion: nil)
                }
            }
        }
    }
    
    init(catId: Int, rigonId: Int) {
        self.catId = catId
        self.rigonId = rigonId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trasperantNavBar()
        mainView.signUpButton.addTheTarget(action: {[weak self] in
            self?.reg()
        })
        mainView.locationButton.addTheTarget {[weak self] in
            self?.sender = self?.mainView.locationButton
            let map = MapViewController()
            map.delegate = self
            let vc = UINavigationController(rootViewController: map)
            vc.navbarWithdismiss()
            self?.presentModelyVC(vc: vc)
        }
        mainView.tearmsButton.addTheTarget {[weak self] in
            self?.navigationController?.pushViewController(TermsViewController(), animated: true)
        }
    }
}
