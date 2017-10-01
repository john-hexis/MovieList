//
//  HomeData.swift
//  MovieList
//
//  Created by John Harries on 1/10/17.
//  Copyright © 2017 MyPrivate. All rights reserved.
//

import Foundation

struct MovieDataItem {
    internal enum Tags {
        case VoteCount
        case Id
        case Video
        case VoteAverage
        case Title
        case Popularity
        case PosterPath
        case OriginalLang
        case OriginalTitle
        case GenreId
        case BackdropPath
        case Adult
        case Overview
        case ReleaseDate
        
        static private let all: [Tags] = [.Video, .VoteCount, .VoteAverage, .Adult, .BackdropPath, .GenreId, .Id, .OriginalTitle, .OriginalLang, .Overview, .Popularity, .PosterPath, .ReleaseDate, .Title]
        
        var Value:String {
            switch self {
            case .VoteCount: return "vote_count"
            case .Id: return "id"
            case .Video: return "video"
            case .VoteAverage: return "vote_average"
            case .Title: return "title"
            case .Popularity: return "popularity"
            case .PosterPath: return "poster_path"
            case .OriginalLang: return "original_language"
            case .OriginalTitle: return "original_title"
            case .GenreId: return "genre_ids"
            case .BackdropPath: return "backdrop_path"
            case .Adult: return "adult"
            case .Overview: return "overview"
            case .ReleaseDate: return "release_date"
            }
        }
    }
    
    var VoteCount: Int?
    var Id: Int64?
    var Video: Bool?
    var VoteAverage: Int?
    var Title: String?
    var Popularity: Float?
    var PosterPath: String?
    var OriginalLang: String?
    var OriginalTitle: String?
    var GenreId: [Int]?
    var BackdropPath: String?
    var Adult: Bool?
    var Overview: String?
    var ReleaseDate: Date?
    
    init(entity: Dictionary<String,AnyObject>) {
        self.VoteCount = entity[Tags.VoteCount.Value] as? Int
        self.Id = entity[Tags.Id.Value] as? Int64
        self.Video = entity[Tags.Video.Value] as? Bool
        self.VoteAverage = entity[Tags.VoteAverage.Value] as? Int
        self.Title = entity[Tags.Title.Value] as? String
        self.Popularity = entity[Tags.Popularity.Value] as? Float
        self.PosterPath = entity[Tags.PosterPath.Value] as? String
        self.OriginalLang = entity[Tags.OriginalLang.Value] as? String
        self.GenreId = entity[Tags.GenreId.Value] as? [Int]
        self.BackdropPath = entity[Tags.BackdropPath.Value] as? String
        self.Adult = entity[Tags.Adult.Value] as? Bool
        self.Overview = entity[Tags.Overview.Value] as? String
        self.ReleaseDate = Date.fromString(fromFormat: "yyyy-MM-dd", dateStr: (entity[Tags.ReleaseDate.Value] as? String)!)
    }
    
    static func ConvertRange(entities: Array<Any>) -> [MovieDataItem] {
        var result = [MovieDataItem]()
        for rowEntity in entities {
            let entity = rowEntity as? Dictionary<String, AnyObject>
            result.append(MovieDataItem(entity: entity!))
        }
        return result
    }
}

struct MovieDataResponse {
    internal enum Tags {
        case Page
        case TotalResults
        case TotalPages
        case Results
        
        static private let all: [Tags] = [.Page, .TotalPages, .TotalResults, .Results]
        
        var Value:String {
            switch self {
            case .Page: return "page"
            case .TotalResults: return "total_results"
            case .TotalPages: return "total_pages"
            case .Results: return "results"
            }
        }
    }
    
    var Page: Int?
    var TotalResults: Int?
    var TotalPages: Int?
    var Results: Array<Any>?
    
    init(enttity: Dictionary<String, AnyObject>) {
        self.Page = enttity[Tags.Page.Value] as? Int
        self.TotalResults = enttity[Tags.TotalResults.Value] as? Int
        self.TotalPages = enttity[Tags.TotalPages.Value] as? Int
        self.Results = enttity[Tags.Results.Value] as? Array<Any>
    }
}
