//
//  HomeService.swift
//  MovieList
//
//  Created by John Harries on 1/10/17.
//  Copyright © 2017 MyPrivate. All rights reserved.
//

import Foundation
import Alamofire

class HomeService {
    let srvc = AlamoHelper()
    
    func GetMovieList(api: String, releaseDate: String, sortBy: SortByOption, page: Int, closure: @escaping ([MovieDataItem]) throws -> Void) {
        var params: Parameters = [:]
        params.updateValue(api, forKey: ServiceParam.ApiKey.Value)
        params.updateValue(releaseDate, forKey: ServiceParam.PrimaryRelease.Value)
        params.updateValue(sortBy.Value, forKey: ServiceParam.SortBy.Value)
        params.updateValue(page, forKey: ServiceParam.Page.Value)
        
        self.srvc.get(url: URL.init(string: ServiceURL.MovieList.Value)!, params: params, success: { (rawResponse) in
            let response = MovieDataResponse(enttity: rawResponse)
            let entities = MovieDataItem.ConvertRange(entities: response.Results!)
            do {
                try closure(entities)
            }
            catch let error {
                print("HomeService | GetMovieList | MovieDataItem parse failure (\(error)).")
            }
        }) {
            print("HomeService | GetMovieList | Error accessing service url.")
        }
    }
}

enum SortByOption {
    case PopularityASC
    case PopularityDESC
    case ReleaseDateASC
    case ReleaseDateDESC
    case RevenueASC
    case RevenueDESC
    case PrimaryReleaseASC
    case PrimaryReleaseDESC
    case OriginalTitleASC
    case OriginalTitleDESC
    case VoteAvgASC
    case VoteAvgDESC
    case VoteASC
    case VoteDESC
    
    static let all: [SortByOption] = [.OriginalTitleASC, .OriginalTitleDESC, .PopularityASC, .PopularityDESC, .PrimaryReleaseASC, .PrimaryReleaseDESC, .ReleaseDateASC, .ReleaseDateDESC, .RevenueASC, .RevenueDESC, .VoteASC, .VoteDESC, .VoteAvgASC, .VoteAvgDESC]
    
    var Value: String {
        switch self {
        case .PopularityASC: return "popularity.asc"
        case .PopularityDESC: return "popularity.desc"
        case .ReleaseDateASC: return "release_date.asc"
        case .ReleaseDateDESC: return "release_date.desc"
        case .RevenueASC: return "revenue.asc"
        case .RevenueDESC: return "revenue.desc"
        case .PrimaryReleaseASC: return "primary_release_date.asc"
        case .PrimaryReleaseDESC: return "primary_release_date.desc"
        case .OriginalTitleASC: return "original_title.asc"
        case .OriginalTitleDESC: return "original_title.desc"
        case .VoteAvgASC: return "vote_average.asc"
        case .VoteAvgDESC: return "vote_average.desc"
        case .VoteASC: return "vote_count.asc"
        case .VoteDESC: return "vote_count.desc"
        }
    }
}
