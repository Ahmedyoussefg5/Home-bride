//
//  Basement.swift
//  Awfr Client
//
//  Created by Youssef on 4/14/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

enum BaseButtons: Int {
    case `default`
    case userPictureButton
}

protocol ButtonActionDelegation: class {
    func clicked(with: BaseButtons)
}

class BaseView: UIView {
    let view = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupView()
    }; required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    weak var click: ButtonActionDelegation?
    
//    lazy var gradient = LinearGradientLayer(colors: [.darkSlateBlue, .marineBlue, .twilightBlue, .niceBlue])
    
    func setupView() {
//        addSubview(view)
//        view.backgroundColor = .clear
//        view.isUserInteractionEnabled = false
//        view.layer.insertSublayer(gradient, at: 0)
    }
    
    func setupAppearance() {
        backgroundColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        gradient.direction = .bottomRightToTopLeft
//        gradient.frame = view.bounds
    }
}

class BaseUIViewController<T: BaseView>: UIViewController, ButtonActionDelegation {
    func clicked(with: BaseButtons) {
    }
    let activ = UIActivityIndicatorView(style: .whiteLarge)

    var mainView = T()
    override func loadView() {
        view = mainView
        mainView.addSubview(activ)
        activ.fillSuperviewSafeArea()

        mainView.click = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        activ.color = mediumPurple

//        var updatedFrame = (navigationController?.navigationBar.bounds)!
//        updatedFrame.size.height += 20
//        mainView.view.frame = updatedFrame
    }
}

class BaseCell<U: Codable>: UITableViewCell {
    
//    var dataSource: U? {
//        didSet {
//            configCell()
//        }
//    }
    
    func setupCell<T>(item: T) {
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }; required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setupCell() {
    }
    
    func configCell(_ data: U) {
    }
}

protocol BaseCodable: Codable {
    var status: Int { get set }
//    var errors: [String]? { get set }
    var msg: String? { get set }
}

struct BaseStruct: BaseCodable {
    var msg: String?    
    var status: Int
}
