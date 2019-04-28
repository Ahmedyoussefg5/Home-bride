//
//  extension Bool.swift
//  Gawla
//
//  Created by Youssef on 2/26/19.
//  Copyright © 2019 ITGeeKs. All rights reserved.
//

import Foundation

extension Bool {
    var toInt: Int {
        return NSNumber(booleanLiteral: self).intValue
    }
}

// MARK: - Properties
public extension Bool {
    
    /// Return 1 if true, or 0 if false.
    ///
    ///        false.int -> 0
    ///        true.int -> 1
    ///
    public var int: Int {
        return self ? 1 : 0
    }
    
    /// Return "true" if true, or "false" if false.
    ///
    ///        false.string -> "false"
    ///        true.string -> "true"
    ///
    public var string: String {
        return description
    }
    
}
