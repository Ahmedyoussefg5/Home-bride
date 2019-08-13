//
//  HomeNewReqViewController.swift
//  Home bride
//
//  Created by Youssef on 4/20/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class ProvServsViewController: BaseUIViewController<ProvServsView>, UITableViewDelegate, UITableViewDataSource, SendResult, DeliveryResulte {
    
    func send(Status: Bool, copon: String?) {
        self.copon = copon
        getDate()
    }
    
    func location(name: String, lat: String, long: String, copon: String?) {
        self.lat = lat
        self.lng = long
        self.copon = copon
        getDate()
    }
    
    func result(name: String) {
        print(name)
        selectedDate = name
    }
    
    var selectedDate: String? {
        didSet {
            guard let data = selectedDate else { return }
            makeRes(date: data)
        }
    }
    
    private func getDate() {
        let data = serv?.filter({ $0.isSelected })
        guard let dataa = data, dataa.count > 0 else {
            showAlert(title: "", message: "يرجى اختيار خدمة واحدة على الاقل")
            return
        }
        let vc = DatePickerViewController(mode: .dateAndTime)
        vc.delegate = self
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {[weak self] in
            self?.presentModelyVC(vc: vc)
        }
    }
    
    var lat: String?
    var lng: String?
    var copon: String?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serv?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProvServCell", for: indexPath) as! ProvServCell
        
        if let data = serv?[indexPath.row] {
            cell.configCell(data)
            
            cell.pressCalender = {[weak self] in
                self?.presentModelyVC(vc: ProvTimeTableViewController(id: self?.id ?? 0))
            }
            cell.pressReq = {[weak self] in
                self?.serv![indexPath.row].isSelected.toggle()
                tableView.reloadData()
            }
            cell.pressOnImageView = {[weak self] in
                self?.openImage(with: self?.serv![indexPath.row].image ?? "")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }

    fileprivate var id: Int
    
    var serv: [ScheduleDataViewModel]? {
        didSet {
            mainView.mainTableView.reloadData()
        }
    }
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func getData() {
        let url = "http://homebride-sa.com/api/services/\(id)"
        callApi(AllServData.self, url: url, method: .get, parameters: nil, activityIndicator: act) {[weak self] (data) in
            if let data = data {
                self?.serv = data.data.services.schedules.map({ ScheduleDataViewModel(id: $0.id, name: $0.name, price: $0.price, image: $0.image, isSelected: false) })
            }
        }
    }
    
    let act = UIActivityIndicatorView(style: .whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.mainTableView.delegate = self
        mainView.mainTableView.dataSource = self
//        setupNavBarApperance(title: , addImageTitle: no, showNotifButton: no)
        title = "خدمات"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "الاجمالي", style: .plain, target: self, action: #selector(total))
        view.addSubview(act)
        act.color = mediumPurple
        act.fillSuperviewSafeArea()
        getData()
        
        mainView.resButton.addTheTarget {[weak self] in
            self?.lng = nil
            self?.lat = nil
            self?.copon = nil
            
            let vc = DeliveryViewController()
            vc.delegate = self
            self?.presentModelyVC(vc: vc)
        }
    }
    
    @objc func total() {
        let data = serv?.filter({ $0.isSelected })
        guard let dataa = data, dataa.count > 0 else { return }
        
        var total = 0
        
        dataa.forEach { (da) in
            total += da.price
        }
        
        showAlert(title: "الاجمالي", message: "\(total)")
    }
    
    func makeRes(date: String) {
        let data = serv?.filter({ $0.isSelected })
        guard let dataa = data, dataa.count > 0 else { return }
        let ids = dataa.map({ $0.id })

        let url = "http://homebride-sa.com/api/reservation"
        
        var pars = [
            "delivery": 0,
            "date": date,
            "services": ids
            ] as [String : Any]
        
        if let lng = lng, let lat = lat {
            pars["lng"] = lng
            pars["lat"] = lat
            pars["delivery"] = 1
        }
        
        if let copon = copon {
            pars["coupon"] = copon
        }

        callApi(ResResposeData.self, url: url, method: .post, parameters: pars, activityIndicator: act) {[weak self] (data) in
            if data != nil {
                self?.showAlert(title: "", messages: nil, message: "تم الحجز بنجاح", selfDismissing: true, time: 0.5)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7, execute: {
                    self?.navigationController?.popViewController(animated: ya)
                    NotificationCenter.default.post(name: .popProviderProfile, object: nil)
                })
            }
        }
    }
    
    private func openImage(with image: String) {
        navigationController?.pushViewController(ImagePreviewViewController(image: image), animated: true)
    }
}

struct AllServData: BaseCodable {
    var status: Int
    var msg: String?
    let data: serv
}

struct serv: Codable {
    let provider: Providerrr
    let services: Servicess
}

struct Providerrr: Codable {
    let name, phone: String
    let location: Location?
    let info, activityType: String
    let image: String
    let region, city, area: String
    let social: Social
    
    enum CodingKeys: String, CodingKey {
        case name, phone, location, info
        case activityType = "activity_type"
        case image, region, city, area, social
    }
}

//struct Location: Codable {
//    let lat, lng: String
//}

//struct Social: Codable {
//    let facebookLink, instagramLink, snapchatLink, twitterLink: String
//
//    enum CodingKeys: String, CodingKey {
//        case facebookLink = "facebook_link"
//        case instagramLink = "instagram_link"
//        case snapchatLink = "snapchat_link"
//        case twitterLink = "twitter_link"
//    }
//}

struct Servicess: Codable {
    let schedules: [ScheduleData]
    let paginate: Paginate
}

//struct Schedule: Codable {
//    let id: Int
//    let name: String
//    let price: Int
//    let image: String
//}
struct ScheduleDataViewModel: Codable {
    let id: Int
    let name: String
    let price: Int
    let image: String
    var isSelected: Bool = false
}
//
struct ResResposeData: BaseCodable {
    var status: Int
    var msg: String?
    let data: ResRespose?
}

struct ResRespose: Codable {
    let orderID: Int
//    let delivery: String
//    let status: JSONNull?
    let date: String
//    let lat, lng, deliveryFees: JSONNull?
    let subCategory, region: String
    let services: [Service]
    let total: Int
//    let client, provider: Client
    
    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        //        case status
        //        case delivery
        case date//, lat, lng
//        case deliveryFees = "delivery_fees"
        case subCategory = "sub_category"
        case region, services, total//, client, provider
    }
}

//struct Client: Codable {
//    let name, phone: String
//    let job: String?
//    let image: String
//    let birthDate: String?
//    let social: Social
//    let location: Location?
//    let region: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case name, phone, job, image
//        case birthDate = "birth_date"
//        case social, location, region
//    }
//}

//struct Location: Codable {
//    let lat, lng: String
//}
//
//struct Social: Codable {
//    let facebook, instagram, snapchat, twitter: JSONNull?
//}

//struct Service: Codable {
//    let serviceID: Int
//    let name: String
//    let price: Int
//
//    enum CodingKeys: String, CodingKey {
//        case serviceID = "service_id"
//        case name, price
//    }
//}
