//
//  AppDelegate.swift
//  Home bride
//
//  Created by Youssef on 4/20/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.makeKeyAndVisible()
        print(AuthService.instance.authToken ?? "")

        IQKeyboardManager.shared.enable = true
//        IQKeyboardManager.shared.keyboardDistanceFromTextField = 20
        
        if AuthService.instance.userRole == "client" {
            user = u
        } else {
            user = p
        }
                
        if AuthService.instance.authToken == nil {
            window?.rootViewController = UINavigationController(rootViewController: WelcomeViewController())
        } else {
            if user == p {
                window?.rootViewController = HomeTabBarController()
            } else {
                window?.rootViewController = UINavigationController(rootViewController: UserHomeViewController())
            }
        }
        
//        window?.rootViewController = VerifyViewController(phone: "asd")
        
        registerForRemoteNotifications(app: application)
        
        return true
    }
}

