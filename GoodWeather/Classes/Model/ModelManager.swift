//
//  ModelManager.swift
//  GoodWeather
//
//  Created by Kenichi Saito on 12/6/15.
//  Copyright © 2015 Kenichi Saito. All rights reserved.
//

import Foundation

class ModelManager {
    
    var dailyWeather: [DailyWeather]!
    
    init() {
        
    }
    
    static let sharedInstance = ModelManager()
    
    func getWeather(lat: Double, lon: Double, callback: ((NSError?, Weather?) -> ())) {
        APIClient.sharedInstance.getCurrentWeather(lat, lon: lon, callback: {(error, weather) in
            if error == nil {
                callback(nil, weather)
            } else {
                callback(error, nil)
            }
        })
    }

    func getDailyWeather(lat: Double, lon: Double, callback: ((NSError?) -> ())) {
        weak var weakSelf = self
        
        APIClient.sharedInstance.getDailyWeather(lat, lon: lon, callback: {(error, dailyWeather) in
            if error == nil {
                weakSelf?.dailyWeather = dailyWeather
                callback(nil)
            } else {
                callback(error)
            }
        })
    }
}