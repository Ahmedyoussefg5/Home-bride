//
//  HomeNewReqViewController.swift
//  Home bride
//
//  Created by Youssef on 4/20/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class AllCatViewController: BaseUIViewController<AllCatView>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCatCell", for: indexPath) as! SubCatCell
        cell.configCell(categories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(SubCatViewController(id: categories[indexPath.row].id, name: categories[indexPath.row].name), animated: ya)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.48, height: collectionView.frame.width * 0.48)
    }
    
//    var id: Int
    private var categories = [Categories]() {
        didSet {
            mainView.mainCollectionView.reloadData()
        }
    }
    
    let act = UIActivityIndicatorView(style: .whiteLarge)
    
    private func getAllcategories() {
        act.color = mediumPurple
        let url = "http://m4a8el.panorama-q.com/api/categories"
        
        callApi(AllCategories.self, url: url, method: .get, parameters: nil, shouldShowAlert: ya, activityIndicator: act) {[weak self] (data) in
            if let data = data {
                self?.categories = data.data
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarApperance(title: "", addImageTitle: ya, showNotifButton: no)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), landscapeImagePhone: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(handleSideMenu))
        mainView.mainCollectionView.delegate = self
        mainView.mainCollectionView.dataSource = self
        setupSideMenu()
        view.addSubview(act)
        act.fillSuperviewSafeArea()
        getAllcategories()
    }
    
    var id: Int?
    var name: String?

    init(id: Int?, name: String?) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let id = id, first {//, let name = name {
            navigationController?.pushViewController(SubCatViewController(id: id, name: name ?? ""), animated: ya)
            first = no
        }
    }
    
    var first = ya
}
