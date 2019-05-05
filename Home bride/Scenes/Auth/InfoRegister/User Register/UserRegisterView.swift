//
//  LoginViewController.swift
//  Awfr Client
//
//  Created by Youssef on 4/14/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit
//import DropDown

class UserRegisterView: BaseView {
    lazy var gradientLayerr = LinearGradientLayer(colors: [mediumPurple, lightPurple])

    private lazy var logo: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        img.image = #imageLiteral(resourceName: "logoWhite")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    private lazy var loginView: UIView = {
        let view = UIView()
        view.viewCornerRadius = 7
        view.backgroundColor = .white
        view.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.19), alpha: 1, x: 0, y: 3, blur: 2, spread: 0)
        return view
    }()
    lazy var phoneText: CreateAccountText = {
        let btn = CreateAccountText(title: "رقم الجوال", image: nil)
        return btn
    }()
    lazy var firstNameText: CreateAccountText = {
        let btn = CreateAccountText(title: "الاسم الاول", image: nil)
        return btn
    }()
    lazy var secNameText: CreateAccountText = {
        let btn = CreateAccountText(title: "الاسم الثاني", image: nil)
        return btn
    }()
    lazy var passText: CreateAccountText = {
        let btn = CreateAccountText(title: "كلمة المرور", image: nil)
        btn.isSecureTextEntry = ya
        return btn
    }()
    lazy var passConfirmText: CreateAccountText = {
        let btn = CreateAccountText(title: "تأكيد كلمة المرور", image: nil)
        btn.isSecureTextEntry = ya
        return btn
    }()
    lazy var mailText: CreateAccountText = {
        let btn = CreateAccountText(title: "البريد الالكتروني", image: nil)
        return btn
    }()
    lazy var faceButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setBackgroundImage(#imageLiteral(resourceName: "facebook"), for: .normal)
        btn.viewCornerRadius = 15
        return btn
    }()
    lazy var googleButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setBackgroundImage(#imageLiteral(resourceName: "twitter (1)"), for: .normal)
        btn.viewCornerRadius = 15
        return btn
    }()
    
    lazy var signUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("التالي", for: .normal)
        btn.titleLabel?.font = .CairoBold(of: 15)
        btn.viewCornerRadius = 20
        btn.setTitleColorNormalState(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        btn.layer.insertSublayer(gradientLayer, at: 0)
        return btn
    }()
    
    lazy var gradientLayer = LinearGradientLayer(colors: [mediumPurple, lightPurple])
    
    override func setupView() {
        layer.insertSublayer(gradientLayerr, at: 0)

        addSubview(logo)
        ActivateConstraint([
            logo.centerXInSuperview(),
            logo.topAnchorSuperView(constant: 5),
            logo.widthAnchorWithMultiplier(multiplier: 0.3),
            logo.heightAnchorWithMultiplier(multiplier: 0.1)
            ])
        
        addSubview(loginView)
        ActivateConstraint([
            loginView.centerXInSuperview(),
            loginView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 10),
            loginView.widthAnchorWithMultiplier(multiplier: 0.9),
            loginView.bottomAnchorSuperView(constant: 10)
            ])
        //
        let title = UILabel()
        title.text = "انشاء حساب"
        title.font = UIFont.CairoBold(of: 14)
        title.textColor = #colorLiteral(red: 0.3281314075, green: 0.3139006495, blue: 0.3135607243, alpha: 1)
        title.textAlignment = .center
        
        let titlee = UILabel()
        titlee.text = "او سجل من خلال حسابات التواصل"
        titlee.font = .CairoRegular(of: 14)
        titlee.underline()
        titlee.textColor = #colorLiteral(red: 0.2459094524, green: 0.3761512339, blue: 0.6553276181, alpha: 1)
        titlee.textAlignment = .center
        
        let socialStack = UIStackView(arrangedSubviews: [faceButton, googleButton])
        socialStack.axis = .horizontal
        socialStack.distribution = .fillEqually
        socialStack.spacing = 20
        //

        //
        let stack = UIStackView(arrangedSubviews:
            [title,
             firstNameText,
             secNameText,
             phoneText,
             passText,
             passConfirmText,
             mailText,
             stackSpliter(),
             signUpButton,
             titlee,
            ])
        
        stack.axis = v
        stack.distribution = .fillProportionally
        stack.spacing = 13
        loginView.addSubview(stack)
        stack.centerXInSuperview()
        stack.topAnchorSuperView(constant: 10)
        stack.widthAnchorWithMultiplier(multiplier: 0.9)
        stack.heightAnchorConstant(constant: 430)

        loginView.addSubview(socialStack)
        socialStack.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 20).isActive = true
        socialStack.widthAnchorConstant(constant: 100)
        socialStack.heightAnchorConstant(constant: 40)
        socialStack.centerXInSuperview()
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = signUpButton.bounds
        gradientLayerr.frame = bounds
        gradientLayer.cornerRadius = 20
    }
}
