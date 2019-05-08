//
//  LoginViewController.swift
//  Awfr Client
//
//  Created by Youssef on 4/14/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class RegisterViewController: BaseUIViewController<RegisterView>, SendResult {
    weak var sender: CreateAccountButton?
    
    var rigonId: Int?
    var catId: Int?

    func result(name: String) {
        sender?.setTitleNormalState(name)
        if sender == mainView.locationAreaButton {
            var id = 0
            for area in allArea {
                if area.name == name {
                    id = area.id
                }
            }
            getCity(id: id)
        }
        
        if sender == mainView.locationCityButton {
            var id = 0
            for city in allCity {
                if city.name == name {
                    id = city.id
                }
            }
            getRigon(id: id)
        }
        
        if sender == mainView.locationDistinctButton {
            for rigon in allRigon {
                if rigon.name == name {
                    rigonId = rigon.id
                }
            }
        }

        
        if sender == mainView.mainJobButton {
            var id = 0
            for cat in allCategories {
                if cat.name == name {
                    id = cat.id
                }
            }
            getCat(id: id)
        }
        
        if sender == mainView.secoundryJobButton {
            for cat in categories {
                if cat.name == name {
                    catId = cat.id
                }
            }
        }
    }
    
    func location(name: String) {
//        mainView.locationButton.setTitleNormalState(name)
    }
    
//    var pars: [String: Any]
//    
//    init(parameters: [String : Any]) {
//        pars = parameters
//        super.init(nibName: nil, bundle: nil)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trasperantNavBar()
        getAllArea()
        getAllcategories()
        mainView.loginButton.addTheTarget(action: {[weak self] in
            guard let rId = self?.rigonId , let cId = self?.catId else { return }
            self?.navigationController?.pushViewController(UserRegisterViewController(catId: cId, rigonId: rId), animated: true)
        })
        
        act.color = .gray
        view.addSubview(act)
        act.fillSuperview()
        
//        mainView.locationButton.addTheTarget {[weak self] in
//            self?.sender = self?.mainView.locationButton
//            let map = MapViewController()
//            map.delegate = self
//            let vc = UINavigationController(rootViewController: map)
//            vc.navbarWithdismiss()
//            self?.presentModelyVC(vc: vc)
//        }
        
        mainView.locationAreaButton.addTheTarget {[weak self] in
            let data = self?.allArea.map({
                $0.name
            })
            self?.handleTargets(sender: self?.mainView.locationAreaButton, items: data)
        }
        
        mainView.locationDistinctButton.addTheTarget {[weak self] in
            let data = self?.allRigon.map({
                $0.name
            })
            self?.handleTargets(sender: self?.mainView.locationDistinctButton, items: data)
        }
        
        mainView.locationCityButton.addTheTarget {[weak self] in
            let data = self?.allCity.map({
                $0.name
            })
            self?.handleTargets(sender: self?.mainView.locationCityButton, items: data)
        }
        
        mainView.mainJobButton.addTheTarget {[weak self] in
            let data = self?.allCategories.map({
                $0.name
            })
            self?.handleTargets(sender: self?.mainView.mainJobButton, items: data)
        }
        
        mainView.secoundryJobButton.addTheTarget {[weak self] in
            let data = self?.categories.map({
                $0.name
            })
            self?.handleTargets(sender: self?.mainView.secoundryJobButton, items: data)
        }
    }
    
    private func handleTargets(sender: CreateAccountButton?, items: [String]?) {
        self.sender = sender
        let vc = PickerViewController(itemsToShow: items ?? [""])
        vc.delegate = self
        presentModelyVC(vc: vc)
    }
    
    let act = UIActivityIndicatorView(style: .whiteLarge)
    private var allArea = [Area]()
    private var allCity = [Area]()
    private var allRigon = [Area]()
    private var allCategories = [Categories]()
    private var categories = [Categories]()

    private func getAllArea() {
        
        let url = "http://m4a8el.panorama-q.com/api/locations/areas"
        
        callApi(AllArea.self, url: url, method: .get, parameters: nil, shouldShowAlert: ya, activityIndicator: act) {[weak self] (data) in
            if let data = data {
                self?.allArea = data.data
            }
        }
    }
    
    private func getCity(id: Int) {
        
        let url = "http://m4a8el.panorama-q.com/api/locations/cities/\(id)"
        
        callApi(AllArea.self, url: url, method: .get, parameters: nil, shouldShowAlert: ya, activityIndicator: act) {[weak self] (data) in
            if let data = data {
                self?.allCity = data.data
            }
        }
    }

    private func getRigon(id: Int) {
        
        let url = "http://m4a8el.panorama-q.com/api/locations/regions/\(id)"
        
        callApi(AllArea.self, url: url, method: .get, parameters: nil, shouldShowAlert: ya, activityIndicator: act) {[weak self] (data) in
            if let data = data {
                self?.allRigon = data.data
            }
        }
    }
    
    private func getAllcategories() {
        let url = "http://m4a8el.panorama-q.com/api/categories"
        
        callApi(AllCategories.self, url: url, method: .get, parameters: nil, shouldShowAlert: ya, activityIndicator: nil) {[weak self] (data) in
            if let data = data {
                self?.allCategories = data.data
            }
        }
    }
    
    private func getCat(id: Int) {
        
        let url = "http://m4a8el.panorama-q.com/api/sub_categories/\(id)"
        
        callApi(AllCategories.self, url: url, method: .get, parameters: nil, shouldShowAlert: ya, activityIndicator: act) {[weak self] (data) in
            if let data = data {
                self?.categories = data.data
            }
        }
    }
}

struct AllArea: BaseCodable {
    var status: Int
    var msg: String?
    let data: [Area]
}

struct Area: Codable {
    let id: Int
    let name: String
}

struct AllCategories: BaseCodable {
    var status: Int
    var msg: String?
    let data: [Categories]
}

struct Categories: Codable {
//    var status: Int?
    let id: Int
    let name: String
    let image: String
    let providers: [String]
}
