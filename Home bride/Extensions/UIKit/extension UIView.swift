//
//  UIView+extension.swift
//  Gawla
//
//  Created by Youssef on 1/13/19.
//  Copyright © 2019 ITGeeKs. All rights reserved.
//
import UIKit

extension UIView {
    // different inner shadow styles
    public enum innerShadowSide {
        case all, left, right, top, bottom, topAndLeft, topAndRight, bottomAndLeft, bottomAndRight, exceptLeft, exceptRight, exceptTop, exceptBottom
    }

    // define function to add inner shadow
    public func addInnerShadow(onSide: innerShadowSide, shadowColor: UIColor, shadowSize: CGFloat, cornerRadius: CGFloat = 0.0, shadowOpacity: Float) {
        // define and set a shaow layer
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = bounds
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.shadowRadius = shadowSize
        shadowLayer.fillRule = CAShapeLayerFillRule.evenOdd
//        addSubview(<#T##view: UIView##UIView#>)
        // define shadow path
        let shadowPath = CGMutablePath()
        
        // define outer rectangle to restrict drawing area
        let insetRect = bounds.insetBy(dx: -shadowSize * 2.0, dy: -shadowSize * 2.0)
        
        // define inner rectangle for mask
        let innerFrame: CGRect = { () -> CGRect in
            switch onSide
            {
                case .all:
                    return CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height)
                case .left:
                    return CGRect(x: 0.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 4.0)
                case .right:
                    return CGRect(x: -shadowSize * 2.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 4.0)
                case .top:
                    return CGRect(x: -shadowSize * 2.0, y: 0.0, width: frame.size.width + shadowSize * 4.0, height: frame.size.height + shadowSize * 2.0)
                case.bottom:
                    return CGRect(x: -shadowSize * 2.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 4.0, height: frame.size.height + shadowSize * 2.0)
                case .topAndLeft:
                    return CGRect(x: 0.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
                case .topAndRight:
                    return CGRect(x: -shadowSize * 2.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
                case .bottomAndLeft:
                    return CGRect(x: 0.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
                case .bottomAndRight:
                    return CGRect(x: -shadowSize * 2.0, y: -shadowSize * 2.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height + shadowSize * 2.0)
                case .exceptLeft:
                    return CGRect(x: -shadowSize * 2.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height)
                case .exceptRight:
                    return CGRect(x: 0.0, y: 0.0, width: frame.size.width + shadowSize * 2.0, height: frame.size.height)
                case .exceptTop:
                    return CGRect(x: 0.0, y: -shadowSize * 2.0, width: frame.size.width, height: frame.size.height + shadowSize * 2.0)
                case .exceptBottom:
                    return CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height + shadowSize * 2.0)
            }
        }()
        
        // add outer and inner rectangle to shadow path
        shadowPath.addRect(insetRect)
        shadowPath.addRect(innerFrame)
        
        // set shadow path as show layer's
        shadowLayer.path = shadowPath
        
        // add shadow layer as a sublayer
        layer.addSublayer(shadowLayer)
        
        // hide outside drawing area
        clipsToBounds = true
    }
    
    func dropShadow(scale: Bool = true) {
        DispatchQueue.main.async {
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.5
            self.layer.shadowOffset = CGSize(width: -1, height: 1)
            self.layer.shadowRadius = 1
            self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        }
    }
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
    
    public func addInnerShadow(topColor: UIColor = UIColor.black.withAlphaComponent(0.3)) {
        let shadowLayer = CAGradientLayer()
        shadowLayer.cornerRadius = layer.cornerRadius
        shadowLayer.frame = bounds
        shadowLayer.frame.size.height = 10.0
        shadowLayer.colors = [
            topColor.cgColor,
            UIColor.white.withAlphaComponent(0).cgColor
        ]
        layer.addSublayer(shadowLayer)
    }
    
    public func addDefaultShadow() {
        layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.19), alpha: 1, x: 0, y: 3, blur: 2, spread: 0)
    }
    
    func addBlurArea(area: CGRect, style: UIBlurEffect.Style) {
        let effect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: effect)
        let container = UIView(frame: area)
        blurView.frame = CGRect(x: 0, y: 0, width: area.width, height: area.height)
        container.addSubview(blurView)
        container.alpha = 0.9
        insertSubview(container, at: 1)
    }
    
    func rotateView(targetView: UIView, duration: Double = 1.0) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            targetView.transform = targetView.transform.rotated(by: CGFloat(Double.pi))
        }) { finished in
            self.rotateView(targetView: targetView, duration: duration)
        }
    }
    
    public func ActivateConstraint(_ constraints: [NSLayoutConstraint]) {
        NSLayoutConstraint.activate(constraints)
    }
}

extension UIView {
    static func isRightToLeft() -> Bool {
        return AppMainLang.appMainLang == "ar" ? true : false
        //UIView.appearance().semanticContentAttribute == .forceRightToLeft
    }
    
    // nativeBounds
    var screenSize: CGRect {
        get {
            return UIScreen.main.bounds
        }
    }
    
    var screenWidth: CGFloat {
        get {
            return UIScreen.main.bounds.width
        }
    }
    
    var screenHight: CGFloat {
        get {
            return UIScreen.main.bounds.height
        }
    }
    
    var isDeviceIphoneSE: Bool {
        get {
            return screenHight == 568.0
        }
    }
    
    var isDeviceIphone6: Bool {
        get {
            return screenHight == 568.0 // $$$
        }
    }
    
    var isDeviceIphone6plus: Bool {
        get {
            return screenHight == 736.0
        }
    }
    
    var isDeviceIpad: Bool {
        get {
            return screenHight == 568.0 // $$$
        }
    }
    
    var viewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    var viewBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    func applySketchShadow() {
        layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.19), alpha: 1, x: 0, y: 3, blur: 2, spread: 0)
    }
    
    var viewBorderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}

// ref--> https://medium.com/@sdrzn/adding-gesture-recognizers-with-closures-instead-of-selectors-9fb3e09a8f0b
extension UIView {
    
    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    // This is the meat of the sauce, here we create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
}
