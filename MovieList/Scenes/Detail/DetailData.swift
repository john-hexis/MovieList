//
//  DetailData.swift
//  MovieList
//
//  Created by John Harries on 1/10/17.
//  Copyright © 2017 MyPrivate. All rights reserved.
//

import Foundation

struct MovieDataDetail {
    internal enum Tags {
        case Synopsis
        case Genre
        case Language
        case Duration
        case BackdropPath
        case PosterPath
        case Title
        case Popularity
        
        static private let all: [MovieDataDetail.Tags] = [.Synopsis, .Genre, .Language, .Duration, .BackdropPath, .PosterPath, .Title, .Popularity]
        
        var Value:String {
            switch self {
            case .Synopsis: return "overview"
            case .Genre: return "genres"
            case .Language: return "spoken_languages"
            case .Duration: return "runtime"
            case .BackdropPath: return "backdrop_path"
            case .PosterPath: return "poster_path"
            case .Title: return "title"
            case .Popularity: return "popularity"
            }
        }
    }

    var Synopsis: String?
    var Genre: [MovieDataDetailInner]?
    var Language: [MovieDataDetailInner]?
    var Duration: Int?
    var BackdropPath: String?
    var PosterPath: String?
    var Title: String?
    var Popularity: Float?
    
    init() {
        
    }
    
    init(entity: Dictionary<String, AnyObject>) {
        self.Synopsis = entity[Tags.Synopsis.Value] as? String
        self.BackdropPath = entity[Tags.BackdropPath.Value] as? String
        self.PosterPath = entity[Tags.PosterPath.Value] as? String
        self.Duration = entity[Tags.Duration.Value] as? Int
        self.Title = entity[Tags.Title.Value] as? String
        self.Popularity = entity[Tags.Popularity.Value] as? Float
        
        self.Language = MovieDataDetailInner.ConvertRange(entities: (entity[Tags.Language.Value] as? Array<Any>)!)
        self.Genre = MovieDataDetailInner.ConvertRange(entities: (entity[Tags.Genre.Value] as? Array<Any>)!)
    }
}

struct MovieDataDetailInner {
    internal enum Tags {
        case Name
        
        static private let all: [MovieDataDetailInner.Tags] = [.Name]
        
        var Value:String {
            switch self {
            case .Name: return "name"
            }
        }
    }
    
    var Name: String?
    
    init(entity: Dictionary<String,AnyObject>) {
        self.Name = entity[Tags.Name.Value] as? String
    }
    
    static func ConvertRange(entities: Array<Any>) -> [MovieDataDetailInner] {
        var result = [MovieDataDetailInner]()
        for rowEntity in entities {
            let entity = rowEntity as? Dictionary<String, AnyObject>
            result.append(MovieDataDetailInner(entity: entity!))
        }
        return result
    }
}
