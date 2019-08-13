//
//  HomeNewReqViewController.swift
//  Home bride
//
//  Created by Youssef on 4/20/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class TimeTableView: BaseView {
    
    lazy var mainTableView: UITableView = {
        let tableV = UITableView()
        tableV.allowsSelection = false
        tableV.applySketchShadow()
        
        tableV.backgroundColor = .clear
        tableV.isOpaque = false
        tableV.backgroundView = nil
        tableV.tableFooterView = UIView()
        tableV.separatorColor = mediumPurple
        tableV.translatesAutoresizingMaskIntoConstraints = false
        tableV.register(TimeTableTableCell.self, forCellReuseIdentifier: "TimeTableTableCell")
        return tableV
    }()
    
    override func setupView() {
        super.setupView()
        
        backgroundColor = #colorLiteral(red: 0.9371561408, green: 0.9373133779, blue: 0.9371339679, alpha: 1)
        
        addSubview(mainTableView)
        mainTableView.centerXInSuperview()
        mainTableView.topAnchorSuperView()
        mainTableView.widthAnchorWithMultiplier(multiplier: 0.9)
        mainTableView.bottomAnchorSuperView(constant: 0)
    }
}

enum Selection {
    case date
    case from
    case to
}

class TimeTableViewController: BaseUIViewController<TimeTableView>, UITableViewDelegate, UITableViewDataSource, TimeTableButtonSelect, SendResult {
    
    var selectionType = Selection.date
    
    func result(name: String) {
        guard var internalSchedule = internalSchedule else { return }
        
        if selectionType == .date {
            internalSchedule.date = name
            addTimeTableView.dayButton.setTitleNormalState(name)
        } else if selectionType == .from {
            internalSchedule.from = name
            addTimeTableView.fromButton.setTitleNormalState(name)
        } else if selectionType == .to {
            internalSchedule.to = name
            addTimeTableView.toButton.setTitleNormalState(name)
        }
    }
    
    func selectDay() {
        selectionType = .date
        
        let vc = PickerViewController(itemsToShow: ["السبت", "الاحد", "الاثنين", "الثلاثاء", "الاربعاء", "الخميس", "الجمعه"])
        vc.delegate = self
        presentModelyVC(vc: vc)
    }
    
    func selectFrom() {
        selectionType = .from
        
        let vc = DatePickerViewController(mode: .time)
        vc.delegate = self
        presentModelyVC(vc: vc)
    }
    
    func selectTo() {
        selectionType = .to
        
        let vc = DatePickerViewController(mode: .time)
        vc.delegate = self
        presentModelyVC(vc: vc)
    }
    
    func save() {
        addTime.toggle()
    }
    
    var allSchedules: AllSchedules? {
        didSet {
            mainView.mainTableView.reloadData()
        }
    }
    

    
    var internalSchedule: InternalSchedule?
    
    private func addTimeToServer() {
        guard let internalSchedule = internalSchedule else { return }
        
        [internalSchedule.date, internalSchedule.to, internalSchedule.from].forEach { (item) in
            if item == "" {
                self.internalSchedule = nil
                return
            }
        }
        
        let enu = ["السبت", "الاحد", "الاثنين", "الثلاثاء", "الاربعاء", "الخميس", "الجمعه"].enumerated()
        for (ind, key) in enu {
            if internalSchedule.date == key {
                internalSchedule.day = "\(ind)"
            }
        }
        let url = "http://homebride-sa.com/api/schedules"
        let pars: [String : Any] = [
            "from": internalSchedule.from,
            "to"  : internalSchedule.to,
            "date": internalSchedule.day
            ]
        
        callApi(AddTime.self, url: url, parameters: pars) { (data) in
            if data != nil {
                self.getData()
            }
        }
    }
    
    var currentPage = 1
    var lastPage = 2
    var isLoading = true
    private func getData() {
        let url = "http://homebride-sa.com/api/schedules"
        callApi(AllSchedules.self, url: url, method: .get, parameters: nil) { (data) in
            if let data = data {
                self.allSchedules = data
                self.lastPage = data.data?.paginate.totalPages ?? 1
                self.currentPage = 1
                self.isLoading = false
            }
        }
    }
    
