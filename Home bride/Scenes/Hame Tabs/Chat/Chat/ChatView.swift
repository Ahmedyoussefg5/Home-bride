//
//  CardPageVC.swift
//  Gawla
//
//  Created by Youssef on 11/11/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import UIKit

class ChatView: UIView {
    lazy var mainTableView: UITableView = {
        let tableV = UITableView()
        tableV.isTransperant()
        tableV.allowsSelection = false
        tableV.separatorColor = .clear
        tableV.backgroundColor = .white
        tableV.register(ChatCell.self, forCellReuseIdentifier: "cardsBagTableCell")
        return tableV
    }()
    lazy var sendButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "send-button"), for: .normal)
        btn.tintColor = lightPurple
        btn.imageView?.tintColor = lightPurple
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let chatTxt: UITextField = {
        let txt = UITextField()
        txt.textAlignment = .natural
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "اكتب رسالتك ...".localize
        txt.backgroundColor = .white
        txt.textColor = .darkGray
        txt.font = .CairoSemiBold(of: 15)
        txt.layer.borderColor = UIColor.paleGreyTwo.cgColor
        txt.layer.borderWidth = 1
        txt.setLeftPaddingPoints(5)
        txt.setRightPaddingPoints(5)
        txt.layer.cornerRadius = 6.0
        txt.returnKeyType = .send
        return txt
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 9
        setupView()
    }; required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder) }
    
    lazy var chatControllersView: UIView = {
        let view = UIView()
        view.semanticContentAttribute = .forceLeftToRight
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private var heightConstraint: NSLayoutConstraint!
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(mainTableView)
        ActivateConstraint([
            mainTableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            mainTableView.widthAnchor.constraint(equalTo: widthAnchor)
            ])
        
        addSubview(chatControllersView)
        ActivateConstraint([
            chatControllersView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            chatControllersView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            chatControllersView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            chatControllersView.heightAnchorConstant(constant: 45)
            ])
        
        mainTableView.bottomAnchor.constraint(equalTo: chatControllersView.topAnchor, constant: 0).isActive = ya

        chatControllersView.addSubview(chatTxt)
        chatControllersView.addSubview(sendButton)

        ActivateConstraint([
            sendButton.trailingAnchor.constraint(equalTo: chatControllersView.trailingAnchor, constant: -2),
            sendButton.heightAnchor.constraint(equalToConstant: 45),
            sendButton.widthAnchor.constraint(equalToConstant: 45),
            sendButton.centerYInSuperview()
            ])
        ActivateConstraint([
            chatTxt.leadingAnchor.constraint(equalTo: chatControllersView.leadingAnchor, constant: 2),
            chatTxt.heightAnchor.constraint(equalToConstant: 45),
            chatTxt.centerYInSuperview(),
            chatTxt.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor),
            ])

    }
    
//    //MARK: - TextField Delegate Methods
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        UIView.animate(withDuration: 0.5) {
////            self.heightConstraint.constant = 308
//            self.layoutIfNeeded()
//        }
//    }
//
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        UIView.animate(withDuration: 0.5) {
////            self.heightConstraint.constant = 50
//            self.layoutIfNeeded()
//        }
//    }
}

class ChatCell: UITableViewCell {
    let nameLable: UILabel = {
        let lbl = UILabel()
        lbl.font = .CairoSemiBold(of: 12)
        lbl.textColor = .black
        lbl.textAlignment = .center
        //lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let dateLable: UILabel = {
        let lbl = UILabel()
        lbl.font = .CairoSemiBold(of: 9)
//        lbl.text = "22-22-2323"
        lbl.textAlignment = .natural
        lbl.textColor = .white
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let chatContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = mediumPurple
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let chatContentLable: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.CairoSemiBold(of: 11)
        lbl.textAlignment = .natural
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    let triangleView = TriangleView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        contentView.addSubview(nameLable)
        ActivateConstraint([
            nameLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            nameLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            nameLable.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            //  nameLable.heightAnchor.constraint(equalToConstant: 20)
            ])
        
        contentView.addSubview(triangleView)
        ActivateConstraint([
            triangleView.leadingAnchor.constraint(equalTo: nameLable.trailingAnchor, constant: 1),
            triangleView.centerYAnchor.constraint(equalTo: nameLable.centerYAnchor),
            triangleView.heightAnchor.constraint(equalToConstant: 12),
            triangleView.widthAnchor.constraint(equalToConstant: 10)
            ])
        
        contentView.addSubview(chatContainerView)
        ActivateConstraint([
            chatContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            chatContainerView.leadingAnchor.constraint(equalTo: triangleView.trailingAnchor, constant: 0),
            chatContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            chatContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
            ])
        
        chatContainerView.addSubview(chatContentLable)
        chatContainerView.addSubview(dateLable)
        
        ActivateConstraint([
            chatContentLable.topAnchor.constraint(equalTo: chatContainerView.topAnchor, constant: 3),
            chatContentLable.leadingAnchor.constraint(equalTo: chatContainerView.leadingAnchor, constant: 5),
            chatContentLable.trailingAnchor.constraint(equalTo: chatContainerView.trailingAnchor, constant: -0),
            chatContentLable.bottomAnchor.constraint(equalTo: dateLable.topAnchor, constant: -0)
            ])
        ActivateConstraint([
            //dateLable.topAnchor.constraint(equalTo: chatContentLable.bottomAnchor, constant: 3),
            //dateLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            dateLable.trailingAnchor.constraint(equalTo: chatContainerView.trailingAnchor, constant: -4),
            dateLable.bottomAnchor.constraint(equalTo: chatContainerView.bottomAnchor, constant: -1)
            ])
    }
    
    func configCell(message: Message) {
        nameLable.text = message.userFrom
        chatContentLable.text = message.message
        dateLable.text = message.createdAt
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

class TriangleView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }; required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder) }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.beginPath()
        if !AppMainLang.isRTLLanguage() {
            context.move(to: CGPoint(x: (rect.minX), y: rect.minY))
            context.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            context.addLine(to: CGPoint(x: (rect.minX), y: rect.maxY))
            context.closePath()
            context.setFillColor(mediumPurple.cgColor)
            context.fillPath()
        } else {
            context.move(to: CGPoint(x: (rect.minX), y: rect.midY))
            context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            context.addLine(to: CGPoint(x: (rect.maxX), y: rect.maxY))
            context.closePath()
            context.setFillColor(mediumPurple.cgColor)
            context.fillPath()
        }
    }
}
