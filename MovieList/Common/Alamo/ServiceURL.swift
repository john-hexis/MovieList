//
//  ServiceURL.swift
//  PPBeacon
//
//  Created by John Harries on 12/7/17.
//  Copyright © 2017 SierraSolutions. All rights reserved.
//

import Foundation

enum ServiceURL {
    case MovieDetail
    case MovieList
    case MovieBook
    case MovieImage
    
    static private let all:[ServiceURL] = [.MovieDetail, .MovieList, .MovieBook, .MovieImage]
    
    var Value: String {
        switch self {
        case .MovieDetail: return "https://api.themoviedb.org/3/movie/{0}"
        case .MovieList: return "https://api.themoviedb.org/3/discover/movie"
        case .MovieBook: return "http://www.cathaycineplexes.com.sg"
        case .MovieImage: return "https://image.tmdb.org/t/p/w500{0}"
        }
    }
}


enum ServiceParam {
    case ApiKey
    case PrimaryRelease
    case SortBy
    case Page
    case ImagePath
    
    static private let all: [ServiceParam] = [.ApiKey, .PrimaryRelease, .SortBy, .Page, .ImagePath]
    
    var Value: String {
        switch self {
        case .ApiKey: return "api_key"
        case .Page: return "page"
        case .PrimaryRelease: return "primary_release_date.lte"
        case .SortBy: return "sort_by"
        case .ImagePath: return "img_path"
        }
    }
}
