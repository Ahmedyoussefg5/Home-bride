//
//  LoginViewController.swift
//  Awfr Client
//
//  Created by Youssef on 4/14/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit
import SpinWheelControl

class UserHomeView: BaseView {
    private lazy var logo: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.image = #imageLiteral(resourceName: "logoWhite")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let spinWheelControl = SpinWheelControl(frame: .zero, snapOrientation: SpinWheelDirection.left)

//    lazy var button1: ButtonWithImageAndLable = {
//        let btn = ButtonWithImageAndLable(type: .system)
//        btn.tag = 0
////        let title = "خبيرة تجميل"
////        let lable = UILabel()
////        lable.text = title
////        btn.addSubview(lable)
////        lable.centerXInSuperview()
////        lable.topAnchor.constraint(equalTo: btn.bottomAnchor, constant: 5).isActive = ya
////        lable.textColor = .white
////        lable.font = UIFont.CairoSemiBold(of: 13)
////        btn.backgroundColor = .clear
////        btn.setImage(#imageLiteral(resourceName: "owner").withRenderingMode(.alwaysOriginal), for: .normal)
////        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        return btn
//    }()
//    lazy var button2: ButtonWithImageAndLable = {
//        let btn = ButtonWithImageAndLable(type: .system)
//        btn.tag = 1
//        return btn
//    }()
//    lazy var button3: ButtonWithImageAndLable = {
//        let btn = ButtonWithImageAndLable(type: .system)
//        btn.tag = 2
//        return btn
//    }()
//    lazy var button4: ButtonWithImageAndLable = {
//        let btn = ButtonWithImageAndLable(type: .system)
//        btn.tag = 3
//        return btn
//    }()
    lazy var seeAllButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("عرض الكل", for: .normal)
        btn.contentHorizontalAlignment = .center
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .CairoSemiBold(of: 15)
        btn.addTheTarget(action: {[weak self] in
        })
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
    lazy var arrowImage: BigImage = {
        let img = BigImage()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.image = #imageLiteral(resourceName: "baseline_play_arrow_black_48pt_1x").withRenderingMode(.alwaysTemplate)
        img.tintColor = mediumPurple
        img.viewCornerRadius = 50
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    override func setupView() {

        addSubview(profileContainerView)
        profileContainerView.centerXInSuperview()
        profileContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = ya
        profileContainerView.widthAnchorWithMultiplier(multiplier: 1)
        profileContainerView.heightAnchorConstant(constant: 170)
        
        profileContainerView.addSubview(logo)
        logo.centerXInSuperview()
        logo.topAnchorSuperView(constant: 15)



        addSubview(spinWheelControl)
        spinWheelControl.widthAnchorWithMultiplier(multiplier: 0.8)
        spinWheelControl.heightAnchorEqualWidthAnchor()
        spinWheelControl.topAnchorToView(anchor: profileContainerView.bottomAnchor, constant: 10)




//        addSubview(logo)
//        ActivateConstraint([
//            logo.centerXInSuperview(),
//            logo.topAnchorSuperView(constant: 30),
//            logo.widthAnchorWithMultiplier(multiplier: 0.55),
//            logo.heightAnchorWithMultiplier(multiplier: 0.2)
//            ])
        
//        let view = UIView()
//        view.viewBorderWidth = 2
//        view.viewBorderColor = .white
//        view.viewCornerRadius = 5
//        view.addSubview(button1)
//        button1.fillSuperview(padding: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))
//
//        let view2 = UIView()
//        view2.viewBorderWidth = 2
//        view2.viewBorderColor = .white
//        view2.viewCornerRadius = 5
//        view2.addSubview(button2)
//        button2.fillSuperview(padding: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))
//
//        let view3 = UIView()
//        view3.viewBorderWidth = 2
//        view3.viewBorderColor = .white
//        view3.viewCornerRadius = 5
//        view3.addSubview(button3)
//        button3.fillSuperview(padding: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))
//
//        let view4 = UIView()
//        view4.viewBorderWidth = 2
//        view4.viewBorderColor = .white
//        view4.viewCornerRadius = 5
//        view4.addSubview(button4)
//        button4.fillSuperview(padding: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))
//
//        let stack1 = UIStackView(arrangedSubviews: [view, view2])
//        stack1.axis = .horizontal
//        stack1.distribution = .fillEqually
//        stack1.spacing = 30
//
//        let stack2 = UIStackView(arrangedSubviews: [view3, view4])
//        stack2.axis = .horizontal
//        stack2.distribution = .fillEqually
//        stack2.spacing = 30
//
//
//        let stack = UIStackView(arrangedSubviews: [stack1, stack2])
//        stack.axis = v
//        stack.distribution = .fillEqually
//        stack.spacing = 30
//
//        addSubview(stack)
//        stack.centerXInSuperview()
//        stack.widthAnchorConstant(constant: 230)
//        stack.heightAnchorConstant(constant: 210)
//        stack.topAnchorToView(anchor: profileContainerView.bottomAnchor, constant: 10)
//
        let img = UIImageView(image: #imageLiteral(resourceName: "home_corner"))
        addSubview(img)
        img.setupAsFullImage(image: #imageLiteral(resourceName: "home_corner"))
        img.widthAnchorWithMultiplier(multiplier: 0.4)
        img.heightAnchorWithMultiplier(multiplier: 0.2)
        img.trailingAnchorAnchorSuperView()
        img.bottomAnchorSuperView()
        
        addSubview(seeAllButton)
        seeAllButton.trailingAnchorAnchorSuperView()
        seeAllButton.bottomAnchorSuperView(constant: -5)
    }
    
    func addArrow() {
        addSubview(arrowImage)
        arrowImage.centerYAnchor.constraint(equalTo: spinWheelControl.centerYAnchor).isActive = ya
        arrowImage.trailingAnchor.constraint(equalTo: spinWheelControl.leadingAnchor, constant: 20).isActive = ya
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = profileContainerView.bounds
        spinWheelControl.trailingAnchorAnchorSuperView(constant: (spinWheelControl.frame.width * 0.5))
    }
}

class UserHomeViewController: BaseUIViewController<UserHomeView>, SpinWheelControlDataSource, SpinWheelControlDelegate {
    func numberOfWedgesInSpinWheel(spinWheel: SpinWheelControl) -> UInt {
        return UInt(allCategories.count)
    }
    
    func wedgeForSliceAtIndex(index: UInt) -> SpinWheelWedge {
        let wedge = SpinWheelWedge()
        
        wedge.shape.fillColor = lightPurple.cgColor
        wedge.label.text = allCategories[Int(index)].name
        
        return wedge
    }
    
    let act = UIActivityIndicatorView(style: .whiteLarge)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarApperance(title: "", addImageTitle: no, showNotifButton: no)
        title = "الرئيسية"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), landscapeImagePhone: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(handleSideMenu))
        setupSideMenu()
        getAllcategories()
        act.color = mediumPurple
        view.addSubview(act)
        act.fillSuperview()
        
        mainView.arrowImage.addTapGestureRecognizer {[weak self] in
            let vc = SubCatViewController(id: self?.allCategories[self?.mainView.spinWheelControl.selectedIndex ?? 0].id ?? 0, name: self?.allCategories[self?.mainView.spinWheelControl.selectedIndex ?? 0].name ?? "")
            self?.navigationController?.pushViewController(UserTabBarController(vc: vc), animated: ya)
        }
        
        //
        
        
//        mainView.spinWheelControl =
        
        mainView.spinWheelControl.addTarget(self, action: #selector(spinWheelDidChangeValue), for: UIControl.Event.valueChanged)
        mainView.spinWheelControl.dataSource = self
//        smainView.pinWheelControl.reloadData()
        mainView.spinWheelControl.delegate = self

        
//        [mainView.button1, mainView.button2, mainView.button3, mainView.button4].forEach { (btn) in
//            btn.addTheTarget(action: {
//                self.handelButtons(btn)
//            })
//        }
        
        mainView.seeAllButton.addTheTarget {[weak self] in
            self?.navigationController?.pushViewController(UserTabBarController(vc: AllCatViewController()), animated: ya)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "الرئيسية"
    }
    
    //Target was added in viewDidLoad for the valueChanged UIControlEvent
    @objc func spinWheelDidChangeValue(sender: AnyObject) {
        print("Value changed to " + allCategories[mainView.spinWheelControl.selectedIndex].name)
    }
//    private func handelButtons(_ btn: ButtonWithImageAndLable) {
//        if let id = allCategories[o: btn.tag]?.id {
//            navigationController?.pushViewController(SubCatViewController(id: id), animated: ya)
//        }
//
//    }
    
    private var allCategories = [Categories]() {
        didSet {
            mainView.spinWheelControl.reloadData()
            UIView.animate(withDuration: 0.5) {
                self.mainView.addArrow()
            }
////            let imgV = UIImageView()
//
//            mainView.button1.lable.text = allCategories.first?.name
//            mainView.button1.load(with: allCategories.first?.image)
//            if allCategories.count > 2 {
//                mainView.button2.lable.text = allCategories[1].name
//                mainView.button2.load(with: allCategories[1].image)
//                mainView.button3.lable.text = allCategories[2].name
//                mainView.button3.load(with: allCategories[3].image)
//            }
//            mainView.button4.lable.text = allCategories.last?.name
//            mainView.button4.load(with: allCategories.last?.image)
        }
    }

    private func getAllcategories() {
        let url = "http://m4a8el.panorama-q.com/api/categories"
        
        callApi(AllCategories.self, url: url, method: .get, parameters: nil, shouldShowAlert: ya, activityIndicator: act) {[weak self] (data) in
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
        addSubview(lable)
        lable.centerXInSuperview()
        lable.topAnchor.constraint(equalTo: bottomAnchor, constant: 5).isActive = ya
        lable.textColor = .darkGray
        lable.font = .CairoSemiBold(of: 13)
        backgroundColor = .clear
        imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
