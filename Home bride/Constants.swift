//
//  Constants.swift
//  Home bride
//
//  Created by Youssef on 4/26/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import Foundation

let toProfileVC = Notification.Name("toProfileVC")
let toHomeVC = Notification.Name("toHomeVC")

let BaseURL = URL(string: "http://m4a8el.panorama-q.com/api/auth/")!
var header = ["X-localization" : "ar",
    "Authorization" : "bearer \(AuthService.instance.authToken ?? "")"
]

enum UserType {
    case user
    case provider
}

let p = UserType.provider
let u = UserType.user

var user = u
