//
//  DetailViewModel.swift
//  MovieList
//
//  Created by John Harries on 1/10/17.
//  Copyright © 2017 MyPrivate. All rights reserved.
//

import Foundation
import UIKit

struct MovieDetail {
    var MovieTitle: String?
    var MoviePopularity: Float?
    var MovieSynopsis: String?
    var MovieLanguage: String?
    var MovieGenre: String?
    var MovieDuration: String?
    var MovieImagePath: String?
    var MovieImage: UIImage?
    
    init() {
        self.MovieTitle = "-"
        self.MoviePopularity = Float(0)
        self.MovieSynopsis = "-"
        self.MovieLanguage = "-"
        self.MovieGenre = "-"
        self.MovieDuration = "-"
        self.MovieImagePath = ""
    }
    
    init(data: MovieDataDetail) {
        self.MovieTitle = data.Title
        self.MoviePopularity = data.Popularity
        self.MovieSynopsis = data.Synopsis
        self.MovieDuration = "\(data.Duration!) minutes"
        self.MovieLanguage = "-"
        self.MovieGenre = "-"
        if let bdPath = data.BackdropPath  {
            self.MovieImagePath = bdPath
        } else if let pPath = data.PosterPath {
            self.MovieImagePath = pPath
        } else {
            self.MovieImagePath = ""
        }
        for item in data.Genre! {
            if self.MovieGenre == "" {
                self.MovieGenre = item.Name
            } else {
                self.MovieGenre = ", \(item.Name!)"
            }
        }
        for item in data.Language! {
            if self.MovieLanguage == "" {
                self.MovieLanguage = item.Name
            } else {
                self.MovieLanguage = ", \(item.Name!)"
            }
        }
    }
}

struct MovieDetailNavData: NavDataProtocol {
    var MovieId: Int64?
    
    init(movieId: Int64) {
        self.MovieId = movieId
    }
}
