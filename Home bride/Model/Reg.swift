//
//  Reg.swift
//  Home bride
//
//  Created by Youssef on 4/27/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import Foundation
// To parse the JSON, add this file to your project and do:
//
//   let allSalonsData = try? newJSONDecoder().decode(AllSalonsData.self, from: jsonData)

import Foundation

struct RegisterModel: BaseCodable {
    var status: Int
    var msg: String?
    let data: UserData?
}

struct UserData: Codable {
    let id: Int
    let firstName, lastName, email, phone: String
    let role: String
    let isVerified: Int
    let image: String
    let social: Social
    let birthDate, gender, job: String
    let location: Locationn?
    let deliveryRate: String?
    let subCategoryID: Int?
    let categoryName, subCategoryName: String?
    let regionID: Int?
    let info: String?
    let token: String
    let isOnline: Bool?
    let activityType: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email, phone, role
        case isVerified = "is_verified"
        case image, social
        case birthDate = "birth_date"
        case gender, job, location
        case deliveryRate = "delivery_rate"
        case subCategoryID = "sub_category_id"
        case categoryName = "category_name"
        case subCategoryName = "sub_category_name"
        case regionID = "region_id"
        case info, token
        case isOnline = "is_online"
        case activityType = "activity_type"
    }
}
struct Locationn: Codable {
    let lat, lng: String?
}
struct Social: Codable {
    let facebookLink, instagramLink, snapchatLink, twitterLink: String?
    
    enum CodingKeys: String, CodingKey {
        case facebookLink = "facebook_link"
        case instagramLink = "instagram_link"
        case snapchatLink = "snapchat_link"
        case twitterLink = "twitter_link"
    }
}
