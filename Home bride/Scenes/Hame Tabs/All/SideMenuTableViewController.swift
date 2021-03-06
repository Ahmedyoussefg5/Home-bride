//
//  SideMenuTableViewController.swift
//  Tanta Services
//
//  Created by Youssef on 11/22/18.
//  Copyright © 2018 Tantaservices. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuTableViewController: UITableViewController {
    
    func tableConfiger() {
        tableView.backgroundColor = #colorLiteral(red: 0.9998950362, green: 1, blue: 0.9998714328, alpha: 1)
        tableView.isOpaque = false
        tableView.backgroundView = nil
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        tableView.separatorInset = .zero
        tableView.contentInset = .zero
        tableView.separatorColor = .clear
        tableView.register(UITableViewVibrantCell.self, forCellReuseIdentifier: "sideMenuCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableConfiger()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if user == p {
            tableViewItems = ["الملف الشخصي", "الاشعارات", "سجل الطلبات", "الشروط والاحكام", "عن التطبيق", "تواصل معنا", "تسجيل خروج"]
        } else {
            tableViewItems = ["الرئيسية", "الملف الشخصي", "الاشعارات", "سجل الطلبات", "الاعدادات", "الشروط والاحكام", "عن التطبيق", "تواصل معنا", "تسجيل خروج"]
        }
        tableView.reloadData()
    }
    
    var tableViewItems = [String]()
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 4 { return 0 }
        return 45.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewItems.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 240.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SideMenuTableHeader(userName: AuthService.instance.userName ?? "", userImage: AuthService.instance.userImage ?? "")
    }
    lazy var switchView: UISwitch = {
        let switchV = UISwitch()
        switchV.onTintColor = #colorLiteral(red: 0.9209317565, green: 0.3846375644, blue: 0.6422777772, alpha: 1)
        switchV.translatesAutoresizingMaskIntoConstraints = false
        switchV.isOn = ya
        return switchV
    }()
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell", for: indexPath) as! UITableViewVibrantCell
        cell.backgroundColor = .clear
        if indexPath.row != 4 {
            cell.textLabel?.text = tableViewItems[indexPath.row]
        }
        cell.textLabel?.textColor = .darkGray
        cell.textLabel?.font = .CairoSemiBold(of: 14)
        cell.textLabel?.textAlignment = .right
        
        if user == p {
            if indexPath.row == 1 {
                cell.contentView.addSubview(switchView)
                switchView.leadingAnchorSuperView(constant: 5)
                switchView.centerYInSuperview()
            }
        } else {
            if indexPath.row == 2 {
                cell.contentView.addSubview(switchView)
                switchView.leadingAnchorSuperView(constant: 5)
                switchView.centerYInSuperview()
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        DispatchQueue.main.async {
//        }
        if user == p {
            switch indexPath.row {
            case 0:
                NotificationCenter.default.post(name: toProfileVC, object: nil)
                dismiss(animated: true, completion: nil)
            case 1:
                guard openedViewController != "NotificationsViewController" else {
                    dismiss(animated: true, completion: nil)
                    return }
                openedViewController = "NotificationsViewController"
                navigationController?.pushViewController(NotificationsViewController(), animated: ya)
            case 2:
                NotificationCenter.default.post(name: toHomeVC, object: nil)
                dismiss(animated: true, completion: nil)
            case 3:
                guard openedViewController != "TermsViewController" else {
                    dismiss(animated: true, completion: nil)
                    return }
                openedViewController = "TermsViewController"
                navigationController?.pushViewController(TermsViewController(), animated: ya)
            case 4:
                guard openedViewController != "TermsViewControllerr" else {
                    dismiss(animated: true, completion: nil)
                    return }
                openedViewController = "TermsViewControllerr"
                navigationController?.pushViewController(TermsViewControllerr(), animated: ya)
            case 5:
                guard openedViewController != "ContactViewController" else {
                    dismiss(animated: true, completion: nil)
                    return }
                openedViewController = "ContactViewController"
                navigationController?.pushViewController(ContactViewController(), animated: ya)
            case 6:
                AuthService.instance.restartAppAndRemoveUserDefaults()
                dismiss(animated: true, completion: nil)
            default:
                return
            }
        } else {
            switch indexPath.row {
            case 0:
                NotificationCenter.default.post(name: toHomeVC, object: nil)
                dismiss(animated: true, completion: nil)
                return
            case 1:
                guard openedViewController != "UserProfileViewController" else {
                    dismiss(animated: true, completion: nil)
                    return }
                openedViewController = "UserProfileViewController"
                navigationController?.pushViewController(UserProfileViewController(), animated: ya)
            case 2:
                guard openedViewController != "NotificationsViewController" else {
                    dismiss(animated: true, completion: nil)
                    return }
                openedViewController = "NotificationsViewController"
                navigationController?.pushViewController(NotificationsViewController(), animated: ya)
                return
            case 3:
                guard openedViewController != "HomeNewReqViewController" else {
                    dismiss(animated: true, completion: nil)
                    return }
                openedViewController = "HomeNewReqViewController"
                navigationController?.pushViewController(HomeNewReqViewController(), animated: ya)
            case 5:
                guard openedViewController != "TermsViewController" else {
                    dismiss(animated: true, completion: nil)
                    return }
                openedViewController = "TermsViewController"
                navigationController?.pushViewController(TermsViewController(), animated: ya)
            case 6:
                guard openedViewController != "TermsViewControllerr" else {
                    dismiss(animated: true, completion: nil)
                    return }
                openedViewController = "TermsViewControllerr"
                navigationController?.pushViewController(TermsViewControllerr(), animated: ya)
            case 7:
                guard openedViewController != "ContactViewController" else {
                    dismiss(animated: true, completion: nil)
                    return }
                openedViewController = "ContactViewController"
                navigationController?.pushViewController(ContactViewController(), animated: ya)
            case 8:
                AuthService.instance.restartAppAndRemoveUserDefaults()
                dismiss(animated: true, completion: nil)
            default:
                return
            }
        }

    }
}

class SideMenuTableHeader: UIView {
    private lazy var userImage: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
//        img.image = #imageLiteral(resourceName: "facebook")
        img.viewCornerRadius = 30
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    private lazy var userName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .CairoBold(of: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var userTypeName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .CairoSemiBold(of: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var curvedView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.insertSublayer(gradientLayer, at: 0)
        return view
    }()
    lazy var gradientLayer = LinearGradientLayer(colors: [mediumPurple, lightPurple])

    init(userName: String, userImage: String) {
        super.init(frame: .zero)
        setupView()
        self.userName.text = userName
        self.userImage.load(with: userImage)
    }; required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func setupView() {
        addSubview(curvedView)
        curvedView.fillSuperview()
        addSubview(userImage)
        ActivateConstraint([
            userImage.heightAnchor.constraint(equalToConstant: 80),
            userImage.widthAnchor.constraint(equalToConstant: 80),
            userImage.topAnchorSuperView(constant: 20),
            userImage.centerXInSuperview()
            ])
        addSubview(userName)
        ActivateConstraint([
            userName.centerXAnchor.constraint(equalTo: centerXAnchor),
            userName.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 7)
            ])
        
        addSubview(userTypeName)
        ActivateConstraint([
            userTypeName.centerXAnchor.constraint(equalTo: centerXAnchor),
            userTypeName.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 3)
            ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = curvedView.bounds
    }
}

