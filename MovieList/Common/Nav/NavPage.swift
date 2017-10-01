//
//  NavPage.swift
//  PPBeacon
//
//  Created by John Harries on 11/7/17.
//  Copyright © 2017 SierraSolutions. All rights reserved.
//

import Foundation

enum NavPage {
    case Home
    case Detail
    case Booking
    
    static let all: [NavPage] = [.Home, .Detail, .Booking]
    
    var PageID: String {
        switch self {
        case .Home: return "HomeViewID"
        case .Detail: return "DetailViewID"
        case .Booking: return "BookingViewID"
        }
    }
    
    var Storyboard: String {
        switch self {
        case .Home: return "Home"
        case .Detail: return "Detail"
        case .Booking: return "Booking"
        }
    }
}
