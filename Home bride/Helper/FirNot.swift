import Firebase
import FirebaseCore
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging

extension AppDelegate  {
    func registerForRemoteNotifications(app: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization( options: [.alert, .badge, .sound], completionHandler: {_, _ in})
        
        app.registerForRemoteNotifications()
    }
}

extension AppDelegate {
    
    func ConnectToFCM() {
        Messaging.messaging().shouldEstablishDirectChannel = true
        //let token = Messaging.messaging().fcmToken
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print("applicationWillResignActive")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("Application: DidEnterBackground")
        Messaging.messaging().shouldEstablishDirectChannel = false
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        NotificationCenter.default.post(.init(name: .applicationDidBecomeActive))
        print("applicationWillEnterForeground")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("applicationDidBecomeActive")
        ConnectToFCM()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // CrashLogger.log(error)
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //print("APNs token retrieved: \(deviceToken)")
        
        //var token = ""
        //for i in 0..<deviceToken.count {
        //  token = token + String(format: "%02.2hhx", arguments: [deviceToken[i]])
        //}
        //print("Notification: APNs token: \((deviceToken as NSData))")
        //print("Notification: APNs token retrieved: \(token)")
        // With swizzling disabled you must set the APNs token here.
        Messaging.messaging().apnsToken = deviceToken
    }
    
    //    func handlleFCM(userInfo: [AnyHashable: Any]){
    //
    //  if (userInfo["title"] != nil && userInfo["subtitle"] != nil) {
    //      let content = UNMutableNotificationContent()
    //      content.title = (userInfo["title"] as? String)!
    //      content.body = (userInfo["subtitle"] as? String)!
    //      content.sound = UNNotificationSound.default
    //      content.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
    //      content.setValue(true, forKey: "shouldPauseMedia")
    //
    //      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
    //      let notificationRequest = UNNotificationRequest(identifier: "aseel_Identifier", content: content, trigger: trigger)
    //      UNUserNotificationCenter.current().add(notificationRequest) { (error) in
    //          if let error = error {
    //              print(error)
    //          } else {
    //              print("scheduled")
    //          }
    //      }
    //  }
}

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        UIApplication.shared.applicationIconBadgeNumber += 1
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        //        if let messageID = userInfo[gcmMessageIDKey] {
        //            print("Message ID: \(messageID)")
        //        }
        
        // Print full message.
        print(userInfo)
        
        if let user = userInfo["aps"] {
            let users = user as? NSDictionary
            let alert = users?["alert"] as? NSDictionary
            
            if let messageBody = alert?["body"] as? String {
                print(messageBody)
                
                NotificationCenter.default.post(name: .didReciveMessage, object: nil)
            }
        }
        // let content = UNMutableNotificationContent()
        // content.title = (alert["title"] as? String)!
        // content.body = (alert["body"] as? String)!
        // content.sound = UNNotificationSound.default
        //  content.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
        //  content.setValue(true, forKey: "shouldPauseMedia")
        //  let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        // let notificationRequest = UNNotificationRequest(identifier: "\(arc4random())", content: content, trigger: trigger)
        // UNUserNotificationCenter.current().add(notificationRequest) { (error) in
        //            if let error = error {
        //                print(error)
        //            } else {
        //                print("scheduled")
        //            }
        //        }
        //    }
        
        //handlleFCM(userInfo: userInfo)
        //        if AuthService.instance.shouldShowNotifications {
        //            NotificationCenter.default.post(name: .changeNotificationIcon, object: nil, userInfo: nil)
        completionHandler([.alert, .badge, .sound])
        //        } else {
        //            completionHandler([.badge])
        //        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        //        let userInfo = response.notification.request.content.userInfo
        
        //Print message ID.
        //  if let messageID = userInfo[gcmMessageIDKey] {
        //      print("Message ID: \(messageID)")
        //  }
        //  Print full message.
        //  print(userInfo)
        //        if let user = userInfo["aps"] {
        //            if let users = user as? NSDictionary {
        //                let alert = users["alert"] as? NSDictionary
        ////                if showNotificationsViewController {
        ////                    NotificationCenter.default.post(name: .didReciveResponseFromUserForRemoteNotificationOpenAllNotifications, object: nil, userInfo: alert as? [AnyHashable : Any])
        ////                }
        //                print(alert as Any)
        //            }
        //        }
        
        //handlleFCM(userInfo: userInfo)
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        // Note: This callback is fired at each app startup and whenever a new token is generated.
        print("Firebase registration token: \(fcmToken)")
        Messaging.messaging().subscribe(toTopic: "all")
        
        Network.shared.getData(UpdateProfData.self, url: "http://m4a8el.panorama-q.com/api/user/update/profile", parameters: ["fcm_token_ios" : fcmToken], method: .post) { (message, data) in }
    }
    
    // [START ios_10_"data"_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
}

