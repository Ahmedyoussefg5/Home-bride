//
//  LoginViewController.swift
//  Awfr Client
//
//  Created by Youssef on 4/14/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class ProviderProfileView: BaseView {
    private lazy var logo: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.image = #imageLiteral(resourceName: "girl")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    lazy var button1: ButtonWithImageAndLablee = {
        let btn = ButtonWithImageAndLablee(type: .system)
        btn.setImage(#imageLiteral(resourceName: "video-camera").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.lable.text = "البوم الشغل"
        btn.tag = 0
        return btn
    }()
    lazy var button2: ButtonWithImageAndLablee = {
        let btn = ButtonWithImageAndLablee(type: .system)
        btn.setImage(#imageLiteral(resourceName: "video-camera").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.lable.text = "الخدمات"
        btn.tag = 1
        return btn
    }()
    lazy var button3: ButtonWithImageAndLablee = {
        let btn = ButtonWithImageAndLablee(type: .system)
        btn.setImage(#imageLiteral(resourceName: "video-camera").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.lable.text = "مواعيد العمل"
        btn.tag = 2
        return btn
    }()
    lazy var button4: ButtonWithImageAndLablee = {
        let btn = ButtonWithImageAndLablee(type: .system)
        btn.setImage(#imageLiteral(resourceName: "video-camera").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.lable.text = "صفحتي"
        btn.tag = 3
        return btn
    }()

//    lazy var gradientLayer = LinearGradientLayer(colors: [mediumPurple, lightPurple])
    private lazy var profileContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
//        view.layer.insertSublayer(gradientLayer, at: 0)
        return view
    }()
    override func setupView() {

        addSubview(logo)
        logo.centerXInSuperview()
        logo.topAnchorSuperView(constant: 15)
        logo.widthAnchorWithMultiplier(multiplier: 0.3)
        logo.heightAnchorEqualWidthAnchor()
        
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
        button3.fillSuperview(padding: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))
        
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
        stack.topAnchorToView(anchor: logo.bottomAnchor, constant: 10)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
//        gradientLayer.frame = profileContainerView.bounds
    }
}

class ProviderProfileViewController: BaseUIViewController<ProviderProfileView> {
    let act = UIActivityIndicatorView(style: .whiteLarge)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarApperance(title: "\(data.firstName) \(data.lastName)", addImageTitle: no, showNotifButton: no)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), landscapeImagePhone: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(handleSideMenu))
        setupSideMenu()
//        getAllcategories()
        act.color = mediumPurple
        view.addSubview(act)
        act.fillSuperview()

        mainView.button1.addTheTarget {[weak self] in
            self?.presentModelyVC(vc: ProvGalaryViewController(id: self?.data.id ?? 0))
        }
        
        mainView.button2.addTheTarget {[weak self] in
            self?.navigationController?.pushViewController(ProvServsViewController(id: self?.data.id ?? 0), animated: true)
        }
        
        mainView.button3.addTheTarget {[weak self] in
            self?.presentModelyVC(vc: ProvTimeTableViewController(id: self?.data.id ?? 0))
        }
        
        mainView.button4.addTheTarget {[weak self] in
            self?.presentModelyVC(vc: ProvProfileViewController(id: self?.data.id ?? 0, name: self?.data.firstName, address: self?.data.info))
        }
    }
    
    var data: Providerr
    
    init(prov: Providerr) {
        data = prov
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func getAllcategories() {
//        let url = "http://m4a8el.panorama-q.com/api/categories"
//
//        callApi(AllCategories.self, url: url, method: .get, parameters: nil, shouldShowAlert: ya, activityIndicator: act) {[weak self] (data) in
//            if let data = data {
////                self?.allCategories = data.data
//            }
//        }
//    }
    
}
class ButtonWithImageAndLablee: UIButton {
    let lable = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lable)
        lable.centerXInSuperview()
        lable.topAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = ya
        lable.widthAnchorWithMultiplier(multiplier: 1)
        lable.textColor = .darkGray
        lable.textAlignment = .center
        lable.font = .CairoSemiBold(of: 13)
        backgroundColor = .clear
        imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        backgroundColor = .lightGray
        lable.backgroundColor = .lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
