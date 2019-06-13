//
//  ViewController.swift
//  Tanta Services
//
//  Created by Youssef on 11/21/18.
//  Copyright © 2018 Tantaservices. All rights reserved.
//

import UIKit
import SideMenu

class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        setupNavBarApperance(title: "", addImageTitle: no, showNotifButton: no)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), landscapeImagePhone: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(handleSideMenu))
        setupSideMenu()
        
        let timeTableViewController = UINavigationController(rootViewController: TimeTableViewController())
        let homeViewController = UINavigationController(rootViewController: HomeNewReqViewController())
        let galaryViewController = UINavigationController(rootViewController: GalaryViewController())
        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        let chatHomeViewController = UINavigationController(rootViewController: ChatHomeViewController())
        
        homeViewController.tabBarItem = UITabBarItem(title: "سجل الطلبات", image: #imageLiteral(resourceName: "format-list-bulleted (1)4"), selectedImage: #imageLiteral(resourceName: "format-list-bulleted (1)4"))
        galaryViewController.tabBarItem = UITabBarItem(title: "المعرض", image: #imageLiteral(resourceName: "Forma 1 copy 25 (2)"), selectedImage: #imageLiteral(resourceName: "Forma 1 copy 25 (2)"))
        profileViewController.tabBarItem = UITabBarItem(title: "الملف الشخصي", image: #imageLiteral(resourceName: "profile (1)9"), selectedImage: #imageLiteral(resourceName: "profile (1)9"))
        chatHomeViewController.tabBarItem = UITabBarItem(title: "سجل المحادثات", image: #imageLiteral(resourceName: "message-text-outline (3)"), selectedImage: #imageLiteral(resourceName: "message-text-outline (3)"))
        timeTableViewController.tabBarItem = UITabBarItem(title: "المواعيد", image: #imageLiteral(resourceName: "alarm-clock (5)"), selectedImage: #imageLiteral(resourceName: "alarm-clock (5)"))
        
        //tabBarController?.selectedViewController = homeViewController
        
        let tabBarList = [profileViewController, homeViewController, galaryViewController, timeTableViewController, chatHomeViewController]
        viewControllers = tabBarList
        
        tabBar.tintColor = mediumPurple

//        selectedViewController = tabBarList[2]
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTabBarToProfileVC), name: toProfileVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTabBarHomeVC), name: toHomeVC, object: nil)
    }

    @objc func handleTabBarToProfileVC () {
        selectedViewController = viewControllers?[0]
    }
    
    @objc func handleTabBarHomeVC () {
        selectedViewController = viewControllers?[1]
    }
}

extension UINavigationBar
{
    /// Applies a background gradient with the given colors
    func apply(gradient colors : [UIColor]) {
        var frameAndStatusBar: CGRect = self.bounds
        frameAndStatusBar.size.height += 20 // add 20 to account for the status bar
        
        setBackgroundImage(UINavigationBar.gradient(size: frameAndStatusBar.size, colors: colors), for: .default)
    }
    
    /// Creates a gradient image with the given settings
    static func gradient(size : CGSize, colors : [UIColor]) -> UIImage?
    {
        // Turn the colors into CGColors
        let cgcolors = colors.map { $0.cgColor }
        
        // Begin the graphics context
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        
        // If no context was retrieved, then it failed
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // From now on, the context gets ended if any return happens
        defer { UIGraphicsEndImageContext() }
        
        // Create the Coregraphics gradient
        var locations : [CGFloat] = [0.0, 1.0]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: &locations) else { return nil }
        
        // Draw the gradient
        context.drawLinearGradient(gradient, start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: size.width, y: 0.0), options: [])
        
        // Generate the image (the defer takes care of closing the context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
