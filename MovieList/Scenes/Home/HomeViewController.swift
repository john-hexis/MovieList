//
//  HomeViewController.swift
//  MovieList
//
//  Created by John Harries on 1/10/17.
//  Copyright © 2017 MyPrivate. All rights reserved.
//
import UIKit
import Foundation
import Alamofire
import AlamofireImage

class HomeViewController: UIViewController {
    @IBOutlet weak var HomeMovieList: UITableView!
    
    fileprivate var _refreshControl: UIRefreshControl = UIRefreshControl()
    fileprivate var _continueControl: UIRefreshControl = UIRefreshControl()
    fileprivate var movieItems: [MovieItem]!
    fileprivate var movieSections: [MovieItemSection]!
    fileprivate var moviePage: Int!
    fileprivate var homeSrvc: HomeService = HomeService()
    fileprivate var nav: NavHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadElements()
        self.loadMovieList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeViewController {
    var refreshControl: UIRefreshControl {
        get {
            return self._refreshControl
        }
    }
    
    var continueControl: UIRefreshControl {
        get {
            return self._continueControl
        }
    }
    
    fileprivate func loadElements() {
        if (NavHelper.Views.root == nil) {
            NavHelper.Views.root = self
        }
        
        self.moviePage = 1
        self.movieItems = [MovieItem]()
        self.movieSections = [MovieItemSection]()
        self.nav = NavHelper()
        
        let movieListCell = UINib(nibName: "MovieListItem", bundle: nil)
        self.HomeMovieList.register(movieListCell, forCellReuseIdentifier: "MovieListItem")
        let movieListHeader = UINib(nibName: "MovieListHeader", bundle: nil)
        self.HomeMovieList.register(movieListHeader, forHeaderFooterViewReuseIdentifier: "MovieListHeader")
        let movieBlank = UINib(nibName: "MovieBlankList", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        self.HomeMovieList.backgroundView = movieBlank
        
        self.HomeMovieList.delegate = self
        self.HomeMovieList.dataSource = self
        
        self.refreshControl.addTarget(self, action: #selector(self.resetElements), for: UIControlEvents.valueChanged)
        self.HomeMovieList.addSubview(self.refreshControl)
    }
    
    @objc fileprivate func resetElements() {
        self.movieItems = [MovieItem]()
        self.movieSections = [MovieItemSection]()
        self.loadMovieList()
    }
    
    fileprivate func loadMovieList() {
        self.moviePage = 1
        if !(self.refreshControl.isRefreshing) {
            self.refreshControl.beginRefreshing()
        }
        self.homeSrvc.GetMovieList(api: AppSettings.ApiKey.Value, releaseDate: Date.toString(toFormat: "yyyy-MM-dd", date: Date()), sortBy: .ReleaseDateDESC, page: self.moviePage) { (data) in
            self.movieItems = MovieItem.ConvertRange(data: data)
            self.HomeMovieList.reloadData()
            if (self.refreshControl.isRefreshing) {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    fileprivate func nextMovieList() {
        self.moviePage = self.moviePage + 1
        self.homeSrvc.GetMovieList(api: AppSettings.ApiKey.Value, releaseDate: Date.toString(toFormat: "yyyy-MM-dd", date: Date()), sortBy: .ReleaseDateDESC, page: self.moviePage) { (data) in
            let nextData = MovieItem.ConvertRange(data: data)
            var previousCount = self.movieItems.count
            self.movieItems.append(contentsOf: nextData)
            self.HomeMovieList.beginUpdates()
            var newIndexPath = [IndexPath]()
            for _ in nextData {
                newIndexPath.append(IndexPath(row: previousCount, section: 0))
                previousCount = previousCount + 1
            }
            self.HomeMovieList.insertRows(at: newIndexPath, with: UITableViewRowAnimation.bottom)
            self.HomeMovieList.endUpdates()
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListItem", for: indexPath) as! MovieListItem
        let movie = self.movieItems[indexPath.row]
        cell.movieTitle.text = movie.MovieTitle
        cell.moviePop.text = "\(movie.MoviePopularity!)"
        cell.movieImagePath = movie.MovieImagePath
        if movie.MovieImagePath != "" {
            Alamofire.request(ServiceURL.MovieImage.Value.replacingOccurrences(of: "{0}", with: movie.MovieImagePath!)).responseImage { response in
                if let image = response.result.value {
                    if ServiceURL.MovieImage.Value.replacingOccurrences(of: "{0}", with: cell.movieImagePath) == response.response?.url?.absoluteString {
                        cell.movieImg.image = image as UIImage
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.movieItems.count > 0 {
            self.HomeMovieList.backgroundView = nil
        }
        return self.movieItems.count
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(UIScreen.main.bounds.width * 0.8)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.movieItems[indexPath.row]
        self.nav.Goto(nextPage: NavPage.Detail, data: MovieDetailNavData(movieId: movie.MovieId!))
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MovieListHeader") as! MovieListHeader
        
        return header
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.movieItems.count - 1 {
            self.nextMovieList()
        }
    }
}

extension HomeViewController: NavProtocol {
    func afterNavigate(data: NavDataProtocol?) {
        
    }
}
