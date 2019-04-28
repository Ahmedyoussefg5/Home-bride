//
//  CurvedView.swift
//  Naql
//
//  Created by Youssef on 4/9/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class CurvedView: UIView {
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.beginPath()
        context.move(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: 0, y: rect.height))
        context.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY - 50), control: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.width, y: 0))
        context.addLine(to: CGPoint(x: 0, y: 0))
        context.closePath()
        context.setFillColor(#colorLiteral(red: 0.05394684523, green: 0.31705603, blue: 0.5753036141, alpha: 1))
        context.fillPath()
    }
}
