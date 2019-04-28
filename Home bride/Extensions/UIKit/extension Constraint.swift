//
//  File.swift
//  Gawla
//
//  Created by Youssef on 11/6/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem as Any,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = shouldBeArchived
        newConstraint.identifier = identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}

extension UIView {
    
    //    func fillSuperview() {
    //        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    //    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchorSizeWithConstantAndMultiplier(to view: UIView, constant: CGFloat, multiplier: CGFloat) {
        widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier, constant: constant).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier, constant: constant).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func anchorWithCenterXY(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, centerX: NSLayoutXAxisAnchor? ,centerY: NSLayoutYAxisAnchor? ,padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}

// Reference Video: https://youtu.be/iqpAP7s3b-8
extension UIView {
    
    //    @discardableResult
    //    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
    //
    //        translatesAutoresizingMaskIntoConstraints = false
    //        var anchoredConstraints = AnchoredConstraints()
    //
    //        if let top = top {
    //            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
    //        }
    //
    //        if let leading = leading {
    //            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
    //        }
    //
    //        if let bottom = bottom {
    //            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
    //        }
    //
    //        if let trailing = trailing {
    //            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
    //        }
    //
    //        if size.width != 0 {
    //            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
    //        }
    //
    //        if size.height != 0 {
    //            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
    //        }
    //
    //        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
    //
    //        return anchoredConstraints
    //    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func fillSuperviewSafeArea(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.topAnchor, constant: padding.top).isActive = true
        bottomAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.bottomAnchor, constant: -padding.bottom).isActive = true
        leadingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.leadingAnchor, constant: padding.left).isActive = true
        trailingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.trailingAnchor, constant: -padding.right).isActive = true
    }
    
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    @discardableResult
    func centerXInSuperview() -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constX = centerXAnchor.constraint(equalTo: (superview?.centerXAnchor)!)
        constX.isActive = true
        return constX
    }
    
    @discardableResult
    func centerYInSuperview() -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constY = centerYAnchor.constraint(equalTo: (superview?.centerYAnchor)!)
        constY.isActive = true
        return constY
    }
    
    @discardableResult
    func widthAnchorWithMultiplier(multiplier: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let consWidth = widthAnchor.constraint(equalTo: (superview?.widthAnchor)!, multiplier: multiplier)
        consWidth.isActive = true
        return consWidth
    }
    
    @discardableResult
    func heightAnchorWithMultiplier(multiplier: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let consWidth = heightAnchor.constraint(equalTo: (superview?.heightAnchor)!, multiplier: multiplier)
        consWidth.isActive = true
        return consWidth
    }
    
    @discardableResult
    func heightAnchorConstant(constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = heightAnchor.constraint(equalToConstant: constant)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func widthAnchorConstant(constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = widthAnchor.constraint(equalToConstant: constant)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func topAnchorSuperView(constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let consWidth = topAnchor.constraint(equalTo: (superview?.safeAreaLayoutGuide.topAnchor)!, constant: constant)
        consWidth.isActive = true
        return consWidth
    }
    
    @discardableResult
    func bottomAnchorSuperView(constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let consWidth = bottomAnchor.constraint(equalTo: (superview?.safeAreaLayoutGuide.bottomAnchor)!, constant: constant)
        consWidth.isActive = true
        return consWidth
    }
    
    @discardableResult
    func leadingAnchorSuperView(constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = leadingAnchor.constraint(equalTo: (superview?.leadingAnchor)!, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func leadingAnchorToTrailingSuperView(constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = leadingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func trailingAnchorAnchorSuperView(constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = trailingAnchor.constraint(equalTo: (superview?.trailingAnchor)!, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func trailingAnchorToLeadingSuperView(constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = leadingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func widthAnchorEqualHeightAnchor() -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = widthAnchor.constraint(equalTo: heightAnchor)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func heightAnchorEqualWidthAnchor() -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = heightAnchor.constraint(equalTo: widthAnchor)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func topAnchorToView(anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = topAnchor.constraint(equalTo: anchor, constant: constant)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func bottomAnchorToView(anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = bottomAnchor.constraint(equalTo: anchor, constant: constant)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func trailingAnchorToView(anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let cons = trailingAnchor.constraint(equalTo: anchor, constant: constant)
        cons.isActive = true
        return cons
    }
}

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

extension UIDevice {
    var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436
    }
    var iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    enum ScreenType: String {
        case iPhones_4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_X_XS = "iPhone X or iPhone XS"
        case iPhone_XR = "iPhone XR"
        case iPhone_XSMax = "iPhone XS Max"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhones_4_4S
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1792:
            return .iPhone_XR
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            return .iPhones_X_XS
        case 2688:
            return .iPhone_XSMax
        default:
            return .unknown
        }
    }
}
