//
//  AppSettings.swift
//  MovieList
//
//  Created by John Harries on 1/10/17.
//  Copyright © 2017 MyPrivate. All rights reserved.
//

import Foundation

enum AppSettings {
    case ApiKey
    
    static private let all: [AppSettings] = [.ApiKey]
    
    var Value: String {
        switch self {
        case .ApiKey: return "328c283cd27bd1877d9080ccb1604c91"
        }
    }
}
