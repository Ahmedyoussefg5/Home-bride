//
//  TripDetailsView.swift
//  Awfr Client
//
//  Created by Youssef on 4/15/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class NewRequestDetailsViewController: BaseUIViewController<NewRequestDetailsView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "رجوع", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissMePlease))
        setupNavBarApperance(title: "تفاصيل الطلب", addImageTitle: no, showNotifButton: no)
        getData()
        
        mainView.locationButton.addTheTarget {[weak self] in
            if let long = self?.data?.data.lng, let lat = self?.data?.data.lat {
                let vc = UserLocationMapViewController(long: long, lat: lat)
                self?.presentModelyVC(vc: vc)
            }
        }
        
        mainView.phoneButton.addTheTarget {[weak self] in
            if let phone = self?.data?.data.client.phone {
                guard let number = URL(string: "tel://" + phone) else { return }
                UIApplication.shared.open(number)
                
//                UIApplication.shared.open(number, options: [:], completionHandler: nil)

            }
        }

        
        mainView.messageButton.addTheTarget {[weak self] in
            if let id = self?.data?.data.orderID {
                let vc = UINavigationController(rootViewController: ChatViewController(orderId: id))
                vc.navbarWithdismiss()
                self?.presentModelyVC(vc: vc)
            }
        }
        
        mainView.acceptButton.addTheTarget {
            
        }
        
        mainView.refuseButton.addTheTarget {
            
        }
    }
    
    private func accept() {
        
    }
    
    var data: ReqData? {
        didSet {
            if let data = data {
                mainView.confView(data: data)
            }
        }
    }
    
    var id : Int
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getData() {
        let url = "http://m4a8el.panorama-q.com/api/reservation/\(id)"
        callApi(ReqData.self, url: url, method: .get, parameters: nil) { (data) in
            if let data = data {
                self.data = data
            }
        }
    }
}

class NewRequestDetailsView: BaseView {
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.alwaysBounceVertical = true
        scroll.contentSize.height = 800
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    let adrressLable = RequestDetailsGrayLable(title: "القسم الرئيسي - القسم الفرعي - نوع الطلب")
    let dateLable = RequestDetailsGrayLable(title: "123-12-12")
    let priceLable = RequestDetailsGrayLable(title: "السعر: ١٢٣٠٠٠ ريال")

    let phoneNumLable = RequestDetailsGrayLable(title: "رقم الجوال")
    let birthLable = RequestDetailsGrayLable(title: "تاريخ الميلاد")
//    let cityLable = RequestDetailsGrayLable(title: "الوظيفة")

