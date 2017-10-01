//
//  File.swift
//  PPBeacon
//
//  Created by John Harries on 13/7/17.
//  Copyright © 2017 SierraSolutions. All rights reserved.
//

import Foundation

extension Date {
    var Age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
    
    static func toString(toFormat: String, date: Date) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = toFormat
        return dateFormat.string(from: date)
    }
    
    static func fromString(fromFormat: String, dateStr: String) -> Date {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = fromFormat
        return dateFormat.date(from: dateStr)!
    }
}
