//
//  UINavigationBarExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/22/16.

//
#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods
public extension UINavigationBar {
    
    /// Set Navigation Bar title, title color and font.
    ///
    /// - Parameters:
    ///   - font: title font
    ///   - color: title text color (default is .black).
    public func setTitleFont(_ font: UIFont, color: UIColor = .black) {
        var attrs = [NSAttributedString.Key: Any]()
        attrs[.font] = font
        attrs[.foregroundColor] = color
        titleTextAttributes = attrs
    }
    
    /// Make navigation bar transparent.
    ///
    /// - Parameter tint: tint color (default is .white).
    func makeTransparent(withTint tint: UIColor?) {
        isTranslucent = true
        backgroundColor = .clear
        barTintColor = .clear
        setBackgroundImage(UIImage(), for: .default)
        tintColor = tint
        titleTextAttributes = [.foregroundColor: tint ?? .white]
        shadowImage = UIImage()
    }
    
    /// Set navigationBar background and text colors
    ///
    /// - Parameters:
    ///   - background: backgound color
    ///   - text: text color
    public func setColors(background: UIColor, text: UIColor) {
        isTranslucent = false
        backgroundColor = background
        barTintColor = background
        setBackgroundImage(UIImage(), for: .default)
        tintColor = text
        titleTextAttributes = [.foregroundColor: text]
    }
    
}
#endif
