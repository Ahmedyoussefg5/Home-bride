//
//  NotificationCenter.swift
//  Gawla
//
//  Created by Youssef on 2/5/19.
//  Copyright © 2019 ITGeeKs. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let didReciveResponseFromUserForRemoteNotificationOpenAllNotifications = Notification.Name("DidReciveRemoteNotificationOpenAllSalonsGawla")
    static let applicationDidBecomeActive = Notification.Name("ApplicationDidBecomeActiveGawla")
    static let changeNotificationIcon = Notification.Name("ChangeNotificationIcon")
    static let userJoinedSalon = Notification.Name("UserJoinedSalon")
    static let newSalonAdded = Notification.Name("NewSalonAdded")
    static let refreshHomeSalons = Notification.Name("RefreshHomeSalons")
    static let popProviderProfile = Notification.Name("PopProviderProfile")
    static let didReciveMessage = Notification.Name("DidReciveMessage")
}