    lazy var faceButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("".localize, for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.6158300638, green: 0.6195418239, blue: 0.6282081604, alpha: 1), for: .normal)
        btn.titleLabel?.font = .CairoRegular(of: 13)
        btn.addTrailingImageView(image: #imageLiteral(resourceName: "facebook"), width: 20, hight: 20)
        btn.contentHorizontalAlignment = .leading
        return btn
    }()
    lazy var googleButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("".localize, for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.6158300638, green: 0.6195418239, blue: 0.6282081604, alpha: 1), for: .normal)
        btn.titleLabel?.font = .CairoRegular(of: 13)
        btn.addTrailingImageView(image: #imageLiteral(resourceName: "twitter (1)").withRenderingMode(.alwaysTemplate), width: 20, hight: 20)
        btn.contentHorizontalAlignment = .leading
        return btn
    }()
    lazy var twitterButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("".localize, for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.6158300638, green: 0.6195418239, blue: 0.6282081604, alpha: 1), for: .normal)
        btn.titleLabel?.font = .CairoRegular(of: 13)
        btn.addTrailingImageView(image: #imageLiteral(resourceName: "twitter"), width: 20, hight: 20)
        btn.contentHorizontalAlignment = .leading
        return btn
    }()

    private lazy var detailsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.viewBorderWidth = 0.5
        view.viewBorderColor = #colorLiteral(red: 0.89402318, green: 0.8941735625, blue: 0.89400208, alpha: 1)
        view.viewCornerRadius = 0
        view.backgroundColor = .white
        view.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.19), alpha: 1, x: 0, y: 3, blur: 2, spread: 0)
        return view
    }()
    private lazy var agentDetailsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.viewBorderWidth = 0.5
        view.viewBorderColor = #colorLiteral(red: 0.89402318, green: 0.8941735625, blue: 0.89400208, alpha: 1)
        view.viewCornerRadius = 0
        view.backgroundColor = .white
        view.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.19), alpha: 1, x: 0, y: 3, blur: 2, spread: 0)
        return view
    }()
    
    private lazy var userImage: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.19), alpha: 1, x: 0, y: 3, blur: 2, spread: 0)
        img.image = #imageLiteral(resourceName: "girl")
        img.viewCornerRadius = 35
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var locationButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("عرض المنطقة".localize, for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0.9285544753, green: 0.3886299729, blue: 0.6461874247, alpha: 1), for: .normal)
        btn.titleLabel?.font = .CairoRegular(of: 13)
        btn.addTrailingImageView(image: #imageLiteral(resourceName: "facebook-placeholder-for-locate-places-on-maps").withRenderingMode(.alwaysTemplate), width: 20, hight: 20)
        btn.contentHorizontalAlignment = .leading
        return btn
    }()
    
    lazy var phoneButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setBackgroundImage(#imageLiteral(resourceName: "speech-bubble (1)").withRenderingMode(.alwaysTemplate), for: .normal)
        return btn
    }()
    lazy var messageButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setBackgroundImage(#imageLiteral(resourceName: "chat").withRenderingMode(.alwaysTemplate), for: .normal)
        return btn
    }()
    
    lazy var acceptButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .white
        btn.viewBorderWidth = 0.5
        btn.viewBorderColor = #colorLiteral(red: 0.9285544753, green: 0.3886299729, blue: 0.6461874247, alpha: 1)
        btn.setTitleColorNormalState(#colorLiteral(red: 0.9285544753, green: 0.3886299729, blue: 0.6461874247, alpha: 1))
        btn.setTitle("موافقة", for: .normal)
        btn.titleLabel?.font = UIFont.CairoSemiBold(of: 14)
        return btn
    }()
    lazy var refuseButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = #colorLiteral(red: 0.9285544753, green: 0.3886299729, blue: 0.6461874247, alpha: 1)
        btn.setTitle("رفض", for: .normal)
        btn.titleLabel?.font = UIFont.CairoSemiBold(of: 14)
        btn.setTitleColorNormalState(.white)
        return btn
    }()
    
    internal override func setupView() {
        super.setupView()
        
        addSubview(scrollView)
        scrollView.fillSuperview()
        
        let headLable = RequestDetailsGrayLable(title: "بيانات الطلب")
        scrollView.addSubview(headLable)
        headLable.translatesAutoresizingMaskIntoConstraints = no
        headLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = ya
        headLable.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = ya

        scrollView.addSubview(locationButton)
        locationButton.leadingAnchorSuperView(constant: 20)
        locationButton.centerYAnchor.constraint(equalTo: headLable.centerYAnchor).isActive = ya
        locationButton.widthAnchorConstant(constant: 105)
        
        scrollView.addSubview(detailsContainerView)
        detailsContainerView.topAnchor.constraint(equalTo: headLable.bottomAnchor, constant: 10).isActive = ya
        detailsContainerView.widthAnchorWithMultiplier(multiplier: 0.9)
        detailsContainerView.centerXInSuperview()
        detailsContainerView.heightAnchorConstant(constant: 200)
        
        //
        let headLablee = RequestDetailsGrayLable(title: "بيانات العميل")
        scrollView.addSubview(headLablee)
        headLablee.translatesAutoresizingMaskIntoConstraints = no
        headLablee.trailingAnchor.constraint(equalTo: detailsContainerView.trailingAnchor).isActive = ya
        headLablee.topAnchor.constraint(equalTo: detailsContainerView.bottomAnchor, constant: 10).isActive = ya
//

        scrollView.addSubview(agentDetailsContainerView)
        agentDetailsContainerView.topAnchor.constraint(equalTo: headLablee.bottomAnchor, constant: 10).isActive = ya
        agentDetailsContainerView.widthAnchorWithMultiplier(multiplier: 0.9)
        agentDetailsContainerView.centerXInSuperview()
        agentDetailsContainerView.heightAnchorConstant(constant: 300)

        setupRequestDetailsView()
        setupAgentDetailsContainerView()
        
        let stack = UIStackView(arrangedSubviews: [refuseButton, acceptButton])
        stack.axis = .horizontal
        stack.spacing = 70
        stack.distribution = .fillEqually
        scrollView.addSubview(stack)
        ActivateConstraint([
            stack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            stack.heightAnchor.constraint(equalToConstant: 40),
            stack.centerXInSuperview(),
            stack.topAnchor.constraint(equalTo: agentDetailsContainerView.bottomAnchor, constant: 20)
            ])
    }
    
    private func setupRequestDetailsView() {
        let headLable = RequestDetailsRedLable(title: "اسم الطلب")
        let requestsLable = RequestDetailsRedLable(title: "الخدمات المطلوبة")
        let totalLable = RequestDetailsRedLable(title: "اجمالي الحساب")
        
        let baseStack =
            UIStackView(arrangedSubviews: [
                headLable,
                adrressLable,
                dateLable,
                stackSpliterGray(),
                requestsLable,
                //                mainTableView,
                stackSpliterGray(),
                totalLable,
                priceLable
                ])
        
        baseStack.axis = .vertical
        baseStack.spacing = 5
        detailsContainerView.addSubview(baseStack)
        baseStack.fillSuperview(padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    let agentNameLable = RequestDetailsRedLable(title: "اسم العميل")
    let agentJobLable = RequestDetailsRedLable(title: "المهنة")
    
    private func setupAgentDetailsContainerView() {
        
        agentDetailsContainerView.addSubview(userImage)
        userImage.trailingAnchorAnchorSuperView(constant: -20)
        userImage.widthAnchorConstant(constant: 50)
        userImage.heightAnchorEqualWidthAnchor()
        userImage.topAnchorSuperView(constant: 5)
        userImage.viewCornerRadius = 25
        
        let agentStack =
            UIStackView(arrangedSubviews: [
                agentNameLable,
                agentJobLable,
                ])
        
        agentStack.axis = .vertical
        agentStack.spacing = 5
        agentDetailsContainerView.addSubview(agentStack)
        agentStack.trailingAnchor.constraint(equalTo: userImage.leadingAnchor, constant: -10).isActive = ya
        agentStack.centerYAnchor.constraint(equalTo: userImage.centerYAnchor).isActive = ya
        agentStack.widthAnchorWithMultiplier(multiplier: 0.5)
        
        //
        let contactStack =
            UIStackView(arrangedSubviews: [
                phoneButton,
                messageButton,
                ])
        
        contactStack.axis = h
        contactStack.spacing = 10
        contactStack.distribution = .fillEqually
        contactStack.translatesAutoresizingMaskIntoConstraints = no
        agentDetailsContainerView.addSubview(contactStack)
        contactStack.leadingAnchor.constraint(equalTo: agentDetailsContainerView.leadingAnchor, constant: 10).isActive = ya
        contactStack.centerYAnchor.constraint(equalTo: userImage.centerYAnchor).isActive = ya
        contactStack.heightAnchorConstant(constant: 40)
        contactStack.widthAnchorConstant(constant: 90)
        //
        let view = stackSpliterGray()
        agentDetailsContainerView.addSubview(view)
        view.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 5).isActive = ya
        view.widthAnchorWithMultiplier(multiplier: 0.9)
        view.centerXInSuperview()
//        view.heightAnchorConstant(constant: 300)

        //
        let requestsLable = RequestDetailsRedLable(title: "بيانات شخصية")
        let totalLable = RequestDetailsRedLable(title: "حسابات التواصل الاجتماعي")

        let baseStack =
            UIStackView(arrangedSubviews: [
                requestsLable,
                stackSpliter(),
                phoneNumLable,
                birthLable,
//                cityLable,
//                stackSpliter(),
                stackSpliterGray(),
                stackSpliter(),
                totalLable,
                faceButton,
                googleButton,
                twitterButton
                ])

        baseStack.axis = .vertical
        baseStack.spacing = 2
        agentDetailsContainerView.addSubview(baseStack)
        baseStack.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 3).isActive = ya
        baseStack.widthAnchorWithMultiplier(multiplier: 0.9)
        baseStack.centerXInSuperview()
        baseStack.heightAnchorConstant(constant: 220)
    }
    
    func confView(data: ReqData) {
        adrressLable.text = data.data.subCategory
        dateLable.text = data.data.date
        priceLable.text = "\(data.data.total)"
        phoneNumLable.text = "\(phoneNumLable.text ?? ""): \(data.data.client.phone ?? "")"
        birthLable.text = "\(birthLable.text ?? ""): \(data.data.client.birthDate ?? "")"
//        cityLable.text = "\(cityLable.text ?? ""): \(data.data.client.job ?? "")"
        userImage.load(with: data.data.client.image)
        agentNameLable.text = data.data.client.name
        agentJobLable.text = data.data.client.job
        faceButton.setTitleNormalState(data.data.client.social.facebook)
        twitterButton.setTitleNormalState(data.data.client.social.twitter)
        googleButton.setTitleNormalState(data.data.client.social.snapchat)
    }
}

