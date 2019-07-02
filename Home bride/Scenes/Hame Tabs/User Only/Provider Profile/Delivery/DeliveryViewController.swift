//
//  HomeNewReqViewController.swift
//  Home bride
//
//  Created by Youssef on 4/20/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

protocol DeliveryResulte: class {
    func send(Status: Bool, copon: String?)
    func location(name: String, lat: String, long: String, copon: String?)
}

class DeliveryView: BaseView {
    
    lazy var goButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("الذهاب الى مكان عمل الخبيرة", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .CairoSemiBold(of: 15)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = lightPurple
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTheTarget(action: {[weak self] in
        })
        return btn
    }()
    lazy var contactButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("طلب الخبيرة للمنزل", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .CairoSemiBold(of: 15)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = lightPurple
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTheTarget(action: {[weak self] in
        })
        return btn
    }()
    lazy var coponTxt: UITextField = {
        let txt = UITextField()
        txt.textAlignment = .right
        txt.placeholder = "ادخل الكوبون"
        txt.backgroundColor = .white
        txt.textColor = .darkGray
        txt.viewBorderColor = .lightGray
        txt.viewBorderWidth = 0.5
        txt.font = .CairoSemiBold(of: 15)
        txt.setLeftPaddingPoints(5)
        txt.setRightPaddingPoints(5)
        txt.layer.cornerRadius = 6.0
        return txt
    }()
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.viewBorderWidth = 0.5
        view.viewBorderColor = #colorLiteral(red: 0.89402318, green: 0.8941735625, blue: 0.89400208, alpha: 1)
        view.backgroundColor = .white
        view.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.19), alpha: 1, x: 0, y: 3, blur: 2, spread: 0)
        return view
    }()
    override func setupView() {
        super.setupView()
        
        backgroundColor = .clear
        isUserInteractionEnabled = true

        addSubview(containerView)
        containerView.centerXInSuperview()
        containerView.centerYInSuperview()
        containerView.widthAnchorWithMultiplier(multiplier: 0.9)
        containerView.heightAnchorConstant(constant: 220)
        
        let stack = UIStackView(arrangedSubviews: [goButton, contactButton, coponTxt])
        stack.axis = v
        stack.distribution = .fillEqually
        stack.spacing = 20
        containerView.addSubview(stack)
        stack.fillSuperview(padding: UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10))
    }
}

class DeliveryViewController: BaseUIViewController<DeliveryView>, SendMapResult {
    
    func location(name: String, lat: String, long: String) {
        self.lng = long
        self.lat = lat
        if self.mainView.coponTxt.text != nil && self.mainView.coponTxt.text != "" {
            self.copon = self.mainView.coponTxt.text
        }
        delegate?.location(name: name, lat: lat, long: long, copon: mainView.coponTxt.text)
        dismissMePlease()
    }
    
    weak var delegate: DeliveryResulte?
    var lat = ""
    var lng = ""
    var copon: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        let dismissGeasture = UITapGestureRecognizer(target: self, action: #selector(dismissMePlease))
        mainView.addGestureRecognizer(dismissGeasture)
        
        mainView.contactButton.addTheTarget {[weak self] in
            let map = MapViewController()
            map.delegate = self
            let vc = UINavigationController(rootViewController: map)
            vc.navbarWithdismiss()
            self?.presentModelyVC(vc: vc)
        }
        
        mainView.goButton.addTheTarget {[weak self] in
            if self?.mainView.coponTxt.text != nil && self?.mainView.coponTxt.text != "" {
                self?.copon = self?.mainView.coponTxt.text
            }
            self?.delegate?.send(Status: no, copon: self?.copon)
            self?.dismissMePlease()
        }
    }
}
