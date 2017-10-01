//
//  CGFloat+Parse.swift
//  PPBeacon
//
//  Created by John Harries on 14/7/17.
//  Copyright © 2017 SierraSolutions. All rights reserved.
//

import CoreGraphics
import Foundation

public extension CGFloat {
    static func Parse(toParse: String) -> CGFloat? {
        guard let result = NumberFormatter().number(from: toParse) else { return nil }
        return CGFloat(result)
    }
}