    private func paginate() {
        
        guard !isLoading else { return }
        guard lastPage > currentPage else { return }
        isLoading = true

        let url = "http://homebride-sa.com/api/schedules?page=\(currentPage + 1)"
        callApi(AllSchedules.self, url: url, method: .get, parameters: nil) { (data) in
            if let data = data {
                self.allSchedules?.data?.schedules.append(contentsOf: data.data?.schedules ?? [])
                self.currentPage += 1
                self.isLoading = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        internalSchedule = InternalSchedule(date: "", from: "", to: "")
        setupNavBarApperance(title: "", addImageTitle: ya, showNotifButton: no)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), landscapeImagePhone: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(handleSideMenu))
        setupSideMenu()
        mainView.mainTableView.delegate = self
        mainView.mainTableView.dataSource = self
        getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
    }
    
    private lazy var addButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("اضافة ميعاد  +", for: .normal)
        btn.contentHorizontalAlignment = .trailing
        btn.setTitleColor(lightPurple, for: .normal)
        btn.titleLabel?.font = .CairoSemiBold(of: 15)
        btn.titleLabel?.underline()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTheTarget(action: {
            self.addTime = !self.addTime
        })
        return btn
    }()
    
    var addTime: Bool = false {
        didSet {
            mainView.mainTableView.reloadData()
            if addTime {
                mainView.mainTableView.scrollToBottom(animated: false)
            } else {
                addTimeToServer()
            }
        }
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
    
    lazy var addTimeTableView = AddTimeTableView()
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if addTime {
            addTimeTableView.delegate = self
            return addTimeTableView
        }
        return addButton
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = allSchedules?.data?.schedules.count ?? -1
        if indexPath.row == count - 1 {
            paginate()
        }
        let rotationAngle = 90.0 * CGFloat(Double.pi/50)
        let transform = CATransform3DMakeRotation(rotationAngle, 0, 0, 1)
        //        let transform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0)
        cell.layer.transform = transform
        
        UIView.animate(withDuration: 0.3) {
            cell.layer.transform = CATransform3DIdentity
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if addTime {
            return 230
        }
        return 70
    }
}


// MARK: - Your Cell

class TimeTableTableCell: UITableViewCell {
    
