//
//  LoginViewController.swift
//  Awfr Client
//
//  Created by Youssef on 4/14/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class VerifyView: BaseView {
    private lazy var logo: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.image = #imageLiteral(resourceName: "Logo")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    private lazy var loginView: UIView = {
        let view = UIView()
        view.viewCornerRadius = 30
        view.backgroundColor = .white
        view.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.19), alpha: 1, x: 0, y: 3, blur: 2, spread: 0)
        return view
    }()

    private lazy var codeTextView: CreateAccountText = {
        let view = CreateAccountText(title: "asdsaasd", image: #imageLiteral(resourceName: "user"))
        return view
    }()
    lazy var loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitleNormalState("Activate".localize)
        btn.titleLabel?.font = .CairoBold(of: 15)
        btn.backgroundColor = .white
        btn.viewCornerRadius = 23
        btn.applySketchShadow()
        btn.viewBorderWidth = 0.5
        btn.viewBorderColor = .lightGray
        btn.setTitleColorNormalState(#colorLiteral(red: 0.02565180697, green: 0.2200095952, blue: 0.4220862985, alpha: 1))
        return btn
    }()
    lazy var retryCodeButton: UIButton = {
        let btn = UIButton(type: .system)
        let attString = NSMutableAttributedString(texts: ["Did Not Recieve Code ", "Resend Now."], fonts: [.CairoRegular(of: 13), .CairoBold(of: 12)], colors: [.white, .white])
        btn.setAttributedTitle(attString, for: .normal)
        btn.setTitleColorNormalState(#colorLiteral(red: 0.03138558939, green: 0.2165760994, blue: 0.389033407, alpha: 1))
        return btn
    }()
    lazy var errorButton: UIButton = {
        let btn = UIButton(type: .system)
        let attString = NSMutableAttributedString(texts: ["Wrong Phone Number? ", "Change Now."], fonts: [.CairoRegular(of: 13), .CairoBold(of: 12)], colors: [.white, .white])
        btn.setAttributedTitle(attString, for: .normal)
        btn.setTitleColorNormalState(#colorLiteral(red: 0.03138558939, green: 0.2165760994, blue: 0.389033407, alpha: 1))
        return btn
    }()
//    let chatTxt: UITextField = {
//        let txt = UITextField()
//        txt.textAlignment = .natural
//        txt.translatesAutoresizingMaskIntoConstraints = false
//        txt.placeholder = "Write Your Message ...".localize
//        txt.backgroundColor = .white
//        txt.textColor = .darkGray
//        txt.font = .CairoSemiBold(of: 15)
//        txt.layer.borderColor = UIColor.paleGreyTwo.cgColor
//        txt.layer.borderWidth = 1
//        txt.setLeftPaddingPoints(5)
//        txt.setRightPaddingPoints(5)
//        txt.isEnabled = false
//        txt.layer.cornerRadius = 6.0
//        txt.returnKeyType = .send
//        return txt
//    }()
    override func setupView() {
        addSubview(backgroundImage)
        backgroundImage.fillSuperview()
        
        addSubview(logo)
        ActivateConstraint([
            logo.centerXInSuperview(),
            logo.topAnchorSuperView(constant: 5),
            logo.widthAnchorWithMultiplier(multiplier: 0.55),
            logo.heightAnchorWithMultiplier(multiplier: 0.2)
            ])
        
        addSubview(loginView)
        ActivateConstraint([
            loginView.centerXInSuperview(),
            loginView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 10),
            loginView.widthAnchorWithMultiplier(multiplier: 0.9),
            loginView.heightAnchorConstant(constant: 120)
            ])
        
        loginView.addSubview(codeTextView)
        ActivateConstraint([
            codeTextView.centerXInSuperview(),
            codeTextView.topAnchorSuperView(constant: 10),
            codeTextView.widthAnchorWithMultiplier(multiplier: 0.9),
            codeTextView.heightAnchorConstant(constant: 50)
            ])
        
        addSubview(loginButton)
        ActivateConstraint([
            loginButton.centerXInSuperview(),
            loginButton.bottomAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 22.5),
            loginButton.heightAnchorConstant(constant: 45),
            loginButton.widthAnchorWithMultiplier(multiplier: 0.5)
            ])
        
        addSubview(retryCodeButton)
        ActivateConstraint([
            retryCodeButton.centerXInSuperview(),
            retryCodeButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            retryCodeButton.widthAnchorWithMultiplier(multiplier: 0.9)
            ])
        
        addSubview(errorButton)
        ActivateConstraint([
            errorButton.centerXInSuperview(),
            errorButton.bottomAnchorSuperView(constant: -10),
            errorButton.widthAnchorWithMultiplier(multiplier: 0.9)
            ])
    }
}
