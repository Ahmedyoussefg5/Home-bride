//
//  extension Int.swift
//  Gawla
//
//  Created by Youssef on 2/26/19.
//  Copyright © 2019 ITGeeKs. All rights reserved.
//

import Foundation

extension Int {
    func randomNumber(range: ClosedRange<Int> = 1...6) -> Int {
        let min = range.lowerBound
        let max = range.upperBound
        return Int(arc4random_uniform(UInt32(1 + max - min))) + min
    }
}