    private lazy var dayLable: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "السبت"
        label.textAlignment = .center
        label.font = .CairoSemiBold(of: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var fromLable: UILabel = {
        let label = UILabel()
        label.textColor = lightPurple
        label.text = "من"
        label.textAlignment = .right
        label.font = .CairoSemiBold(of: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var toLable: UILabel = {
        let label = UILabel()
        label.textColor = lightPurple
        label.text = "الى"
        label.textAlignment = .right
        label.font = .CairoSemiBold(of: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var fromValueLable: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "34:34"
        label.textAlignment = .right
        label.font = .CairoSemiBold(of: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var toValueLable: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "12:12"
        label.textAlignment = .right
        label.font = .CairoSemiBold(of: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupCell()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setupCell() {
        contentView.viewCornerRadius = 5
        contentView.addSubview(dayLable)
        dayLable.topAnchorSuperView(constant: 7)
        dayLable.centerXInSuperview()
        
        let stack = UIStackView(arrangedSubviews: [toLable, fromLable])
        stack.axis = h
        stack.distribution = .fillEqually
        stack.spacing = 10
        contentView.addSubview(stack)
        stack.centerXInSuperview()
        stack.widthAnchorWithMultiplier(multiplier: 0.9)
        stack.topAnchorToView(anchor: dayLable.bottomAnchor, constant: 10)
        stack.heightAnchorConstant(constant: 20)
        
        let stackk = UIStackView(arrangedSubviews: [toValueLable, fromValueLable])
        stackk.axis = h
        stackk.distribution = .fillEqually
        stackk.spacing = 10
        contentView.addSubview(stackk)
        stackk.centerXInSuperview()
        stackk.widthAnchorWithMultiplier(multiplier: 0.9)
        stackk.topAnchorToView(anchor: stack.bottomAnchor, constant: 4)
        stackk.heightAnchorConstant(constant: 20)
    }
    
    // MARK: - ConfigurableCell
    func configure(_ item: Schedule) {
        fromValueLable.text = item.from
        toValueLable.text = item.to
        dayLable.text = item.iosDate
        
    }
}

protocol TimeTableButtonSelect: class {
    func selectDay()
    func selectFrom()
    func selectTo()
    func save()
}

class AddTimeTableView: UIView {
    lazy var dayButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("اليوم", for: .normal)
        btn.contentHorizontalAlignment = .trailing
        btn.setTitleColor(.gray, for: .normal)
        btn.addBottomLine()
        btn.backgroundColor = #colorLiteral(red: 0.9371561408, green: 0.9373133779, blue: 0.9371339679, alpha: 1)
        btn.titleLabel?.font = .CairoSemiBold(of: 15)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTheTarget(action: {[weak self] in
            self?.delegate?.selectDay()
        })
        return btn
    }()
    
    lazy var fromButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("من", for: .normal)
        btn.contentHorizontalAlignment = .trailing
        btn.setTitleColor(.gray, for: .normal)
        btn.addBottomLine()
        btn.backgroundColor = #colorLiteral(red: 0.9371561408, green: 0.9373133779, blue: 0.9371339679, alpha: 1)
        btn.titleLabel?.font = .CairoSemiBold(of: 15)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTheTarget(action: {[weak self] in
            self?.delegate?.selectFrom()
        })
        return btn
    }()
    
    lazy var toButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("الى", for: .normal)
        btn.contentHorizontalAlignment = .trailing
        btn.setTitleColor(.gray, for: .normal)
        btn.addBottomLine()
        btn.backgroundColor = #colorLiteral(red: 0.9371561408, green: 0.9373133779, blue: 0.9371339679, alpha: 1)
        btn.titleLabel?.font = .CairoSemiBold(of: 15)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTheTarget(action: {[weak self] in
            self?.delegate?.selectTo()
        })
        return btn
    }()
    
    private lazy var saveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("تم", for: .normal)
        btn.contentHorizontalAlignment = .center
        btn.setTitleColor(.white, for: .normal)
        btn.addBottomLine()
        btn.backgroundColor = #colorLiteral(red: 0.9285544753, green: 0.3886299729, blue: 0.6461874247, alpha: 1)
        btn.viewCornerRadius = 14
        btn.titleLabel?.font = .CairoSemiBold(of: 15)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTheTarget(action: {[weak self] in
            self?.delegate?.save()
        })
        return btn
    }()
    
    weak var delegate: TimeTableButtonSelect?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.9371561408, green: 0.9373133779, blue: 0.9371339679, alpha: 1)
        
        let lable = UILabel()
        lable.text = "اضافة ميعاد"
        lable.font = UIFont.CairoBold(of: 14)
        lable.textAlignment = .right
        let stack = UIStackView(arrangedSubviews: [lable, dayButton, fromButton, toButton])
        stack.axis = v
        stack.distribution = .fillEqually
        stack.spacing = 5
        addSubview(stack)
        stack.centerXInSuperview()
        stack.topAnchorSuperView(constant: 5)
        stack.widthAnchorWithMultiplier(multiplier: 1)
        stack.heightAnchorConstant(constant: 160)
        
        addSubview(saveButton)
        saveButton.centerXInSuperview()
        saveButton.widthAnchorWithMultiplier(multiplier: 0.5)
        saveButton.heightAnchorConstant(constant: 40)
        saveButton.topAnchorToView(anchor: stack.bottomAnchor, constant: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIButton {
    func addBottomLine() {
        let selectionView = UIView()
        addSubview(selectionView)
        selectionView.backgroundColor = #colorLiteral(red: 0.8116784692, green: 0.8118157983, blue: 0.8116590977, alpha: 1)
        selectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = ya
        selectionView.centerXInSuperview()
        selectionView.widthAnchorWithMultiplier(multiplier: 0.9)
        selectionView.heightAnchorConstant(constant: 0.8)
    }
}

//
struct AllSchedules: BaseCodable {
    var status: Int
    var msg: String?
    var data: schedules?
}

struct schedules: Codable {
    var schedules: [Schedule]
    let paginate: Paginate
}

struct Paginate: Codable {
    let total, count, perPage: Int
    //    let nextPageURL, prevPageURL: String?
    let currentPage, totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case total, count
        case perPage = "per_page"
        //        case nextPageURL = "next_page_url"
        //        case prevPageURL = "prev_page_url"
        case currentPage = "current_page"
        case totalPages = "total_pages"
    }
}

struct Schedule: Codable {
    let id: Int
    let date, iosDate, from, to: String
    
    enum CodingKeys: String, CodingKey {
        case id, date
        case iosDate = "ios_date"
        case from, to
    }
}

class InternalSchedule {
    var date, from, to: String
    var day = "0"
    
    init(date: String, from: String, to: String) {
        self.date = date
        self.from = from
        self.to  = to
    }
}


struct AddTime: BaseCodable {
    var status: Int
    
    var msg: String?
    
    let data: Schedule
}

//struct Time: Codable {
//    let id: Int
//    let date, iosDate, from, to: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, date
//        case iosDate = "ios_date"
//        case from, to
//    }
//}
