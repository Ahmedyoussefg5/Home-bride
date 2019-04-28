//
//  extension UIViewController.swift
//
//
//  Created by Youssef on 9/16/18.
//  Copyright © 2018 Youssef. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentModelyVC(vc: UIViewController) {
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
    
    func showAlert(title : String, messages : [String]?, message: String?, selfDismissing: Bool, time: TimeInterval = 1) {
        
        var messageContent = ""
        
        if let messages = messages {
            messageContent = messages.joined(separator: "\n")
        } else if let message = message {
            messageContent = message
        }
        
        let alert = UIAlertController(title: title, message: messageContent, preferredStyle: .alert)
        alert.setValue(NSAttributedString(string: title.localize, attributes: [.font: UIFont.CairoBold(of: 18), .foregroundColor: #colorLiteral(red: 0.1254901961, green: 0.4, blue: 0.7764705882, alpha: 1)]), forKey: "attributedTitle")
        alert.setValue(NSAttributedString(string: messageContent.localize, attributes: [.font: UIFont.CairoSemiBold(of: 12), .foregroundColor: #colorLiteral(red: 0.1254901961, green: 0.4, blue: 0.7764705882, alpha: 1)]), forKey: "attributedMessage")
        alert.view.alpha = 0.3
        
        if !selfDismissing {
            let title = NSLocalizedString("OK".localize, comment: "Any")
            alert.addAction(UIAlertAction(title: title, style: .cancel, handler: nil))
        }
        
        present(alert, animated: true)
        
        if selfDismissing {
            Timer.scheduledTimer(withTimeInterval: time, repeats: false) { t in
                t.invalidate()
                alert.dismiss(animated: true)
            }
        }
    }
    
    func hideNavigationBar(){
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
//    func setupNavBarApperance(title: String?, addImageTitle: Bool = false, showNotifButton: Bool = false) {
//        if let title = title {
//            navigationItem.title = title.localize
//            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.battleshipGrey, .font: UIFont.CairoBold(of: 16)]
//        }
//
//        if addImageTitle {
//            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
//            imageView.contentMode = .scaleToFill
//            imageView.image = UIImage(named: "group125Copy")
//            navigationItem.titleView = imageView
//        }
//
//        if showNotifButton {
//            let notificationsButton = UIBarButtonItem(image: #imageLiteral(resourceName: "bell"), landscapeImagePhone: #imageLiteral(resourceName: "bell"), style: .plain, target: self, action: #selector(handleNotifications))
//            notificationsButton.width = 30
//            navigationItem.rightBarButtonItem = notificationsButton
//        }
//
//        navigationController?.navigationBar.tintColor = .battleshipGrey
//        navigationController?.navigationBar.topItem?.title = ""
//        //navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backChevron")
//        //navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backChevron")
//    }
    
    @objc func handleNotifications() {
        let notificationsVC = NotificationsViewController()
        navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "bell")
        navigationController?.pushViewController(notificationsVC, animated: true)
    }
    
    final func navbarWithdismiss() {
        let exitButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissMePlease))
        navigationItem.rightBarButtonItem = exitButton
    }
    
    @objc final func dismissMePlease() {
        dismiss(animated: true, completion: nil)
    }
    
    func setStatusBarBackgroundColor(color: UIColor) {
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = color
    }
    
    func interactionConfig(with indicator: UIActivityIndicatorView?, to status: Bool) {
        if status {
            indicator?.isHidden = false
            indicator?.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        } else {
            indicator?.isHidden = true
            indicator?.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func toAddChildViewController(childViewController: UIViewController, childViewControllerContainer: UIView, comp: (() -> ())? = nil) {
        toRemoveChildViewController()
        addChild(childViewController)
        
        childViewControllerContainer.addSubview(childViewController.view)
        childViewController.view.frame = childViewControllerContainer.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParent: self)
    }
    
    func toRemoveChildViewController() {
        if self.children.count > 0 {
            let viewControllers:[UIViewController] = self.children
            for viewContoller in viewControllers{
                viewContoller.willMove(toParent: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParent()
            }
        }
    }
}

// MARK :- API Handler

extension UIViewController {
    func callApi<U: BaseCodable>(_ model: U.Type,
                                 parameters: UserDataRouter,
                                 shouldShowAlert: Bool = true,
                                 activityIndicator: UIActivityIndicatorView? = nil,
                                 comp: @escaping(_ data: U?)->()) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        activityIndicator?.startAnimating()
        
        ApiService.shared.getData(U.self, requestData: parameters) {[weak self] (message, data) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            activityIndicator?.stopAnimating()
            
            if let data = data {
                if data.status {
                    comp(data); return
                } else {
                    comp(nil)
                    if shouldShowAlert {
                        self?.showAlert(title: "", messages: data.errors, message: data.message, selfDismissing: true)
                    }
                    return
                }
            } else if let message = message {
                comp(nil)
                if shouldShowAlert {
                    self?.showAlert(title: "Error".localize, messages: data?.errors, message: message, selfDismissing: false)
                }
                return
            } else {
                comp(nil)
                if shouldShowAlert {
                    self?.showAlert(title: "Error".localize, messages: data?.errors, message: message, selfDismissing: false)
                }
                return
            }
        }
    }
}

public extension UIViewController {
    
    /// Check if ViewController is onscreen and not hidden.
    public var isVisible: Bool {
        // http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
        return isViewLoaded && view.window != nil
    }
    
    func isVisible(view: UIView) -> Bool {
        func isVisible(view: UIView, inView: UIView?) -> Bool {
            guard let inView = inView else { return true }
            let viewFrame = inView.convert(view.bounds, from: view)
            if viewFrame.intersects(inView.bounds) {
                return isVisible(view: view, inView: inView.superview)
            }
            return false
        }
        return isVisible(view: view, inView: view.superview)
    }
    
    /// Assign as listener to notification.
    ///
    /// - Parameters:
    ///   - name: notification name.
    ///   - selector: selector to run with notified.
    public func addNotificationObserver(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    
    /// Unassign as listener to notification.
    ///
    /// - Parameter name: notification name.
    public func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }
    
    /// Unassign as listener from all notifications.
    public func removeNotificationsObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// Helper method to display an alert on any UIViewController subclass. Uses UIAlertController to show an alert
    ///
    /// - Parameters:
    ///   - title: title of the alert
    ///   - message: message/body of the alert
    ///   - buttonTitles: (Optional)list of button titles for the alert. Default button i.e "OK" will be shown if this paramter is nil
    ///   - highlightedButtonIndex: (Optional) index of the button from buttonTitles that should be highlighted. If this parameter is nil no button will be highlighted
    ///   - completion: (Optional) completion block to be invoked when any one of the buttons is tapped. It passes the index of the tapped button as an argument
    /// - Returns: UIAlertController object (discardable).
    @discardableResult public func showAlert(title: String?, message: String?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        
        var shouldMakeRedButton = false
        
        if allButtons.count == 0 {
            allButtons.append("Ok".localize)
        } else if allButtons.count == 2 {
            shouldMakeRedButton = true
        }
        
        alertController.setValue(NSAttributedString(string: title ?? "", attributes: [.font: UIFont.CairoBold(of: 18), .foregroundColor: #colorLiteral(red: 0.1254901961, green: 0.4, blue: 0.7764705882, alpha: 1)]), forKey: "attributedTitle")
        alertController.view.alpha = 0.3
        
        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            var style: UIAlertAction.Style = .default
            if shouldMakeRedButton && index == 0 {
                style = .destructive
            }
            let action = UIAlertAction(title: buttonTitle, style: style, handler: { (_) in
                completion?(index)
            })
            alertController.addAction(action)
            
            // Check which button to highlight
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                alertController.preferredAction = action
            }
        }
        present(alertController, animated: true, completion: nil)
        return alertController
    }
    
    /// Helper method to add a UIViewController as a childViewController.
    ///
    /// - Parameters:
    ///   - child: the view controller to add as a child
    ///   - containerView: the containerView for the child viewcontroller's root view.
    //    public func addChildViewController(_ child: UIViewController, toContainerView containerView: UIView) {
    //        addChild(child)
    //        containerView.addSubview(child.view)
    //        child.didMove(toParent: self)
    //    }
    //
    //    /// Helper method to remove a UIViewController from its parent.
    //    public func removeViewAndControllerFromParentViewController() {
    //        guard parent != nil else { return }
    //
    //        willMove(toParent: nil)
    //        removeFromParent()
    //        view.removeFromSuperview()
    //    }
    
    #if os(iOS)
    /// Helper method to present a UIViewController as a popover.
    ///
    /// - Parameters:
    ///   - popoverContent: the view controller to add as a popover.
    ///   - sourcePoint: the point in which to anchor the popover.
    ///   - size: the size of the popover. Default uses the popover preferredContentSize.
    ///   - delegate: the popover's presentationController delegate. Default is nil.
    ///   - animated: Pass true to animate the presentation; otherwise, pass false.
    ///   - completion: The block to execute after the presentation finishes. Default is nil.
    public func presentPopover(_ popoverContent: UIViewController, sourcePoint: CGPoint, size: CGSize? = nil, delegate: UIPopoverPresentationControllerDelegate? = nil, animated: Bool = true, completion: (() -> Void)? = nil) {
        popoverContent.modalPresentationStyle = .popover
        
        if let size = size {
            popoverContent.preferredContentSize = size
        }
        
        if let popoverPresentationVC = popoverContent.popoverPresentationController {
            popoverPresentationVC.sourceView = view
            popoverPresentationVC.sourceRect = CGRect(origin: sourcePoint, size: .zero)
            popoverPresentationVC.delegate = delegate
        }
        
        present(popoverContent, animated: animated, completion: completion)
    }
    #endif
}
extension UINavigationBar {
    func setGradientBackground(colors: [UIColor]) {
        var updatedFrame = bounds
        updatedFrame.size.height += 20
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        setBackgroundImage(gradientLayer.creatGradientImage(), for: UIBarMetrics.default)
    }
}

extension CAGradientLayer {
    
    convenience init(frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        //        self.colors = []
        self.colors = colors.map({$0.cgColor})
        locations = [0.9, 0.0]
        startPoint = CGPoint(x: 0.9, y: 0)
        endPoint = CGPoint(x: 0, y: 0)
    }
    
    func creatGradientImage() -> UIImage? {
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
    
}
