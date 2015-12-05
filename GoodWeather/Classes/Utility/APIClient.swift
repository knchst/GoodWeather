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
    
    var weather: Weather!
    
    init() {
        
    }
    
    static let sharedInstance = APIClient()
    
    func getCurrentWeather(lat: Double, lon: Double) {
        
        let params = [
            "lat": String(lat),
            "lon": String(lon),
            "appid": appId
        ]
        
        Alamofire.request(.GET, baseURL, parameters: params)
            .responseJSON { response in
                print(response.request)
                print(response.response)
                print(response.data)
                print(response.result)
                
                switch response.result {
                case .Success:
                    if let data = response.data {
                        self.weather = Weather.parseJSON(data)
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
}