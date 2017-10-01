//
//  MovieListItem.swift
//  MovieList
//
//  Created by John Harries on 1/10/17.
//  Copyright © 2017 MyPrivate. All rights reserved.
//

import Foundation
import UIKit

class MovieListItem: UITableViewCell {
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePop: UILabel!
    @IBOutlet weak var movieBanner: UIView!
    
    var movieImagePath: String!
    
    func setBorderRadius(radius: Float) -> Void {
        //Detail View
        let detailMaskPath = UIBezierPath(roundedRect: movieBanner.bounds,
                                          byRoundingCorners: [.bottomLeft, .bottomRight],
                                          cornerRadii: CGSize(width: CGFloat(radius), height: CGFloat(radius)))
        
        let detailShape = CAShapeLayer()
        detailShape.path = detailMaskPath.cgPath
        movieBanner.layer.mask = detailShape
        
        //Image View
        let imageMaskPath = UIBezierPath(roundedRect: movieImg.bounds,
                                         byRoundingCorners: [.bottomLeft, .bottomRight, .topLeft, .topRight],
                                         cornerRadii: CGSize(width: CGFloat(radius), height: CGFloat(radius)))
        
        let imageShape = CAShapeLayer()
        imageShape.path = imageMaskPath.cgPath
        movieImg.layer.mask = imageShape
    }
}
