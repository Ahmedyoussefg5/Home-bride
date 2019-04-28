//
//  TableManger.swift
//  Awfr Client
//
//  Created by Youssef on 4/18/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class TableManager<T: BaseCodable>: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private weak var tableView: UITableView?
    private weak var tableHeight: NSLayoutConstraint?
    var dataSource: [T]? {
        didSet {
            tableView?.dataSource = self
            tableView?.delegate = self
            tableView?.reloadData()
        }
    }
    private var reuseId: String
    
    var didSelectAction: ((_ item: T)-> Void)?
    var dequeueCustomBehaviour: ((_ cell: UITableViewCell, _ index: Int)-> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(tableView: UITableView, tableHeight: NSLayoutConstraint?, cellClass: AnyClass) {
        
        self.tableView = tableView
        self.tableHeight = tableHeight
        self.reuseId = "String(describing: cellClass.self)"
        
        tableView.register(cellClass.self, forCellReuseIdentifier: reuseId)
//        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: reuseId)
    }
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! BaseCell<T>
        cell.setupCell(item: dataSource?[indexPath.row])
//        dequeueCustomBehaviour?(cell, indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
//        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
//        UIView.animate(withDuration: 0.4) {
//            cell.transform = CGAffineTransform.identity
//        }
//
//        if tableHeight != nil {
//            tableHeight?.constant = tableView.contentSize.height
//        }
        
//        if indexPath.row == dataSource!.count - 1 && links?.next != nil {
//            let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
//            spinner.startAnimating()
//            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
//
//            tableView.tableFooterView = spinner
//            tableView.tableFooterView?.isHidden = false
//
//            paginate()
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        didSelectAction?(dataSource![indexPath.row])
    }
    
//    private func paginate() {
//
//        AlamofireManager.paginate(fromLink: links!.next!, model: DataModel<[T]>.self).subscribe(onNext: { [weak self] data in
//            guard let newData = data?.data else {return}
//            self?.dataSource!.append(contentsOf: newData)
//            self?.links = data?.links
//            self?.tableView?.reloadData()
//            }, onError: { err in
//                print(err)
//        }, onCompleted: { [weak self] in
//            self?.tableView?.tableFooterView = nil
//            self?.tableView?.tableFooterView?.isHidden = true
//        }).disposed(by: disposeBag)
//
//    }
    
}

protocol TableManagerCell {
    func setupCell<T>(item: T)
}
