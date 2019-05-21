//
//  HomeNewReqViewController.swift
//  Home bride
//
//  Created by Youssef on 4/20/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class AllProvViewController: BaseUIViewController<AllProvView>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProvCell", for: indexPath) as! ProvCell
        cell.configCell(categories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(ProviderProfileViewController(prov: categories[indexPath.row]), animated: ya)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    
//    var id: Int
    private var categories = [Providerr]() {
        didSet {
            mainView.mainCollectionView.reloadData()
        }
    }
    
    var id: Int
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let act = UIActivityIndicatorView(style: .whiteLarge)
    
    private func getAllcategories() {
        act.color = mediumPurple
        let url = "http://m4a8el.panorama-q.com/api/providers/\(id)"
        
        callApi(AllProvData.self, url: url, method: .get, parameters: nil, shouldShowAlert: ya, activityIndicator: act) {[weak self] (data) in
            if let data = data, var provs = data.data {
                for ind in provs.indices {
                    if provs[ind].isOnline {
                        provs.safeSwap(from: ind, to: 0)
                    }
                }
                print(provs)
                self?.categories = provs
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarApperance(title: "", addImageTitle: ya, showNotifButton: no)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), landscapeImagePhone: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(handleSideMenu))
        view.addSubview(act)
        act.fillSuperviewSafeArea()
        setupSideMenu()

        mainView.mainCollectionView.delegate = self
        mainView.mainCollectionView.dataSource = self
        getAllcategories()
    }
    
}
//model

struct AllProvData: BaseCodable {
    var status: Int
    var msg: String?
    let data: [Providerr]?
}

struct Providerr: Codable {
    let id: Int
    let firstName, lastName, email, phone: String
    let role: String
    let isVerified: Int
    let image: String
    let social: Social
    let birthDate, gender: String
    let job: String?
    let location: Location?
    let deliveryRate: String
    let subCategoryID: Int
    let categoryName, subCategoryName: String
    let regionID: Int?
    let info: String
    let token: JSONNull?
    let isOnline: Bool
    let activityType: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email, phone, role
        case isVerified = "is_verified"
        case image, social
        case birthDate = "birth_date"
        case gender, job, location
        case deliveryRate = "delivery_rate"
        case subCategoryID = "sub_category_id"
        case categoryName = "category_name"
        case subCategoryName = "sub_category_name"
        case regionID = "region_id"
        case info, token
        case isOnline = "is_online"
        case activityType = "activity_type"
    }
}

//struct Location: Codable {
//    let lat, lng: String
//}
//
//struct Social: Codable {
//    let facebookLink: String
//    let instagramLink: String
//    let snapchatLink: String
//    let twitterLink: String
//
//    enum CodingKeys: String, CodingKey {
//        case facebookLink = "facebook_link"
//        case instagramLink = "instagram_link"
//        case snapchatLink = "snapchat_link"
//        case twitterLink = "twitter_link"
//    }
//}
