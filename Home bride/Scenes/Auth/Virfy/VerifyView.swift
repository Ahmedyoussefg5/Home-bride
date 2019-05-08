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
        img.image = #imageLiteral(resourceName: "logoWhite")
        img.viewBorderWidth = 5
        img.viewBorderColor = #colorLiteral(red: 0.4112357795, green: 0.1550137103, blue: 0.3776766956, alpha: 1)
        img.backgroundColor = mediumPurple
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    lazy var phoneTextView: LoginTextField = {
        let view = LoginTextField(placeHolder: "ادخل الكود".localize)
        view.backgroundColor = darkPurple
        return view
    }()
    
    lazy var passText: CreateAccountText = {
        let btn = CreateAccountText(title: "كلمة المرور الجديدة", image: nil)
        btn.isSecureTextEntry = ya
        return btn
    }()
    lazy var passConfirmText: CreateAccountText = {
        let btn = CreateAccountText(title: "تأكيد كلمة المرور", image: nil)
        btn.isSecureTextEntry = ya
        return btn
    }()
    
    lazy var sendButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitleNormalState("ارسال".localize)
        btn.titleLabel?.font = .CairoBold(of: 15)
        btn.backgroundColor = .white
        btn.viewCornerRadius = 20
        btn.setTitleColorNormalState(mediumPurple)
        return btn
    }()
    lazy var resendButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitleNormalState("اعادة ارسال".localize)
        btn.setTitleColorNormalState(#colorLiteral(red: 0.9568627451, green: 0.968627451, blue: 0.9803921569, alpha: 1))
        btn.titleLabel?.font = UIFont.CairoSemiBold(of: 14)
        btn.titleLabel?.underline()
        return btn
    }()
    
    lazy var gradientLayer = LinearGradientLayer(colors: [mediumPurple, lightPurple])
    
    override func setupView() {
        layer.insertSublayer(gradientLayer, at: 0)
        addSubview(logo)
        ActivateConstraint([
            logo.centerXInSuperview(),
            logo.topAnchorSuperView(constant: 30),
            logo.widthAnchorConstant(constant: 100),
            logo.heightAnchorEqualWidthAnchor()
            ])
        //
        let title = UILabel()
        title.text = "ادخل رقم الجوال للحصول على الكود"
        title.font = UIFont.CairoRegular(of: 14)
        title.textColor = .white
        title.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews:
            [title,
             phoneTextView,
             stackSpliter(),
             passText,
             passConfirmText,
             stackSpliter(),
             stackSpliter(),
             sendButton,
             resendButton,
             ])
        
        stack.axis = v
        stack.distribution = .fillProportionally
        stack.spacing = 13
        addSubview(stack)
        stack.centerXInSuperview()
        stack.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 20).isActive = ya
        stack.widthAnchorWithMultiplier(multiplier: 0.9)
        stack.heightAnchorConstant(constant: 350)
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = bounds
    }
}
