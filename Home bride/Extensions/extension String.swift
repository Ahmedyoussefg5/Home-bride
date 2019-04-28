//
//  StringExtension.swift
//  Motor Sports
//
//  Created by Youssef on 1/31/17.
//  Copyright © 2017 Youssef. All rights reserved.
//

import UIKit

extension String {
    
    var trimmedString: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var removeTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }
    
    var filterAsURL: String {
        return self.replacingOccurrences(of: "\\", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }
    
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.trimmedString)
    }
    
    var localize: String {
        return NSLocalizedString(self, comment: "Hello From String Extension")
    }
    
    var isInt: Bool {
        return Int(self) != nil
    }
    
    var toInt: Int? {
        return Int(self)
    }
    
    func replacingOccurrences(of search: String, with replacement: String, count maxReplacements: Int) -> String {
        var count = 0
        var returnValue = self
        
        while let range = returnValue.range(of: search) {
            returnValue = returnValue.replacingCharacters(in: range, with: replacement)
            count += 1
            
            // exit as soon as we've made all replacements
            if count == maxReplacements {
                return returnValue
            }
        }
        
        return returnValue
    }
    
    func truncate(to length: Int, addEllipsis: Bool = false) -> String  {
        if length > count { return self }
        
        let endPosition = self.index(self.startIndex, offsetBy: length)
        let trimmed = self[..<endPosition]
        
        if addEllipsis {
            return "\(trimmed)..."
        } else {
            return String(trimmed)
        }
    }
}

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}
extension Substring {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}

extension NSMutableAttributedString {
    
//    func setupAttriutedLable(texts: [String], fonts: [UIFont], colors: [UIColor]) -> NSAttributedString {
//        // multi line enable
//        //* planOne.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
//
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.alignment = .center
//
//        let output = NSMutableAttributedString.init(string: texts.first?.localize ?? "", attributes: [.foregroundColor: colors.first ?? .black, .font: fonts.first ?? .systemFont(ofSize: 10), .paragraphStyle: paragraphStyle])
//        guard texts.count > 1, texts.count == fonts.count, texts.count == colors.count else { return output }
//        for index in texts.indices.dropFirst() {
//            let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: colors[index], .font: fonts[index], .paragraphStyle: paragraphStyle]
//            output.append(NSAttributedString(string: texts[index].localize, attributes: attributes))
//        }
//        return output
//    }
    
    convenience init(texts: [String], fonts: [UIFont], colors: [UIColor], alignment: NSTextAlignment = .center) {
        //* planOne.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        
        self.init(string: texts.first ?? "", attributes: [.foregroundColor: colors.first ?? .black, .font: fonts.first ?? .systemFont(ofSize: 10), .paragraphStyle: paragraphStyle])
        
        guard texts.count > 1 else { return }
        guard texts.count == fonts.count else { return }
        guard fonts.count == colors.count else { return }
        
        for index in texts.indices.dropFirst() {
            let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: colors[index], .font: fonts[index], .paragraphStyle: paragraphStyle]
            append(NSAttributedString(string: texts[index], attributes: attributes))
        }
    }
}
