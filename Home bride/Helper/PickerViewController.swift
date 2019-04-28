//
//  CountriesTableViewController.swift
//  Gawla
//
//  Created by Youssef on 12/11/18.
//  Copyright © 2018 ITGeeKs. All rights reserved.
//

import UIKit

protocol SendResult: NSObjectProtocol {
    func result(name: String)
}

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rowsData?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rowsData?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let data = rowsData, data.count > 0 else { return }
        selectedItem = data[row]
        delegate?.result(name: selectedItem ?? "")
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    weak var delegate: SendResult?
    var selectedItem: String?
    var rowsData: [String]?
    var currentValue = ""
    
    let pickerView: UIPickerView = {
        let picker = UIPickerView()
//        picker.backgroundColor = .gray
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = .white
        picker.viewBorderWidth = 0.5
        picker.viewBorderColor = .paleGreyTwo
        return picker
    }()
    
    lazy var gradientLayer: LinearGradientLayer = {
        let gradientLayer = LinearGradientLayer(colors: [.azure, .cornflowerBlue])
        gradientLayer.cornerRadius = 6
        return gradientLayer
    }()

    init(itemsToShow: [String]) {
        super.init(nibName: nil, bundle: nil)
        rowsData = itemsToShow
        if itemsToShow.count > 0 {
            selectedItem = itemsToShow[0]
        }
        pickerView.reloadAllComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        let dismissGeasture = UITapGestureRecognizer(target: self, action: #selector(dismissMePlease))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(dismissGeasture)
    
        pickerView.backgroundColor = .white
//        pickerView.alignmentRectInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.addSubview(pickerView)
        view.ActivateConstraint([
            pickerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: 140),
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
            ])
        delegate?.result(name: rowsData?.first ?? "")
    }

//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
////        gradientLayer.frame = selectedButton.bounds
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        delegate?.result(name: rowsData?[pickerView.selectedRow(inComponent: 0)] ?? "")
    }
}
