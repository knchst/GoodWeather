//
//  APIClient.swift
//  GoodWeather
//
//  Created by Kenichi Saito on 12/5/15.
//  Copyright © 2015 Kenichi Saito. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    
    init() {
        
    }
    
    static let sharedInstance = APIClient()
    
    func getCurrentWeather(lat: Double, lon: Double, callback: ((NSError?, NSData?) -> ())) {
        
        let params = [
            "lat": String(lat),
            "lon": String(lon),
            "appid": appId
        ]
        
        Alamofire.request(.GET, baseCurrentURL, parameters: params)
            .responseJSON { response in
                
//                print(response.request)
//                print(response.response)
//                print(response.data)
//                print(response.result.value)
                
                switch response.result {
                case .Success:
                    if let data = response.data {
                        callback(nil, data)
                    }
                case .Failure(let error):
                    print(error)
                    callback(error, nil)
                }
        }
    }
    
    func getDailyWeather(lat: Double, lon: Double, callback: ((NSError?, NSData?) -> ())) {
        
        let params = [
            "lat": String(lat),
            "lon": String(lon),
            "appid": appId,
            "cnt": "7"
        ]
        
        Alamofire.request(.GET, baseDailyURL, parameters: params)
            .responseJSON { response in
                
//                print(response.request)
//                print(response.response)
//                print(response.data)
//                print(response.result.value)
                
                switch response.result {
                case .Success:
                    if let data = response.data {
                        callback(nil, data)
                    }
                case .Failure(let error):
                    print(error)
                    callback(error, nil)
                }
        }
    }
}