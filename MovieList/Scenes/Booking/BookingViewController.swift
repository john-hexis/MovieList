//
//  BookingViewController.swift
//  MovieList
//
//  Created by John Harries on 2/10/17.
//  Copyright © 2017 MyPrivate. All rights reserved.
//

import Foundation
import UIKit

class BookingViewControiller: UIViewController {
    
    @IBOutlet weak var WebView: UIWebView!
    
    fileprivate var nav: NavHelper = NavHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadElements()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func btnBackTapped(_ sender: Any) {
        nav.GoBack()
    }
    
}

extension BookingViewControiller {
    fileprivate func loadElements() {
        self.WebView.loadRequest(URLRequest(url: URL(string: ServiceURL.MovieBook.Value)!))
    }
}

extension BookingViewControiller: NavProtocol {
    func afterNavigate(data: NavDataProtocol?) {
        
    }
}
