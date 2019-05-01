//
//  CountriesTableViewController.swift
//  Gawla
//
//  Created by Youssef on 12/11/18.
//  Copyright © 2018 ITGeeKs. All rights reserved.
//

import UIKit
import Photos

class AddSevrvViewController: UIViewController {
    
    weak var delegate: SendResult?    
    
    lazy var confirmButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("حفظ", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .CairoSemiBold(of: 15)
        btn.layer.cornerRadius = 15
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.9285544753, green: 0.3886299729, blue: 0.6461874247, alpha: 1)
        btn.addTheTarget(action: {[weak self] in
            self?.addimage()
        })
        return btn
    }()
    let nameText = UnderLineTextField(placeH: "اسم الخدمة")
    let costText = UnderLineTextField(placeH: "التكلفة")
    lazy var photoButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("صورة الخدمة", for: .normal)
        btn.contentHorizontalAlignment = .trailing
        btn.setTitleColor(.gray, for: .normal)
        btn.addBottomLine()
//        btn.backgroundColor = #colorLiteral(red: 0.9371561408, green: 0.9373133779, blue: 0.9371339679, alpha: 1)
        btn.titleLabel?.font = .CairoSemiBold(of: 15)
        btn.translatesAutoresizingMaskIntoConstraints = false
        let view = UIView()
        view.backgroundColor = .lightGray
        btn.addSubview(view)
        view.topAnchor.constraint(equalTo: btn.bottomAnchor).isActive = ya
        view.centerXInSuperview()
        view.heightAnchorConstant(constant: 1)
        view.widthAnchorWithMultiplier(multiplier: 1)
        btn.addTheTarget(action: {[weak self] in
            self?.pickUserImage()
        })
        return btn
    }()
    
    weak var vc: ProfileViewController?
    
    init(vc: ProfileViewController) {
        self.vc = vc
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
        containerView.widthAnchorWithMultiplier(multiplier: 0.9)
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
        let stack = UIStackView(arrangedSubviews:
            [
             nameText,
             stackSpliter(),
             costText,
             stackSpliter(),
             photoButton,
             stackSpliter(),
             confirmButton
             ])
        
        stack.axis = v
        stack.distribution = .fillProportionally
        stack.spacing = 13
        containerView.addSubview(stack)
        view.ActivateConstraint([
           stack.widthAnchorWithMultiplier(multiplier: 0.95),
           stack.centerXInSuperview(),
           stack.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 10),
           stack.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -10)
            ])
    }
    
    private func addimage() {
        guard let img = pickerUserImage, let imgData = img.jpegData(compressionQuality: 0.5) else { return }

        guard let name = nameText.text, name.count > 2 , let price = costText.text, price.count > 0, let intPrice = Int(price) else { return }
        let url = "http://m4a8el.panorama-q.com/api/services"
        let pars = [
            "name": name,
            "price": intPrice
            ] as [String : Any]
        let imageData = UploadData(data: imgData, fileName: "image.jpeg", mimeType: "image/jpeg", name: "image")
        
        Network.shared.uploadToServerWith(AddServiceData.self, data: imageData, url: url, method: .post, parameters: pars, progress: nil) {[weak self] (err, data) in
            if let err = err {
                self?.showAlert(title: nil, message: err)
            } else if let data = data {
                if data.msg != nil {
                    self?.showAlert(title: nil, message: data.msg)
                } else {
                    self?.vc?.getData()
                    self?.dismissMePlease()
                }
            }
        }
    }
    
    var pickerUserImage: UIImage?
    
    @objc func pickUserImage(){
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            PhotoServices.shared.getImageFromGalary(on: self) { (image) in
                self.pickerUserImage = image
            }
        case .notDetermined: PHPhotoLibrary.requestAuthorization ({
            (newStatus) in
            print("status is \(newStatus)")
            if newStatus == PHAuthorizationStatus.authorized {
            }
        })
        case .restricted: print("User do not have access to photo album.")
        case .denied: print("User has denied the permission.")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
}
