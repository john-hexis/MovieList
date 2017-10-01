//
//  DetailService.swift
//  MovieList
//
//  Created by John Harries on 1/10/17.
//  Copyright © 2017 MyPrivate. All rights reserved.
//

import Foundation
import Alamofire

class DetailService {
    let srvc = AlamoHelper()
    
    func GetMovieDetail(api: String, movieID: Int64, closure: @escaping (MovieDataDetail) throws -> Void) {
        var params: Parameters = [:]
        params.updateValue(api, forKey: ServiceParam.ApiKey.Value)
        
        self.srvc.get(url: URL.init(string: ServiceURL.MovieDetail.Value.replacingOccurrences(of: "{0}", with: String(describing: movieID)))!, params: params, success: { (rawResponse) in
            let entity = MovieDataDetail(entity: rawResponse)
            do {
                try closure(entity)
            }
            catch let error {
                print("HomeService | GetMovieList | MovieDataItem parse failure (\(error)).")
            }
        }) {
            print("HomeService | GetMovieList | Error accessing service url.")
        }
    }
}
