//
//  GalaryModels.swift
//  Home bride
//
//  Created by Youssef on 4/28/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import Foundation

struct AllGalaryData: BaseCodable {
    var status: Int
    var msg: String?
    let data: GalaryData?
}

struct GalaryData: Codable {
    let galleries: Galleries
}

struct Galleries: Codable {
    let images: Images
    let videos: Videos
}

struct Images: Codable {
    let image: [Image]
    let count: Int
}

struct Image: Codable {
    let id: Int
    let type: String
    let image: String
}

struct Videos: Codable {
    let video: [Video]
    let count: Int
}

struct Video: Codable {
    let id: Int
    let type: String
    let video: String
}

// add image model
struct AddImage: BaseCodable {
    var status: Int
    var msg: String?
    let data: ImageAdded?
}

struct ImageAdded: Codable {
    let id: Int
    let type: String
    let image: String
}

// add Vid model
struct AddVideo: BaseCodable {
    var status: Int
    var msg: String?
    let data: VideoAdded?
}

struct VideoAdded: Codable {
    let id: Int
    let type: String
    let video: String
}
