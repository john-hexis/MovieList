//
//  HomeViewModel.swift
//  MovieList
//
//  Created by John Harries on 1/10/17.
//  Copyright © 2017 MyPrivate. All rights reserved.
//

import Foundation
import UIKit

struct MovieItem {
    var MovieId: Int64?
    var MovieImagePath: String?
    var MovieImageView: UIImage?
    var MovieTitle: String?
    var MoviePopularity: Float?
    
    init(data: MovieDataItem) {
        self.MovieId = data.Id!
        self.MoviePopularity = data.Popularity!
        self.MovieTitle = data.Title!
        guard let path = data.BackdropPath else {
            guard let poster = data.PosterPath else {
                self.MovieImagePath = ""
                return
            }
            self.MovieImagePath = poster
            return
        }
        self.MovieImagePath = path
    }
    
    static func ConvertRange(data: [MovieDataItem]) -> [MovieItem] {
        var result = [MovieItem]()
        for item in data {
            result.append(MovieItem(data: item))
        }
        return result
    }
}

struct MovieItemSection {
    var MovieReleaseDate: Date
    var MovieItems: [MovieItem]
    var MovieSection: Int
}
