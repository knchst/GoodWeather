//
//  ModelManager.swift
//  GoodWeather
//
//  Created by Kenichi Saito on 12/6/15.
//  Copyright © 2015 Kenichi Saito. All rights reserved.
//

import Foundation

class ModelManager {
    
    var dailyWeather = [DailyWeather]()
    
    init() {
        
    }
    
    static let sharedInstance = ModelManager()
    
    func getWeather(lat: Double, lon: Double, callback: ((NSError?, Weather?) -> ())) {
        APIClient.sharedInstance.getCurrentWeather(lat, lon: lon, callback: {(error, data) in
            if error == nil {
                let weather = Weather.parseJSON(data!)
                callback(nil, weather)
            } else {
                callback(error, nil)
            }
        })
    }

    func getDailyWeather(lat: Double, lon: Double, callback: ((NSError?) -> ())) {
        weak var weakSelf = self
        
        APIClient.sharedInstance.getDailyWeather(lat, lon: lon, callback: {(error, data) in
            if error == nil {
                let dailyWeather = DailyWeather.parseJSON(data!)
                weakSelf?.dailyWeather = dailyWeather
                callback(nil)
            } else {
                callback(error)
            }
        })
    }
}