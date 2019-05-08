import UIKit

extension UIButton {
    
    func addTrailingImageView(image: UIImage, width: CGFloat, hight: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.tintColor = lightPurple
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        ActivateConstraint([
            imageView.widthAnchor.constraint(equalToConstant: width),
            imageView.heightAnchor.constraint(equalToConstant: hight),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
            ])
    }
    
    func addLeadingImageView(image: UIImage, width: CGFloat, hight: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
//        self.titleEdgeInsets = .init(top: 0, left: 7, bottom: 0, right: 7)
        self.contentEdgeInsets = .init(top: 0, left: width + 4, bottom: 0, right: 0)
        self.addSubview(imageView)
        ActivateConstraint([
            imageView.widthAnchor.constraint(equalToConstant: width),
            imageView.heightAnchor.constraint(equalToConstant: hight),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
            ])
    }    
}

//
//  UIButtonExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/22/16.

//
#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Properties
public extension UIButton {
    
    /// Image of disabled state for button; also inspectable from Storyboard.
//    @IBInspectable public var imageForDisabled: UIImage? {
//        get {
//            return image(for: .disabled)
//        }
//        set {
//            setImage(newValue, for: .disabled)
//        }
//    }
//    
//    /// Image of highlighted state for button; also inspectable from Storyboard.
//    @IBInspectable public var imageForHighlighted: UIImage? {
//        get {
//            return image(for: .highlighted)
//        }
//        set {
//            setImage(newValue, for: .highlighted)
//        }
//    }
//    
//    /// Image of normal state for button; also inspectable from Storyboard.
//    @IBInspectable public var imageForNormal: UIImage? {
//        get {
//            return image(for: .normal)
//        }
//        set {
//            setImage(newValue, for: .normal)
//        }
//    }
//    
//    /// Image of selected state for button; also inspectable from Storyboard.
//    @IBInspectable public var imageForSelected: UIImage? {
//        get {
//            return image(for: .selected)
//        }
//        set {
//            setImage(newValue, for: .selected)
//        }
//    }
//    
//    /// Title color of disabled state for button; also inspectable from Storyboard.
//    @IBInspectable public var titleColorForDisabled: UIColor? {
//        get {
//            return titleColor(for: .disabled)
//        }
//        set {
//            setTitleColor(newValue, for: .disabled)
//        }
//    }
//    
//    /// Title color of highlighted state for button; also inspectable from Storyboard.
//    @IBInspectable public var titleColorForHighlighted: UIColor? {
//        get {
//            return titleColor(for: .highlighted)
//        }
//        set {
//            setTitleColor(newValue, for: .highlighted)
//        }
//    }
//    
//    /// Title color of normal state for button; also inspectable from Storyboard.
//    @IBInspectable public var titleColorForNormal: UIColor? {
//        get {
//            return titleColor(for: .normal)
//        }
//        set {
//            setTitleColor(newValue, for: .normal)
//        }
//    }
//    
//    /// Title color of selected state for button; also inspectable from Storyboard.
//    @IBInspectable public var titleColorForSelected: UIColor? {
//        get {
//            return titleColor(for: .selected)
//        }
//        set {
//            setTitleColor(newValue, for: .selected)
//        }
//    }
//    
//    /// Title of disabled state for button; also inspectable from Storyboard.
//    @IBInspectable public var titleForDisabled: String? {
//        get {
//            return title(for: .disabled)
//        }
//        set {
//            setTitle(newValue, for: .disabled)
//        }
//    }
//    
//    /// Title of highlighted state for button; also inspectable from Storyboard.
//    @IBInspectable public var titleForHighlighted: String? {
//        get {
//            return title(for: .highlighted)
//        }
//        set {
//            setTitle(newValue, for: .highlighted)
//        }
//    }
//    
//    /// Title of normal state for button; also inspectable from Storyboard.
//    @IBInspectable public var titleForNormal: String? {
//        get {
//            return title(for: .normal)
//        }
//        set {
//            setTitle(newValue, for: .normal)
//        }
//    }
//    
//    /// Title of selected state for button; also inspectable from Storyboard.
//    @IBInspectable public var titleForSelected: String? {
//        get {
//            return title(for: .selected)
//        }
//        set {
//            setTitle(newValue, for: .selected)
//        }
//    }
    
}

// MARK: - Methods
public extension UIButton {
    
    private var states: [UIControl.State] {
        return [.normal, .selected, .highlighted, .disabled]
    }
    
    /// Set image for all states.
    ///
    /// - Parameter image: UIImage.
    public func setImageForAllStates(_ image: UIImage) {
        states.forEach { setImage(image, for: $0) }
    }
    
    /// Set title color for all states.
    ///
    /// - Parameter color: UIColor.
    public func setTitleColorForAllStates(_ color: UIColor) {
        states.forEach { setTitleColor(color, for: $0) }
    }
    
    /// Set title for all states.
    ///
    /// - Parameter title: title string.
//    public func setTitleForAllStates(_ title: String) {
//        states.forEach { setTitle(title, for: $0) }
//    }
    
    public func setTitleNormalState(_ title: String?) {
        if let title = title {
            setTitle(title, for: .normal)
        }
    }
    
    public func setTitleColorNormalState(_ color: UIColor) {
        setTitleColor(color, for: .normal)
    }
    
    public func setFont(_ font: UIFont) {
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.font = font
    }

    /// Center align title text and image on UIButton
    ///
    /// - Parameter spacing: spacing between UIButton title text and UIButton Image.
    public func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
    
}
#endif
extension UIButton {
    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    fileprivate struct AssociatedObjectKeyss {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var tapAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeyss.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeyss.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    //    // This is the meat of the sauce, here we create the tap gesture recognizer and
    //    // store the closure the user passed to us in the associated object we declared above
    public func addTheTarget(action: (() -> Void)?) {
        tapAction = action
        addTarget(self, action: #selector(handleTapTarget), for: .touchUpInside)
    }
    
    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapTarget(sender: UIButton) {
        if let action = self.tapAction {
            action?()
        } else {
            print("no action")
        }
    }
    
}
