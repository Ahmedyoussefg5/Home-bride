//
//  extension UIFont.swift
//  Gawla
//
//  Created by Youssef on 1/23/19.
//  Copyright © 2019 ITGeeKs. All rights reserved.
//

import UIKit

// Text styles
extension UIFont {
    static func CairoRegular(of size: CGFloat) -> UIFont {
        return UIFont(name: "Cairo-Regular", size: size)!
    }
    static func CairoSemiBold(of size: CGFloat) -> UIFont {
        return UIFont(name: "Cairo-SemiBold", size: size)!
    }
    static func CairoBold(of size: CGFloat) -> UIFont {
        return UIFont(name: "Cairo-Bold", size: size)!
    }
    
    /// Font as bold font
    public var bold: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitBold)!, size: 0)
    }
    
    /// Font as italic font
    public var italic: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitItalic)!, size: 0)
    }
    
    /// Font as monospaced font
    ///
    ///     UIFont.preferredFont(forTextStyle: .body).monospaced
    ///
    public var monospaced: UIFont {
        let settings = [[UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType, UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector]]
        
        let attributes = [UIFontDescriptor.AttributeName.featureSettings: settings]
        let newDescriptor = fontDescriptor.addingAttributes(attributes)
        return UIFont(descriptor: newDescriptor, size: 0)
    }
}
