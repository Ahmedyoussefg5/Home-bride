//
//  LoginViewController.swift
//  Awfr Client
//
//  Created by Youssef on 4/14/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class LoginView: BaseView {
    private lazy var logo: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.image = #imageLiteral(resourceName: "logoWhite")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    lazy var mailTextView: LoginTextField = {
        let view = LoginTextField(placeHolder: "البريد الالكتروني".localize)
        view.backgroundColor = darkPurple
        return view
    }()
    lazy var passwordTextView: LoginTextField = {
        let view = LoginTextField(placeHolder: "كلمة المرور".localize)
        view.isSecureTextEntry = ya
        view.backgroundColor = darkPurple
        return view
    }()
    lazy var loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitleNormalState("الدخول".localize)
        btn.titleLabel?.font = .CairoBold(of: 15)
        btn.backgroundColor = .white
        btn.viewCornerRadius = 20
        btn.setTitleColorNormalState(mediumPurple)
        return btn
    }()
    lazy var forgetButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitleNormalState("هل نسيت كلمة المرور".localize)
        btn.setTitleColorNormalState(#colorLiteral(red: 0.9568627451, green: 0.968627451, blue: 0.9803921569, alpha: 1))
        btn.titleLabel?.font = UIFont.CairoSemiBold(of: 14)
        return btn
    }()
    lazy var signUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("ليس لديك حساب؟ سجل الان", for: .normal)
        btn.titleLabel?.underline()
        btn.titleLabel?.font = UIFont.CairoSemiBold(of: 14)
        btn.setTitleColorNormalState(#colorLiteral(red: 0.9568627451, green: 0.968627451, blue: 0.9803921569, alpha: 1))
        return btn
    }()
    
    lazy var gradientLayer = LinearGradientLayer(colors: [mediumPurple, lightPurple])

    override func setupView() {
        layer.insertSublayer(gradientLayer, at: 0)
        addSubview(logo)
        ActivateConstraint([
            logo.centerXInSuperview(),
            logo.topAnchorSuperView(constant: 30),
            logo.widthAnchorWithMultiplier(multiplier: 0.55),
            logo.heightAnchorWithMultiplier(multiplier: 0.2)
            ])
        
        addSubview(mailTextView)
        ActivateConstraint([
            mailTextView.centerXInSuperview(),
            mailTextView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 30),
            mailTextView.widthAnchorWithMultiplier(multiplier: 0.8),
            mailTextView.heightAnchorConstant(constant: 40)
            ])
        
        addSubview(passwordTextView)
        ActivateConstraint([
            passwordTextView.centerXInSuperview(),
            passwordTextView.topAnchor.constraint(equalTo: mailTextView.bottomAnchor, constant: 15),
            passwordTextView.widthAnchorWithMultiplier(multiplier: 0.8),
            passwordTextView.heightAnchorConstant(constant: 40)
            ])
        
        addSubview(loginButton)
        ActivateConstraint([
            loginButton.centerXInSuperview(),
            loginButton.topAnchor.constraint(equalTo: passwordTextView.bottomAnchor, constant: 20),
            loginButton.heightAnchorConstant(constant: 45),
            loginButton.widthAnchorWithMultiplier(multiplier: 0.8)
            ])
        
        addSubview(forgetButton)
        ActivateConstraint([
            forgetButton.centerXInSuperview(),
            forgetButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            forgetButton.heightAnchorConstant(constant: 40),
            forgetButton.widthAnchorWithMultiplier(multiplier: 0.8)
            ])

        addSubview(signUpButton)
        ActivateConstraint([
            signUpButton.centerXInSuperview(),
            signUpButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            signUpButton.widthAnchorWithMultiplier(multiplier: 0.9),
            signUpButton.heightAnchorConstant(constant: 64),
            ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
