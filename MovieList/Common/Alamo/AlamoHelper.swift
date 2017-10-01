//
//  AlamoHelper.swift
//  PPBeacon
//
//  Created by John Harries on 11/7/17.
//  Copyright © 2017 SierraSolutions. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class AlamoHelper {
    private var user: String?
    private var pass: String?
    private let defManager: Alamofire.SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 40
        config.timeoutIntervalForResource = 60
        
        return Alamofire.SessionManager(configuration: config)
    }()
    
    private func ApiCall(method: HTTPMethod, url: URL, params: Parameters, headers: HTTPHeaders, paramEnc: ParameterEncoding, handler: @escaping (DataResponse<Any>) -> Void) -> Void {
        self.defManager.request(url as URLConvertible, method: method, parameters: params, encoding: paramEnc, headers: headers).responseJSON { (response) in
            handler(response)
        }
    }
    
    func get(url: URL, params: Parameters?, success: @escaping (Dictionary<String, AnyObject>) throws -> Void, failure: @escaping () -> Void) -> Void {
        //Change later if any security applied
        var headers: HTTPHeaders = [:]
        var parameters: Parameters = [:]
        headers.updateValue("no-cache", forKey: "cache-control")
        
        if params != nil {
            parameters = params!
        }
        self.ApiCall(method: HTTPMethod.get, url: url, params: parameters, headers: headers, paramEnc: URLEncoding.default) { (response) in
            print("Response Result: \(response.result)")
            print("Response Data: \(String(describing: response.data))")
            print("Response Response: \(String(describing: response.response))")
            
            if response.response?.statusCode == 200 {
                do {
                     if let entity = response.result.value as? Dictionary<String, AnyObject> {
                        try success(entity)
                    }
                } catch let error {
                    print("GET Api Call Error: \(error)")
                }
            }
            else {
                print("GET Api Response Error: \(String(describing: response.error))")
                failure()
            }
        }
    }
    
    func post(url: URL, params: Parameters?, success: @escaping (Dictionary<String, AnyObject>) throws -> Void, failure: @escaping () -> Void) -> Void {
        //Change later if any security applied
        let headers: HTTPHeaders = [:]
        self.ApiCall(method: HTTPMethod.post, url: url, params: params!, headers: headers, paramEnc: JSONEncoding.default) { (response) in
            print("Response Result: \(response.result)")
            print("Response Data: \(String(describing: response.data))")
            print("Response Response: \(String(describing: response.response))")
            
            if response.response?.statusCode == 200 {
                do {
                    if let entity = response.result.value as? Dictionary<String, AnyObject> {
                        try success(entity)
                    }
                } catch let error {
                    print("POST Api Call Error: \(error)")
                }
            }
            else {
                print("POST Api Response Error: \(String(describing: response.error))")
                failure()
            }
        }
    }
}
