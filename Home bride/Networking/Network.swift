//
//  Network.swift
//  Home bride
//
//  Created by Youssef on 4/26/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Network: NSObject {
    private override init() {
        super.init()
    }
    
    static let shared = Network()
    
    func getData<T: BaseCodable>(_ decoder: T.Type, url: String, parameters: [String:Any]?, method: HTTPMethod = .post, complation: ((_ error: String?, _ data: T?) -> Void)? = nil) {
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .responseJSON {
                (response) in
                
                guard let complation = complation else { return }
                print(method.rawValue)
                switch response.result {
                case .failure(let error):
                    debugPrint("failure", error)
                    if error.localizedDescription.contains("JSON") {
                        complation("Servar Error.".localize, nil)
                        return
                    }
                    complation(error.localizedDescription, nil)
                    return
                case .success(_):
                    guard let responseData = response.data
                        else {
                            complation(response.error?.localizedDescription ?? "Error".localize, nil)
                            return
                    }
                    
                    let json = JSON(response.value ?? [:])
                    print(json)
                    
                    do {
                        let data = try newJSONDecoder().decode(T.self, from: responseData)
                        complation(nil, data)
                    }
                    catch let error {
                        complation("Servar Error.".localize, nil)
                        debugPrint(error)
                    }
                    return
                }
        }
    }
    
    func uploadToServerWith<T: Codable>(_ decoder: T.Type, data: UploadData, url: String, method: HTTPMethod = .post, parameters: [String:Any]?, progress: ((Progress) -> Void)?, completion: ((_ error: String?, _ data: T?) -> Void)? = nil) {
        
        upload(multipartFormData: { (mal) in
            mal.append(data.data, withName: data.name, fileName: data.fileName, mimeType: data.mimeType)
            for (key, val) in parameters ?? [:] {
                mal.append("\(val)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url, method: method, headers: header) { (response) in
            
            switch response {
            
            case .success(let requestUp, _, _):
                //                guard let completion = completion else { return }
            
                requestUp.responseData(completionHandler: { (results) in
                    guard let responseData = results.data
                        else {
                            completion?(results.error?.localizedDescription ?? "Error".localize, nil)
                            return
                    }
            
                    let json = JSON(responseData)
                    print(json)
            
                    do {
                        let data = try newJSONDecoder().decode(T.self, from: responseData)
                        completion?(nil, data)
                    } catch let error {
                        completion?("Servar Error.".localize, nil)
                        debugPrint(error)
                    }
                    return
            
                }).responseString(completionHandler: { (string) in
                    //                    print(string.result.value)
                })
            
            case .failure(let error):
                completion?(error.localizedDescription, nil)
            }
        }
        
    }
}

struct UploadData {
    var data: Data
    var fileName, mimeType, name: String
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    return encoder
}

//
// JSONNull
//
class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

//
// UnknownType In The Model You Decode
//
enum UnknownType: Codable {
    
    case integer(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(UnknownType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ID"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
