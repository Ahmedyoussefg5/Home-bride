//
//  ViewController.swift
//  Tanta Services
//
//  Created by Youssef on 11/21/18.
//  Copyright © 2018 Tantaservices. All rights reserved.
//

import UIKit
import SideMenu

class UserTabBarController: UITabBarController {

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
        
        setupNavBarApperance(title: "", addImageTitle: ya, showNotifButton: no)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), landscapeImagePhone: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(handleSideMenu))
        setupSideMenu()
        

        let homeViewController =    HomeNewReqViewController()
        let subCatViewController =  SubCatViewController(id: id)
        let profileViewController = ProfileViewController()
        let chatHomeViewController = ChatHomeViewController()
        
        homeViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "format-list-bulleted (1)4"), selectedImage: #imageLiteral(resourceName: "format-list-bulleted (1)4"))
        subCatViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "couple-users-silhouette"), selectedImage: #imageLiteral(resourceName: "couple-users-silhouette"))
        profileViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "profile (1)9"), selectedImage: #imageLiteral(resourceName: "profile (1)9"))
        chatHomeViewController.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "message-text-outline (3)"), selectedImage: #imageLiteral(resourceName: "message-text-outline (3)"))
        
        let tabBarList = [chatHomeViewController, subCatViewController, homeViewController, profileViewController]
        viewControllers = tabBarList
        
        tabBar.tintColor = mediumPurple
        
        selectedViewController = tabBarList[1]
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTabBarToProfileVC), name: toProfileVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTabBarHomeVC), name: toHomeVC, object: nil)
    }

    @objc func handleTabBarToProfileVC () {
        selectedViewController = viewControllers?[0]
    }
    
    @objc func handleTabBarHomeVC () {
        navigationController?.popToRootViewController(animated: ya)
    }
}
