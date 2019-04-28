//
//  TwoLablesOneLine.swift
//  Naql
//
//  Created by Youssef on 4/10/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class TwoLablesOneLine: UILabel {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 21)
    }
    
    var lableText: String = "" {
        didSet {
            lable.text = lableText
        }
    }
    private lazy var lable: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8986659646, green: 0.7183755636, blue: 0.1346419752, alpha: 1)
        label.textAlignment = .left
        label.font = .CairoSemiBold(of: 14)
        label.text = "info"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    init(textOne: String) { //, textTwo: String, colorOne: UIColor, colorTwo: UIColor, fontOne: UIFont, fontTwo: UIFont) {
        super.init(frame: .zero)
        text = textOne
        textAlignment = .right
        translatesAutoresizingMaskIntoConstraints = no
        font = .CairoRegular(of: 15)
        textColor = #colorLiteral(red: 0.6077771783, green: 0.6078822613, blue: 0.6077623963, alpha: 1)
        
//        attributedText = NSMutableAttributedString(texts: [textOne, "معلومات"], fonts: [.CairoRegular(of: 15), .CairoSemiBold(of: 14)], colors: [#colorLiteral(red: 0.6077771783, green: 0.6078822613, blue: 0.6077623963, alpha: 1), #colorLiteral(red: 0.8986659646, green: 0.7183755636, blue: 0.1346419752, alpha: 1)], [.left, .right])
//        widthAnchorWithMultiplier(multiplier: 0.5)
        
//        addSubview(lable)
//        ActivateConstraint([
//            lable.heightAnchor.constraint(equalTo: heightAnchor),
////            widthAnchorWithMultiplier(multiplier: 0.5),
//            lable.trailingAnchor.constraint(equalTo: leadingAnchor),
//            lable.topAnchor.constraint(equalTo: topAnchor)
//            ])
        
    }; required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
class LablesOne: UILabel {

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 21)
    }
    
    init(textOne: String) { //, textTwo: String, colorOne: UIColor, colorTwo: UIColor, fontOne: UIFont, fontTwo: UIFont) {
        super.init(frame: .zero)
        text = textOne
        textAlignment = .left
        translatesAutoresizingMaskIntoConstraints = no
        font = .CairoSemiBold(of: 14)
        textColor = #colorLiteral(red: 0.8986659646, green: 0.7183755636, blue: 0.1346419752, alpha: 1)
    }; required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
