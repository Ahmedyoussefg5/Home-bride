//
//  AppLanguage.swift
//  Gawla
//
//  Created by Youssef on 12/30/18.
//  Copyright © 2018 ITGeeKs. All rights reserved.
//

import Foundation
//import MOLH

final class AppMainLang {
    private init() { }
    static var appMainLang: String {
        get {
            // Locale.current not changed after change lang
            // return Locale.current.languageCode ?? "en"
            let userdef = UserDefaults.standard
            let langArray = userdef.object(forKey: "AppleLanguages") as! NSArray
            let current = langArray.firstObject as! String
            let endIndex = current.index(current.startIndex, offsetBy: 2)
            let currentWithoutLocale = current[current.startIndex..<endIndex]
            return String(currentWithoutLocale)
        }
    }
    
    static func isRTLLanguage(language: String = appMainLang) -> Bool {
        return language.hasPrefix("ar") || language.hasPrefix("fa")
    }
}
