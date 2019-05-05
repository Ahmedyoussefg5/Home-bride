//
//  HomeNewReqViewController.swift
//  Home bride
//
//  Created by Youssef on 4/20/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class ProvGalaryViewController: BaseUIViewController<ProvGalaryView>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return dataSource?.count ?? 0
//            return dataSource?.videos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: GalaryCollCell.self, for: indexPath)
//        if mainView.selected == 0 {
            cell.configure(dataSource?[indexPath.row] ?? "", vid: no)
//        } else {
//            cell.configure(dataSource?.videos.video[indexPath.row].video ?? "", vid: ya)
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if mainView.selected == 1 {
//            let vc = UINavigationController(rootViewController: VideoPlayer(url: dataSource?.videos.video[indexPath.row].video ?? ""))
//            vc.navbarWithdismiss()
//            presentModelyVC(vc: vc)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.48, height: collectionView.frame.width * 0.48)
    }
    
    fileprivate var dataSource: [String]? {
        didSet {
            mainView.mainCollectionView.reloadData()
        }
    }
    
    fileprivate var id: Int

    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func getData() {
        let url = "http://m4a8el.panorama-q.com/api/galleries/\(id)"
        callApi(AllGalaryData.self, url: url, method: .get, parameters: nil, activityIndicator: act) {[weak self] (data) in
            if let data = data {
                self?.dataSource = data.data?.galleries.images.image.map({ $0.image })
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
