//
//  HomeNewReqViewController.swift
//  Home bride
//
//  Created by Youssef on 4/20/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit
import Photos

class UserProfileView: BaseView {

    private lazy var profileContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.insertSublayer(gradientLayer, at: 0)
        return view
    }()
    lazy var userImage: BigImage = {
        let img = BigImage()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.image = #imageLiteral(resourceName: "girl")
        img.viewCornerRadius = 50
        img.translatesAutoresizingMaskIntoConstraints = false
        img.load(with: AuthService.instance.userImage)
        return img
    }()
    
    lazy var gradientLayer = LinearGradientLayer(colors: [mediumPurple, lightPurple])

    let nameLable = WhiteLable(text: AuthService.instance.userFirstName ?? "Name")
    
    lazy var editProfileButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("تعديل", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .CairoSemiBold(of: 15)
        btn.titleLabel?.underline()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTheTarget(action: {[weak self] in
            self?.confirmButton.isHidden.toggle()
            [
                self?.firstNameText,
                self?.familyNameText,
                self?.mailText,
                self?.phoneText
                ].forEach({ (con) in
                    con?.isEnabled.toggle()
                })
        })
        return btn
    }()
    
    let firstNameText = UnderLineTextField(placeH: AuthService.instance.userFirstName ?? "الاسم الاول")
    let familyNameText = UnderLineTextField(placeH: AuthService.instance.userLastName ?? "اسم العائلة")
    let mailText = UnderLineTextField(placeH: AuthService.instance.userEmail ?? "البريد الالكتروني")
    let phoneText = UnderLineTextField(placeH: AuthService.instance.userPhone ?? "رقم الجوال")

    override func setupView() {
        super.setupView()
        
        addSubview(profileContainerView)
        profileContainerView.centerXInSuperview()
        profileContainerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = ya
        profileContainerView.widthAnchorWithMultiplier(multiplier: 1)
        profileContainerView.heightAnchorConstant(constant: 230)
        
        profileContainerView.addSubview(userImage)
        userImage.centerXInSuperview()
        userImage.topAnchorSuperView(constant: 15)

        profileContainerView.addSubview(nameLable)
        nameLable.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 3).isActive = ya
//        nameLable.widthAnchorWithMultiplier(multiplier: 1)
//        nameLable.adjustsFontSizeToFitWidth = ya
//        nameLable.numberOfLines = 0
        nameLable.centerXInSuperview()
        
        profileContainerView.isUserInteractionEnabled = ya
        
        profileContainerView.addSubview(editProfileButton)
        editProfileButton.centerXInSuperview()
        editProfileButton.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: 0).isActive = ya
        confirmButton.isHidden = ya
        setupProfileView()
        [
            self.firstNameText,
            self.familyNameText,
            self.mailText,
            self.phoneText
            ].forEach({ (con) in
                con.isEnabled.toggle()
            })
    }
    
    private func setupProfileView() {

        let profileStack = UIStackView(arrangedSubviews: [
            firstNameText,
            familyNameText,
            mailText,
            phoneText
            ])
        profileStack.axis = v
        profileStack.distribution = .fillEqually
        profileStack.spacing = 10
        addSubview(profileStack)
        profileStack.widthAnchorWithMultiplier(multiplier: 0.9)
        profileStack.topAnchor.constraint(equalTo: profileContainerView.bottomAnchor, constant: 10).isActive = ya
        profileStack.centerXInSuperview()
        profileStack.heightAnchorConstant(constant: 200)
        
        addSubview(confirmButton)
        confirmButton.centerXInSuperview()
        confirmButton.widthAnchorWithMultiplier(multiplier: 0.9)
        confirmButton.heightAnchorConstant(constant: 45)
        confirmButton.topAnchorToView(anchor: profileStack.bottomAnchor, constant: 20)
    }
    
    lazy var confirmButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("حفظ", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .CairoSemiBold(of: 15)
        btn.layer.cornerRadius = 15
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.9285544753, green: 0.3886299729, blue: 0.6461874247, alpha: 1)
        btn.addTheTarget(action: {[weak self] in
//            self?.addimage()
        })
        return btn
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = profileContainerView.bounds
    }
}


class UserProfileViewController: BaseUIViewController<UserProfileView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupNavBarApperance(title: "", addImageTitle: no, showNotifButton: no)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), landscapeImagePhone: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(handleSideMenu))
        
        mainView.userImage.addTapGestureRecognizer {[weak self] in
            self?.pickUserImage()
        }
        
        title = "الملف الشخصي"
        
        mainView.confirmButton.addTheTarget {[weak self] in
            if self?.pickerUserImage == nil {
                self?.saveDate()
            } else {
                self?.addimage()
            }
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        openedViewController = ""
    }
    private func saveDate() {
        let url = "http://m4a8el.panorama-q.com/api/user/update/profile"
        var pars = [String:Any]()
        pars["first_name"] = mainView.firstNameText.text
        pars["last_name"] = mainView.familyNameText.text
        pars["email"] = mainView.mailText.text
        pars["phone"] = mainView.phoneText.text
        
        callApi(UpdateProfData.self, url: url, parameters: pars) {[weak self] (data) in
            if let data = data {
                guard let userData = data.data else { return }
                AuthService.instance.setUserDefaults(update: userData)
                self?.mainView.firstNameText.placeholder = userData.firstName
                self?.mainView.familyNameText.placeholder = userData.lastName
                self?.mainView.mailText.placeholder = userData.email
                self?.mainView.phoneText.placeholder = userData.phone
                self?.showAlert(title: "", message: "تم الحفظ")
            }
        }
    }
    
    private func addimage() {
        guard let img = pickerUserImage, let imgData = img.jpegData(compressionQuality: 0.5) else { return }
        let url = "http://m4a8el.panorama-q.com/api/user/update/profile"

        let imageData = UploadData(data: imgData, fileName: "image.jpeg", mimeType: "image/jpeg", name: "image")
        
        var pars = [String:Any]()
        pars["first_name"] = mainView.firstNameText.text
        pars["last_name"] = mainView.familyNameText.text
        pars["email"] = mainView.mailText.text
        pars["phone"] = mainView.phoneText.text
        
        Network.shared.uploadToServerWith(UpdateProfData.self, data: imageData, url: url, method: .post, parameters: pars, progress: nil) {[weak self] (err, data) in
            if let err = err {
                self?.showAlert(title: nil, message: err)
            } else if let data = data {
                guard let userData = data.data else { return }
                AuthService.instance.setUserDefaults(update: userData)
                self?.mainView.userImage.load(with: data.data?.image)
                self?.showAlert(title: "", message: "تم الحفظ")
            }
        }
    }
    
    var pickerUserImage: UIImage? {
        didSet {
            mainView.userImage.image = pickerUserImage
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
}
