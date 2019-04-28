//
//  extension Date.swift
//  Gawla
//
//  Created by Youssef on 1/1/19.
//  Copyright © 2019 ITGeeKs. All rights reserved.
//

import Foundation
extension Date {
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
    static func > (lhs: Date, rhs: Date) -> Bool { // BY ME NOT TESTED
        return lhs.timeIntervalSinceReferenceDate > rhs.timeIntervalSinceReferenceDate ? true : false
    }
    
    public static func + (lhs: Date, rhs: TimeInterval) -> Date {
        let dateTimeInterval = lhs.timeIntervalSinceReferenceDate + rhs
        let resultDate = Date(timeIntervalSinceReferenceDate: dateTimeInterval)
        return resultDate
    }
    
    var hour: Int {
//        var calener = Calendar.current
//        calener.timeZone = TimeZone(secondsFromGMT:0) ?? TimeZone.current {}
        return Calendar.autoupdatingCurrent.component(.hour, from: self)
    }
    
    var minute: Int {
        return Calendar.autoupdatingCurrent.component(.minute, from: self)
    }
    
    var second: Int {
        return Calendar.autoupdatingCurrent.component(.second, from: self)
    }
    
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        
        let quotient: Int
        let unit: String
        if secondsAgo < minute {
            quotient = secondsAgo
            unit = "second"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "min"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "hour"
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = "day"
        } else if secondsAgo < month {
            quotient = secondsAgo / week
            unit = "week"
        } else {
            quotient = secondsAgo / month
            unit = "month"
        }
        
        return "\(quotient) \(unit)\(quotient == 1 ? "" : "s") ago"
    }

    func toShortTimeString() -> String {
        //Get Short Time String
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let timeString = formatter.string(from: self)
        
        //Return Short Time String
        return timeString
    }
    
    func getDateToStringDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let myStringafd = formatter.string(from: date)
        return myStringafd
    }
    
    func getDateToStringTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSS"
        let myStringafd = formatter.string(from: date)
        return myStringafd
    }
}

extension TimeInterval {
    
    var milliseconds: Int {
        return Int((truncatingRemainder(dividingBy: 1)) * 1000)
    }
    
    var seconds: String {
        return String(format: "%02d", Int(self) % 60)
//        return Int(self) % 60
    }
    
    var minutes: String {
        return String(format: "%02d", (Int(self) / 60 ) % 60)
//        return (Int(self) / 60 ) % 60
    }
    
    var hours: String {
        return String(format: "%02d", Int(self) / 3600)
//        return Int(self) / 3600
    }
    
//    var stringTime: String {
//        if hours != 0 {
//            return "\(hours)h \(minutes)m \(seconds)s"
//        } else if minutes != 0 {
//            return "\(minutes)m \(seconds)s"
//        } else if milliseconds != 0 {
//            return "\(seconds)s \(milliseconds)ms"
//        } else {
//            return "\(seconds)s"
//        }
//    }
}
