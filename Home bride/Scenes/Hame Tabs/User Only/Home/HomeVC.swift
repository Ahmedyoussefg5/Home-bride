//
//  LoginViewController.swift
//  Awfr Client
//
//  Created by Youssef on 4/14/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class UserHomeView: BaseView {
    private lazy var logo: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.image = #imageLiteral(resourceName: "logoWhite")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    lazy var button1: ButtonWithImageAndLable = {
        let btn = ButtonWithImageAndLable(type: .system)
//        let title = "خبيرة تجميل"
//        let lable = UILabel()
//        lable.text = title
//        btn.addSubview(lable)
//        lable.centerXInSuperview()
//        lable.topAnchor.constraint(equalTo: btn.bottomAnchor, constant: 5).isActive = ya
//        lable.textColor = .white
//        lable.font = UIFont.CairoSemiBold(of: 13)
//        btn.backgroundColor = .clear
//        btn.setImage(#imageLiteral(resourceName: "owner").withRenderingMode(.alwaysOriginal), for: .normal)
//        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return btn
    }()
    lazy var button2: ButtonWithImageAndLable = {
        let btn = ButtonWithImageAndLable(type: .system)
        return btn
    }()
    lazy var button3: ButtonWithImageAndLable = {
        let btn = ButtonWithImageAndLable(type: .system)
        return btn
    }()
    lazy var button4: ButtonWithImageAndLable = {
        let btn = ButtonWithImageAndLable(type: .system)
        return btn
    }()

    lazy var gradientLayer = LinearGradientLayer(colors: [mediumPurple, lightPurple])
    private lazy var profileContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.insertSublayer(gradientLayer, at: 0)
        return view
    }()
//    private lazy var userImage: BigImage = {
//        let img = BigImage()
//        img.clipsToBounds = true
//        img.contentMode = .scaleToFill
//        img.image = #imageLiteral(resourceName: "girl")
//        img.viewCornerRadius = 50
//        img.translatesAutoresizingMaskIntoConstraints = false
//        return img
//    }()
    override func setupView() {

        addSubview(profileContainerView)
        profileContainerView.centerXInSuperview()
        profileContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = ya
        profileContainerView.widthAnchorWithMultiplier(multiplier: 1)
        profileContainerView.heightAnchorConstant(constant: 230)
        
        profileContainerView.addSubview(logo)
        logo.centerXInSuperview()
        logo.topAnchorSuperView(constant: 15)









//        addSubview(logo)
//        ActivateConstraint([
//            logo.centerXInSuperview(),
//            logo.topAnchorSuperView(constant: 30),
//            logo.widthAnchorWithMultiplier(multiplier: 0.55),
//            logo.heightAnchorWithMultiplier(multiplier: 0.2)
//            ])
        
        let view = UIView()
        view.viewBorderWidth = 2
        view.viewBorderColor = .white
        view.viewCornerRadius = 5
        view.addSubview(button1)
        button1.fillSuperview(padding: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))
        
        let view2 = UIView()
        view2.viewBorderWidth = 2
        view2.viewBorderColor = .white
        view2.viewCornerRadius = 5
        view2.addSubview(button2)
        button2.fillSuperview(padding: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))
        
        let view3 = UIView()
        view3.viewBorderWidth = 2
        view3.viewBorderColor = .white
        view3.viewCornerRadius = 5
        view3.addSubview(button3)
        button2.fillSuperview(padding: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))
        
        let view4 = UIView()
        view4.viewBorderWidth = 2
        view4.viewBorderColor = .white
        view4.viewCornerRadius = 5
        view4.addSubview(button4)
        button4.fillSuperview(padding: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))

        let stack1 = UIStackView(arrangedSubviews: [view, view2])
        stack1.axis = .horizontal
        stack1.distribution = .fillEqually
        stack1.spacing = 10
        
        let stack2 = UIStackView(arrangedSubviews: [view3, view4])
        stack2.axis = .horizontal
        stack2.distribution = .fillEqually
        stack2.spacing = 10
        
        
        let stack = UIStackView(arrangedSubviews: [stack1, stack2])
        stack.axis = v
        stack.distribution = .fillEqually
        stack.spacing = 10

        addSubview(stack)
        stack.centerXInSuperview()
        stack.widthAnchorConstant(constant: 230)
        stack.heightAnchorConstant(constant: 210)
        stack.topAnchorToView(anchor: profileContainerView.bottomAnchor, constant: 30)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = profileContainerView.bounds
    }
}

class UserHomeViewController: BaseUIViewController<UserHomeView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trasperantNavBar()
//        mainView.provButton.addTheTarget(action: {[weak self] in
//            user = p
//            self?.navigationController?.pushViewController(LoginViewController(), animated: true)
//        })
//        mainView.clientButton.addTheTarget(action: {[weak self] in
//            user = u
//            self?.navigationController?.pushViewController(LoginViewController(), animated: true)
//        })
//
//        mainView.forgetButton.addTheTarget(action: {[weak self] in
//            self?.navigationController?.pushViewController(ForgetPasswordController(), animated: true)
//        })
        
    }
    
    private var allCategories = [Categories]()

    private func getAllcategories() {
        let url = "http://m4a8el.panorama-q.com/api/categories"
        
        callApi(AllCategories.self, url: url, method: .get, parameters: nil, shouldShowAlert: ya, activityIndicator: nil) {[weak self] (data) in
            if let data = data {
                self?.allCategories = data.data
            }
        }
    }
    
}

class ButtonWithImageAndLable: UIButton {
    let lable = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        let title = "مستخدم عادي"
        //        lable.text = title
        addSubview(lable)
        lable.centerXInSuperview()
        lable.topAnchor.constraint(equalTo: bottomAnchor, constant: 5).isActive = ya
        lable.textColor = .white
        lable.font = .CairoSemiBold(of: 13)
        backgroundColor = .clear
        //        setImage(#imageLiteral(resourceName: "whiteOwner").withRenderingMode(.alwaysOriginal), for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
