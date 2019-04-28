////
////  extension UINavigationController.swift
////  Gawla
////
////  Created by Youssef on 2/26/19.
////  Copyright © 2019 ITGeeKs. All rights reserved.
////
//
//import UIKit
//
//extension UINavigationController { //: UINavigationControllerDelegate {
//
//    //    override open func viewDidLoad() {
//    //        super.viewDidLoad()
//    //      //  self.delegate = self
//    //    }
//    open override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.view.semanticContentAttribute = UIView.isRightToLeft() ? .forceRightToLeft : .forceLeftToRight
//    }
//    //
//
//    //    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//    //        navigationController.view.semanticContentAttribute = UIView.isRightToLeft() ? .forceRightToLeft : .forceLeftToRight
//    //    }
//
//    //    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//    //        navigationController.view.semanticContentAttribute = UIView.isRightToLeft() ? .forceRightToLeft : .forceLeftToRight
//    //        //navigationController.navigationBar.semanticContentAttribute = UIView.isRightToLeft() ? .forceRightToLeft : .forceLeftToRight
//    //    }
//}
