//
//  NetworkUtils.swift
//  SmartBus
//
//  Created by Nick Demenko on 30.03.17.
//  Copyright © 2017 Nick Demenko. All rights reserved.
//

import Foundation
import AFNetworking

class NetworkUtils{
    
    static func getJSON(_ callback: @escaping (Bool, String, [NSDictionary]?) -> Void) {
        
        let url = "http://smartbus.gmoby.org/web/index.php/api/trips?from_date=20151231&to_date=20180301"
        
        let manager = AFHTTPSessionManager()
        manager.get(
            url,
            parameters: nil,
            progress: nil,
            success: { (sessionDataTask: URLSessionDataTask, response: Any?) in
                
                if let res = response as? NSDictionary {
                    if let data = res["data"] as? [NSDictionary] {
                        callback(true, "", data)
                    }
                    else {
                        callback(false, "cannot cast response to [NSDictionary]", nil)
                    }
                }
                else {
                    callback(false, "cannot cast response to NSDictionary", nil)
                }
        },
            failure: { (task, error) in
                print("Error: " + error.localizedDescription)
                callback(false, "loading data failed", nil)
        })
    }
}
