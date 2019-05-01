//
//  CountriesTableViewController.swift
//  Gawla
//
//  Created by Youssef on 12/11/18.
//  Copyright © 2018 ITGeeKs. All rights reserved.
//

import UIKit

class AddSevrvViewController: UIViewController {
    
    weak var delegate: SendResult?
    var selectedDate = ""
    
    
    lazy var confirmButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("reservation confirmation", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .CairoSemiBold(of: 15)
        btn.layer.cornerRadius = 15
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.9285544753, green: 0.3886299729, blue: 0.6461874247, alpha: 1)
        btn.addTheTarget(action: {[weak self] in
            self?.pickerViewValue()
            self?.delegate?.result(name: self?.getDateToStringDate(date: self?.pickerView.date ?? Date()) ?? "")
            self?.dismissMePlease()
        })
        return btn
    }()
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }; required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        let dismissGeasture = UITapGestureRecognizer(target: self, action: #selector(dismissMePlease))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(dismissGeasture)
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.viewBorderWidth = 0.5
        containerView.viewBorderColor = #colorLiteral(red: 0.89402318, green: 0.8941735625, blue: 0.89400208, alpha: 1)
        containerView.viewCornerRadius = 10
        containerView.backgroundColor = .white
        containerView.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.19), alpha: 1, x: 0, y: 3, blur: 2, spread: 0)
        view.addSubview(containerView)
        containerView.centerYInSuperview()
        containerView.centerXInSuperview()
        containerView.widthAnchorConstant(constant: 350)
        containerView.heightAnchorConstant(constant: 320)
        // **********************************************************
        containerView.addSubview(confirmButton)
        view.ActivateConstraint([
            confirmButton.widthAnchorWithMultiplier(multiplier: 0.9),
            confirmButton.heightAnchor.constraint(equalToConstant: 40),
            confirmButton.centerXInSuperview(),
            confirmButton.bottomAnchorSuperView(constant: -10)
            ])
        // **********************************************************
        let titleLable = UILabel()
        titleLable.font = .CairoBold(of: 15)
        containerView.addSubview(titleLable)
        titleLable.centerXInSuperview()
        titleLable.topAnchorSuperView(constant: 10)
        titleLable.heightAnchorConstant(constant: 25)
        // **********************************************************
        containerView.addSubview(pickerView)
        view.ActivateConstraint([
            pickerView.widthAnchorWithMultiplier(multiplier: 0.95),
            pickerView.centerXInSuperview(),
            pickerView.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 10),
            pickerView.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -10)
            ])
    }

    private func pickerViewValue() {
        let date = pickerView.date
        let selectedDate = getDateToStringDate(date: date)
        
        
        print(selectedDate)
        print(getDateToStringTime(date: date))
//        print(date.description)
    }
    
    func getDateToStringDate(date: Date) -> String {
        if mode == .time {
            let formatter = DateFormatter()
            let time = pickerView.date
            formatter.dateFormat = "h:m"
            let myStringafd = formatter.string(from: time)
            return myStringafd
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let myStringafd = formatter.string(from: date)
        return myStringafd
    }
    
    func getDateToStringTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSS"
        let myStringafd = formatter.string(from: date)
        return myStringafd
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(selectedDate)
    }
}
