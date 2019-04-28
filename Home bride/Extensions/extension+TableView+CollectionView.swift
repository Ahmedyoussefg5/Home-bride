//
//  StringExtension.swift
//  Motor Sports
//
//  Created by Youssef on 1/31/17.
//  Copyright © 2017 Youssef. All rights reserved.
//

import UIKit
//import MOLH

extension UITableView {
    func isTransperant() {
        backgroundColor = .clear
        isOpaque = false
        backgroundView = nil
        tableFooterView = UIView()
        separatorColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
}

class ArabicCollectionFlow: UICollectionViewFlowLayout {
    override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return AppMainLang.isRTLLanguage()
    }
}

extension UITableView {
    func scrollToBottom(animated: Bool = true) {
        let section = numberOfSections
        if section > 0 {
            let row = numberOfRows(inSection: section - 1)
            if row > 0 {
                scrollToRow(at: IndexPath(row: row - 1, section: section - 1), at: .bottom, animated: animated)
            }
        }
    }
}

public extension UIScrollView {
    
    public func scrollViewToBottom(animated: Bool) {
        let rect = CGRect(x: 0, y: contentSize.height - bounds.size.height, width: bounds.size.width, height: bounds.size.height)
        scrollRectToVisible(rect, animated: animated)
    }
    
}
