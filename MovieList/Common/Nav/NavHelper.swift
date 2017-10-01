//
//  NavHelper.swift
//  PPBeacon
//
//  Created by John Harries on 11/7/17.
//  Copyright © 2017 SierraSolutions. All rights reserved.
//

import Foundation
import UIKit

class NavHelper {
    struct Views {
        static var stacks = [UIViewController]()
        static var root: UIViewController?
    }
    
    func Goto(nextPage: NavPage, data: NavDataProtocol?) -> Void {
        var nextView = UIStoryboard(name: nextPage.Storyboard, bundle: nil).instantiateViewController(withIdentifier: nextPage.PageID)
        for view in Views.stacks {
            if view.restorationIdentifier == nextPage.PageID {
                nextView = view
            }
        }
        var currView = Views.stacks.last
        if (currView == nil) {
            currView = Views.root
        }
        Views.stacks.append(nextView)
        currView?.present(nextView, animated: true, completion: {
            (nextView as! NavProtocol).afterNavigate(data: data)
        })
    }
    
    func GoBack() -> Void {
        var currView = Views.stacks.popLast()
        if (currView == nil) {
            currView = Views.root
        }
        var nextView = Views.stacks.last
        if (nextView == nil) {
            nextView = Views.root
        }
        currView?.dismiss(animated: true, completion: {
            (nextView as! NavProtocol).afterNavigate(data: nil)
        })
    }
}
