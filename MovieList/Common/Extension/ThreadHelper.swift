//
//  ThreadHelper.swift
//  Care Network
//
//  Created by John Harries on 27/5/16.
//  Copyright © 2016 Sierra MedIT. All rights reserved.
//

import Foundation

class ThreadHelper {
    class func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}
