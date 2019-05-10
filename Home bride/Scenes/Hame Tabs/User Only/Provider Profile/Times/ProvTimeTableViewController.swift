//
//  HomeNewReqViewController.swift
//  Home bride
//
//  Created by Youssef on 4/20/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class ProvTimeTableView: BaseView {
    
    lazy var mainTableView: UITableView = {
        let tableV = UITableView()
        tableV.allowsSelection = false
        tableV.applySketchShadow()
        tableV.backgroundColor = .clear
        tableV.isOpaque = false
        tableV.backgroundView = nil
        tableV.tableFooterView = UIView()
//        tableV.separatorColor = mediumPurple
        tableV.translatesAutoresizingMaskIntoConstraints = false
        tableV.register(TimeTableTableCell.self, forCellReuseIdentifier: "TimeTableTableCell")
        return tableV
    }()
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.viewBorderWidth = 0.5
        view.viewBorderColor = #colorLiteral(red: 0.89402318, green: 0.8941735625, blue: 0.89400208, alpha: 1)
        view.backgroundColor = .white
        view.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.19), alpha: 1, x: 0, y: 3, blur: 2, spread: 0)
        return view
    }()
    override func setupView() {
        super.setupView()
        
        backgroundColor = .clear
        isUserInteractionEnabled = true

        addSubview(containerView)
        containerView.centerXInSuperview()
        containerView.centerYInSuperview()
        containerView.widthAnchorWithMultiplier(multiplier: 0.9)
        containerView.heightAnchorWithMultiplier(multiplier: 0.5)
        
        containerView.addSubview(mainTableView)
        mainTableView.fillSuperview()
    }
}

class ProvTimeTableViewController: BaseUIViewController<ProvTimeTableView>, UITableViewDelegate, UITableViewDataSource {
    
    var allSchedules: AllSchedules? {
        didSet {
            mainView.mainTableView.reloadData()
        }
    }
    
    private func getData() {
        let url = "http://m4a8el.panorama-q.com/api/schedules/\(id)"
        callApi(AllSchedules.self, url: url, method: .get, parameters: nil, activityIndicator: activ) { (data) in
            if let data = data {
                self.allSchedules = data
                self.lastPage = data.data?.paginate.totalPages ?? 1
                self.currentPage = 1
                self.isLoading = false
            }
        }
    }
    
    var currentPage = 1
    var lastPage = 2
    var isLoading = true
    private func paginate() {
        
        guard !isLoading else { return }
        guard lastPage > currentPage else { return }
        isLoading = true

        let url = "http://m4a8el.panorama-q.com/api/schedules?page=\(currentPage + 1)"
        callApi(AllSchedules.self, url: url, method: .get, parameters: nil) { (data) in
            if let data = data {
                self.allSchedules?.data?.schedules.append(contentsOf: data.data?.schedules ?? [])
                self.currentPage += 1
                self.isLoading = false
            }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.mainTableView.delegate = self
        mainView.mainTableView.dataSource = self
        getData()
        let dismissGeasture = UITapGestureRecognizer(target: self, action: #selector(dismissMePlease))
        mainView.addGestureRecognizer(dismissGeasture)
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeTableTableCell", for: indexPath) as! TimeTableTableCell
        if let data = allSchedules?.data?.schedules[indexPath.row] {
            cell.configure(data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSchedules?.data?.schedules.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = allSchedules?.data?.schedules.count ?? -1
        if indexPath.row == count - 1 {
            paginate()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if allSchedules?.data?.schedules.count ?? 0 == 0 {
            return 100
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let lab = UILabel()
        lab.text = "لا يوجد"
        lab.textAlignment = .center
        lab.font = UIFont.CairoSemiBold(of: 13)
        return lab
    }
}
