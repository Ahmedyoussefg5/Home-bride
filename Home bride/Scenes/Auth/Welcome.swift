//
//  LoginViewController.swift
//  Awfr Client
//
//  Created by Youssef on 4/14/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class WelcomeView: BaseView {
    private lazy var logo: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.image = #imageLiteral(resourceName: "logoWhite")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    lazy var provButton: UIButton = {
        let btn = UIButton(type: .system)
        let title = "خبيرة تجميل"
        let lable = UILabel()
        lable.text = title
        btn.addSubview(lable)
        lable.centerXInSuperview()
        lable.topAnchor.constraint(equalTo: btn.bottomAnchor, constant: 5).isActive = ya
        lable.textColor = .white
        lable.font = UIFont.CairoSemiBold(of: 13)
        btn.backgroundColor = .clear
        btn.setImage(#imageLiteral(resourceName: "owner").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return btn
    }()
    lazy var clientButton: UIButton = {
        let btn = UIButton(type: .system)
        let title = "مستخدم عادي"
        let lable = UILabel()
        lable.text = title
        btn.addSubview(lable)
        lable.centerXInSuperview()
        lable.topAnchor.constraint(equalTo: btn.bottomAnchor, constant: 5).isActive = ya
        lable.textColor = .white
        lable.font = UIFont.CairoSemiBold(of: 13)
        btn.backgroundColor = .clear
        btn.setImage(#imageLiteral(resourceName: "whiteOwner").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
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
        
        let view = UIView()
        view.viewBorderWidth = 2
        view.viewBorderColor = .white
        view.viewCornerRadius = 5
        view.addSubview(provButton)
        provButton.fillSuperview(padding: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))
        let view2 = UIView()
        view2.viewBorderWidth = 2
        view2.viewBorderColor = .white
        view2.viewCornerRadius = 5
        view2.addSubview(clientButton)
        clientButton.fillSuperview(padding: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))
        let stack = UIStackView(arrangedSubviews: [view, view2])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        addSubview(stack)
        stack.centerXInSuperview()
        stack.widthAnchorConstant(constant: 230)
        stack.heightAnchorConstant(constant: 100)
        stack.topAnchorToView(anchor: logo.bottomAnchor, constant: 20)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}

class WelcomeViewController: BaseUIViewController<WelcomeView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trasperantNavBar()
        mainView.provButton.addTheTarget(action: {[weak self] in
            user = p
            self?.navigationController?.pushViewController(LoginViewController(), animated: true)
        })
        mainView.clientButton.addTheTarget(action: {[weak self] in
            user = u
//            self?.login()
        })
//
//        mainView.forgetButton.addTheTarget(action: {[weak self] in
//            self?.navigationController?.pushViewController(ForgetPasswordController(), animated: true)
//        })
        
    }
    
    
}
