//
//  HomeNewReqViewController.swift
//  Home bride
//
//  Created by Youssef on 4/20/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class ProvProfileViewController: BaseUIViewController<ProvProfileView>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: QualCollCell.self, for: indexPath)
        if let data = dataSource?[indexPath.row] {
            cell.config(item: data)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.3, height: collectionView.frame.width * 0.3)
    }
    
    fileprivate var dataSource: [Qualification]? {
        didSet {
            mainView.mainCollectionView.reloadData()
        }
    }
    
    fileprivate var id: Int
    
    init(id: Int, name: String?, address: String?) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
        
        mainView.nameLable.text = name
        mainView.addressLable.text = address
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func getData() {
        let url = "http://m4a8el.panorama-q.com/api/qualifications/\(id)"
        callApi(AllQualifications.self, url: url, method: .get, parameters: nil, activityIndicator: act) {[weak self] (data) in
            if let data = data {
                self?.dataSource = data.data?.qualifications
            }
        }
    }
    
    let act = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dismissGeasture = UITapGestureRecognizer(target: self, action: #selector(dismissMePlease))
        mainView.addGestureRecognizer(dismissGeasture)
        mainView.mainCollectionView.delegate = self
        mainView.mainCollectionView.dataSource = self
        getData()
        act.color = mediumPurple
        view.addSubview(act)
        act.fillSuperviewSafeArea()
    }
}

//
//
//
struct AllQualifications: BaseCodable {
    var status: Int
    var msg: String?
    let data: Qualifications?
}

struct Qualifications: Codable {
    let qualifications: [Qualification]
    let paginate: Paginate
}


struct Qualification: Codable {
    let id: Int
    let name: String
    let degree, date: String?
    let image: String
}


