//
//  HomeNewReqViewController.swift
//  Home bride
//
//  Created by Youssef on 4/20/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class SubCatViewController: BaseUIViewController<SubCatView>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCatCell", for: indexPath) as! SubCatCell
        cell.configCell(categories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(AllProvViewController(id: categories[indexPath.row].id), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.48, height: collectionView.frame.width * 0.48)
    }
    
    var id: Int
    var name: String
    private var categories = [Categories]() {
        didSet {
            mainView.mainCollectionView.reloadData()
        }
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let act = UIActivityIndicatorView(style: .whiteLarge)
    
    private func getCat() {
        act.color = mediumPurple
        let url = "http://homebride-sa.com/api/sub_categories/\(id)"
        
        callApi(AllCategories.self, url: url, method: .get, parameters: nil, shouldShowAlert: ya, activityIndicator: act) {[weak self] (data) in
            if let data = data {
                self?.categories = data.data
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarApperance(title: "", addImageTitle: no, showNotifButton: no)
        
        title = name
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), landscapeImagePhone: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(handleSideMenu))
        mainView.mainCollectionView.delegate = self
        mainView.mainCollectionView.dataSource = self
        setupSideMenu()
        view.addSubview(act)
        act.fillSuperviewSafeArea()
        getCat()
    }
    
}
