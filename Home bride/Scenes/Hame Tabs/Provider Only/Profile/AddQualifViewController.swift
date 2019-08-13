//
//  CountriesTableViewController.swift
//  Gawla
//
//  Created by Youssef on 12/11/18.
//  Copyright © 2018 ITGeeKs. All rights reserved.
//

import UIKit
import Photos

class AddQualifViewController: UIViewController {
    
    weak var delegate: SendResult?    
    
    private lazy var confirmButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("حفظ", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .CairoSemiBold(of: 15)
        btn.layer.cornerRadius = 15
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.9285544753, green: 0.3886299729, blue: 0.6461874247, alpha: 1)
        btn.addTheTarget(action: {[weak self] in
            guard let self = self else { return }
            if let id = self.id {
                self.editService(id: id)
            } else {
                self.addQualif()
            }
        })
        return btn
    }()
    private let nameText = UnderLineTextFieldd(placeH: "اسم المؤهل")
    private let costText = UnderLineTextFieldd(placeH: "سنوات الخبرة")
    
//    let qualificaionNameText = UnderLineTextFieldd(placeH: )
//    let theQualificaionText = UnderLineTextFieldd(placeH: )
//    let qualificaionImage = UIButton(type: .system)
//
//    lazy var confirmButton: UIButton = {
//        let btn = UIButton(type: .system)
//        btn.setTitle("حفظ", for: .normal)
//        btn.setTitleColor(.white, for: .normal)
//        btn.titleLabel?.font = .CairoSemiBold(of: 15)
//        btn.layer.cornerRadius = 15
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.backgroundColor = #colorLiteral(red: 0.9285544753, green: 0.3886299729, blue: 0.6461874247, alpha: 1)
//        btn.addTheTarget(action: {[weak self] in
//            //            self?.addimage()
//        })
//        return btn
//    }()
//    lazy var photoButton: UIButton = {
//        let btn = UIButton(type: .system)
//        btn.setTitle("صورة المؤهل", for: .normal)
//        btn.contentHorizontalAlignment = .trailing
//        btn.setTitleColor(.gray, for: .normal)
//        btn.addBottomLine()
//        //btn.backgroundColor = #colorLiteral(red: 0.9371561408, green: 0.9373133779, blue: 0.9371339679, alpha: 1)
//        btn.titleLabel?.font = .CairoSemiBold(of: 15)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        let view = UIView()
//        view.backgroundColor = .lightGray
//        btn.addSubview(view)
//        view.topAnchor.constraint(equalTo: btn.bottomAnchor).isActive = ya
//        view.centerXInSuperview()
//        view.heightAnchorConstant(constant: 1)
//        view.widthAnchorWithMultiplier(multiplier: 1)
//        btn.addTheTarget(action: {[weak self] in
//            //            self?.pickUserImage()
//        })
//        return btn
//    }()

    private lazy var userImage: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.widthAnchorConstant(constant: 30)
        img.heightAnchorConstant(constant: 30)
        //        img.image = #imageLiteral(resourceName: "checkbox")
        //        img.viewCornerRadius = 40
        //        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var photoButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("صورة المؤهل", for: .normal)
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
        
        btn.addSubview(userImage)
        userImage.leadingAnchorSuperView(constant: 10)
        userImage.centerYInSuperview()
        
        btn.addTheTarget(action: {[weak self] in
            self?.pickUserImage()
        })
        return btn
    }()
    
    weak var vc: ProfileViewController?
    
    private var id: Int?
    
    init(vc: ProfileViewController, id: Int?) {
        self.vc = vc
        self.id = id
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
            confirmButton.bottomAnchorSuperView(constant: -1)
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
           stack.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -5)
            ])
    }
    
    // add qualf
    private func addQualif() {
        guard let img = pickerUserImage, let imgData = img.jpegData(compressionQuality: 0.5) else { return }
        guard let name = nameText.text, name.count > 1 ,
            let degree = costText.text, degree.count > 0 else {
                showAlert(title: "خطأ", message: "تأكد من البيانات المدخلة")
                return }

        let url = "http://homebride-sa.com/api/qualifications"
        let pars = [
            "name": name,
            "degree": degree
            ] as [String : Any]
        let imageData = UploadData(data: imgData, fileName: "image.jpeg", mimeType: "image/jpeg", name: "image")
        
        Network.shared.uploadToServerWith(AllQualifeData.self, data: imageData, url: url, method: .post, parameters: pars, progress: nil) {[weak self] (err, data) in
            if let err = err {
                self?.showAlert(title: nil, message: err)
            } else if let data = data {
                if data.msg != nil {
                    self?.showAlert(title: nil, message: data.msg)
                } else {
                    self?.vc?.getQualifData()
//                    self?.showAlert(title: "", message: "تم الحفظ")
                    self?.dismissMePlease()
                }
            }
        }
    }
    
    private func editService(id: Int) {
        guard let img = pickerUserImage, let imgData = img.jpegData(compressionQuality: 0.5) else { return }
        
        guard let name = nameText.text, name.count > 2 , let price = costText.text, price.count > 0 else {
            showAlert(title: "خطأ", message: "تأكد من البيانات المدخلة")
            return }
        let url = "http://homebride-sa.com/api/qualifications/\(id)"
        let pars = [
            "name": name,
            "price": price
            ] as [String : Any]
        let imageData = UploadData(data: imgData, fileName: "image.jpeg", mimeType: "image/jpeg", name: "image")
        
        Network.shared.uploadToServerWith(AddQualification.self, data: imageData, url: url, method: .post, parameters: pars, progress: nil) {[weak self] (err, data) in
            if let err = err {
                self?.showAlert(title: nil, message: err)
            } else if let data = data {
                if data.msg != nil {
                    self?.showAlert(title: nil, message: data.msg)
                } else {
                    self?.vc?.getServicesData()
                    self?.dismissMePlease()
                }
            }
        }
    }
    
    var pickerUserImage: UIImage? {
        didSet {
            userImage.image = pickerUserImage
        }
    }
    
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

//Add Qoualif
struct AddQualification: BaseCodable {
    var status: Int
    var msg: String?
    let data: AddQualificationsClass?
}

// MARK: - DataClass
struct AddQualificationsClass: Codable {
    let name: String?
    let id: Int?
    let degree: String?
    let image: String?
}
