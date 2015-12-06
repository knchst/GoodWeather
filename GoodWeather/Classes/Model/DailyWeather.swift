//
//  DailyWeather.swift
//  GoodWeather
//
//  Created by Kenichi Saito on 12/6/15.
//  Copyright © 2015 Kenichi Saito. All rights reserved.
//

import Foundation
import SwiftyJSON

struct DailyWeather {
    var id: Int?
    var lon: Double?
    var lat: Double?
    var cnt: Int?
    var name: String?
    var description: String?
    var icon: String?
    var pressure: Double?
    var humidity: Double?
    var day: Double?
    var eve: Double?
    var morn: Double?
    var night: Double?
    var min: Double?
    var max: Double?
    
    static func parseJSON(data: NSData) -> [DailyWeather] {
        let json = JSON(data: data)
        
        var dailyWeather = [DailyWeather]()
        
        let count = json["cnt"].intValue
        
        for i in 0..<count {
            
            var weather = DailyWeather()
            
            if let id = json["city"]["id"].int {
                weather.id = id
            }
            
            if let lon = json["city"]["coord"]["lon"].double {
                weather.lon = lon
            }
            
            if let lat = json["city"]["coord"]["lat"].double {
                weather.lat = lat
            }
            
            if let name = json["city"]["name"].string {
                weather.name = name
            }
            
            if let cnt = json["cnt"].int {
                weather.cnt = cnt
            }
            
            if let description = json["list"][i]["weather"][0]["description"].string {
                weather.description = description
            }
            
            if let icon = json["list"][i]["weather"][0]["icon"].string {
                weather.icon = icon
            }

            if let humidity = json["list"][i]["humidity"].double {
                weather.humidity = humidity
            }
            
            if let pressure = json["list"][i]["pressure"].double {
                weather.pressure = pressure
            }
            
            if let day = json["list"][i]["temp"]["day"].double {
                weather.day = day
            }
            
            if let eve = json["list"][i]["temp"]["eve"].double {
                weather.eve = eve
            }
            
            if let morn = json["list"][i]["temp"]["morn"].double {
                weather.morn = morn
            }
            
            if let night = json["list"][i]["temp"]["night"].double {
                weather.night = night
            }

            if let min = json["list"][i]["temp"]["min"].double {
                weather.min = min
            }

            if let max = json["list"][i]["temp"]["max"].double {
                weather.max = max
            }
            
            dailyWeather.append(weather)
            
        }
        
        print(dailyWeather)
        
        return dailyWeather
    }
}