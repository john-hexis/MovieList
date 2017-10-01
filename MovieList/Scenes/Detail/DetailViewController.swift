//
//  DetailViewController.swift
//  MovieList
//
//  Created by John Harries on 1/10/17.
//  Copyright © 2017 MyPrivate. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class DetailViewController: UIViewController {
    @IBOutlet weak var MovieDetailTable: UITableView!
    
    fileprivate var moviesDetail: MovieDetail!
    fileprivate var movieId: Int64!
    fileprivate var detSrcv: DetailService = DetailService()
    fileprivate var nav: NavHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadElements()
        self.loadMovieDetail()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.nav.GoBack()
    }
    
    @IBAction func btnBuyTixTapped(_ sender: Any) {
        self.nav.Goto(nextPage: NavPage.Booking, data: nil)
    }
}

extension DetailViewController {
    fileprivate func loadElements() {
        self.moviesDetail = MovieDetail()
        self.movieId = 0
        self.nav = NavHelper()
        
        let movieDetailHeaderCell = UINib(nibName: "MovieDetailHeader", bundle: nil)
        self.MovieDetailTable.register(movieDetailHeaderCell, forCellReuseIdentifier: "MovieDetailHeader")
        let movieDetailBodyCell = UINib(nibName: "MovieDetailBody", bundle: nil)
        self.MovieDetailTable.register(movieDetailBodyCell, forCellReuseIdentifier: "MovieDetailBody")
        let movieBlank = UINib(nibName: "MovieBlank", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        self.MovieDetailTable.backgroundView = movieBlank
        
        self.MovieDetailTable.delegate = self
        self.MovieDetailTable.dataSource = self
    }
    
    fileprivate func loadMovieDetail() {
        self.moviesDetail = MovieDetail()
        
        if self.movieId > 0 {
            self.detSrcv.GetMovieDetail(api: AppSettings.ApiKey.Value, movieID: self.movieId) { (data) in
                self.moviesDetail = MovieDetail(data: data)
                self.MovieDetailTable.reloadData()
            }
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailHeader", for: indexPath) as! MovieDetailHeader
            cell.MovieTitle.text = self.moviesDetail.MovieTitle
            cell.MoviePop.text = "\(self.moviesDetail.MoviePopularity!)"
            if self.moviesDetail.MovieImagePath != "" {
                Alamofire.request(ServiceURL.MovieImage.Value.replacingOccurrences(of: "{0}", with: self.moviesDetail.MovieImagePath!)).responseImage { response in
                    if let image = response.result.value {
                        cell.MovieImage.image = image as UIImage
                    }
                }
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailBody", for: indexPath) as! MovieDetailBody
            cell.MovieSynopsis.text = self.moviesDetail.MovieSynopsis!
            cell.MovieGenre.text = self.moviesDetail.MovieGenre!
            cell.MovieDuration.text = self.moviesDetail.MovieDuration!
            cell.MovieLanguage.text = self.moviesDetail.MovieLanguage!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.movieId == 0 {
            return 0
        }
        return 2
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(400)
        } else {
            return CGFloat(400)
        }
    }
}

extension DetailViewController: NavProtocol {
    func afterNavigate(data: NavDataProtocol?) {
        guard let navData = data as? MovieDetailNavData else {
            return
        }
        self.movieId = navData.MovieId!
        self.loadMovieDetail()
    }
}
