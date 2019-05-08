//
//  LoginViewController.swift
//  Awfr Client
//
//  Created by Youssef on 4/14/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit
//import DropDown

class RegisterView: BaseView {
//    private lazy var backgroundImage: UIImageView = {
//        let img = UIImageView()
//        img.clipsToBounds = true
//        img.contentMode = .scaleAspectFill
//        let image = #imageLiteral(resourceName: "BG ")
//        img.image = image.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: -200, right: 0))
//        img.translatesAutoresizingMaskIntoConstraints = false
//        return img
//    }()
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
    
    lazy var gradientLayer = LinearGradientLayer(colors: [mediumPurple, lightPurple])
//    lazy var locationButton: CreateAccountButton = {
//        let btn = CreateAccountButton(title: "تحديد المكان", image: #imageLiteral(resourceName: "facebook-placeholder-for-locate-places-on-maps").withRenderingMode(.alwaysTemplate))
//        return btn
//    }()
    lazy var locationAreaButton: CreateAccountButton = {
        let btn = CreateAccountButton(title: "منطقة", image: #imageLiteral(resourceName: "downArrow").withRenderingMode(.alwaysTemplate))
        return btn
    }()
    lazy var locationCityButton: CreateAccountButton = {
        let btn = CreateAccountButton(title: "مدينة", image: #imageLiteral(resourceName: "downArrow").withRenderingMode(.alwaysTemplate))
        return btn
    }()
    lazy var locationDistinctButton: CreateAccountButton = {
        let btn = CreateAccountButton(title: "حي", image: #imageLiteral(resourceName: "downArrow").withRenderingMode(.alwaysTemplate))
        return btn
    }()
    lazy var costText: CreateAccountText = {
        let btn = CreateAccountText(title: "سعر الذهاب للمنزل", image: #imageLiteral(resourceName: "user-verification-symbol-for-interface").withRenderingMode(.alwaysTemplate))
        btn.keyboardType = .asciiCapableNumberPad
        return btn
    }()
    lazy var mainJobButton: CreateAccountButton = {
        let btn = CreateAccountButton(title: "القسم الرئيسي", image: #imageLiteral(resourceName: "downArrow").withRenderingMode(.alwaysTemplate))
        return btn
    }()
    lazy var secoundryJobButton: CreateAccountButton = {
        let btn = CreateAccountButton(title: "القسم الفرعي", image: #imageLiteral(resourceName: "downArrow").withRenderingMode(.alwaysTemplate))
        return btn
    }()
    lazy var loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitleNormalState("تسجيل".localize)
        btn.titleLabel?.font = .CairoBold(of: 15)
        btn.viewCornerRadius = 20
        btn.setTitleColorNormalState(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        btn.layer.insertSublayer(gradientLayer, at: 0)
        return btn
    }()
    
    override func setupView() {
//        addSubview(backgroundImage)
//        backgroundImage.centerXInSuperview()
//        backgroundImage.topAnchor.constraint(equalTo: topAnchor).isActive = ya
//        backgroundImage.widthAnchorWithMultiplier(multiplier: 1.5)
//        backgroundImage.heightAnchorConstant(constant: 500)
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
        
//        let titlee = UILabel()
//        titlee.text = "او سجل من خلال حسابات التواصل"
//        titlee.font = .CairoRegular(of: 14)
//        titlee.underline()
//        titlee.textColor = #colorLiteral(red: 0.2459094524, green: 0.3761512339, blue: 0.6553276181, alpha: 1)
//        titlee.textAlignment = .center
        
//        let socialStack = UIStackView(arrangedSubviews: [faceButton, googleButton])
//        socialStack.axis = .horizontal
//        socialStack.distribution = .fillEqually
//        socialStack.spacing = 20
        //
        let locationStack = UIStackView(arrangedSubviews: [
            locationDistinctButton, locationCityButton, locationAreaButton
            ])
        locationStack.axis = .horizontal
        locationStack.distribution = .fillEqually
        locationStack.spacing = 10
        //
        let stack = UIStackView(arrangedSubviews:
            [title,
             stackSpliter(),
//             locationButton,
             locationStack,
//             costText,
             mainJobButton,
             secoundryJobButton,
             loginButton,
//             titlee,
            ])
        
        stack.axis = v
        stack.distribution = .fillProportionally
        stack.spacing = 13
        loginView.addSubview(stack)
        stack.centerXInSuperview()
        stack.topAnchorSuperView(constant: 10)
        stack.widthAnchorWithMultiplier(multiplier: 0.9)
        stack.heightAnchorConstant(constant: 340)

//        loginView.addSubview(socialStack)
//        socialStack.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 20).isActive = true
//        socialStack.widthAnchorConstant(constant: 100)
//        socialStack.heightAnchorConstant(constant: 40)
//        socialStack.centerXInSuperview()
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = loginButton.bounds
        gradientLayerr.frame = bounds
        gradientLayer.cornerRadius = 20
    }
}

class CreateAccountButton: UIButton {
    
    override var buttonType: UIButton.ButtonType {
        return .system
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 10, height: 40)
    }
    
    init(title: String, image: UIImage) {
        super.init(frame: .zero)
        setTitleNormalState(title)
        titleLabel?.font = .CairoRegular(of: 13)
        viewCornerRadius = 20
        setTitleColorNormalState(#colorLiteral(red: 0.4512332082, green: 0.4585689902, blue: 0.484716177, alpha: 1))
//        addLeadingImageView(image: image, width: 15, hight: 15)
        contentHorizontalAlignment = .center
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        viewBorderColor = #colorLiteral(red: 0.8665749431, green: 0.8667209744, blue: 0.8665543795, alpha: 1)
        viewBorderWidth = 0.5
        titleLabel?.adjustsFontSizeToFitWidth = ya
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class CreateAccountText: UITextField {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 10, height: 40)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 15, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 15, dy: 0)
    }
    
    init(title: String, image: UIImage?) {
        super.init(frame: .zero)
        placeholder = title
        font = .CairoRegular(of: 15)
        viewCornerRadius = 20
        textColor = #colorLiteral(red: 0.4512332082, green: 0.4585689902, blue: 0.484716177, alpha: 1)
        if image != nil {
            withImage(direction: .Left, image: image!, colorSeparator: .clear, colorBorder: .clear)
        }
        textAlignment = .right
        viewBorderColor = #colorLiteral(red: 0.8665749431, green: 0.8667209744, blue: 0.8665543795, alpha: 1)
        viewBorderWidth = 0.5
        clipsToBounds = ya
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