class RequestDetailsGrayLable: UILabel {
    init(title: String?) {
        super.init(frame: .zero)
        text = title
        font = UIFont.CairoBold(of: 12)
        textColor = #colorLiteral(red: 0.3513553739, green: 0.3335490525, blue: 0.3331353664, alpha: 1)
        textAlignment = .right
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class RequestDetailsRedLable: UILabel {
    init(title: String?) {
        super.init(frame: .zero)
        text = title
        font = UIFont.CairoBold(of: 12)
        textColor = #colorLiteral(red: 0.8602862358, green: 0.3605225086, blue: 0.5980046391, alpha: 1)
        textAlignment = .right
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


struct ReqData: BaseCodable {
    var status: Int
    var msg: String?
    let data: Req
}

struct Req: Codable {
    let orderID, delivery, status: Int
    let date: String
    let lat, lng: Double?
    let deliveryFees, subCategory, region: String?
    let services: [Service]
    let total: Int
    let client: Client
    let provider: Provider
    
    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case delivery, status, date, lat, lng
        case deliveryFees = "delivery_fees"
        case subCategory = "sub_category"
        case region, services, total, client, provider
    }
}

struct Client: Codable {
    let name, phone, job: String?
    let image: String?
    let birthDate: String?
    let social: RevSocial
    let location: Location?
    
    enum CodingKeys: String, CodingKey {
        case name, phone, job, image
        case birthDate = "birth_date"
        case social, location
    }
}

struct Location: Codable {
    let lat, lng: String?
}

struct RevSocial: Codable {
    let facebook: String?
    let instagram, snapchat, twitter: String?
}

struct Provider: Codable {
    let name, phone, job: String
    let image: String
    let birthDate: JSONNull?
    let region: String
    let location: Location
    let social: Social
    
    enum CodingKeys: String, CodingKey {
        case name, phone, job, image
        case birthDate = "birth_date"
        case region, location, social
    }
}

struct Service: Codable {
    let serviceID: Int
    let name: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case serviceID = "service_id"
        case name, price
    }
}
