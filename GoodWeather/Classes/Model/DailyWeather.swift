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
    var main: String?
    var dt: String?
    
    static func parseJSON(data: NSData) -> [DailyWeather] {
        let json = JSON(data: data)
        
        var dailyWeather = [DailyWeather]()
        
        let count = json["cnt"].intValue
        
        for i in 0..<count {
            
            var weather = DailyWeather()
            
            if let
                id = json["city"]["id"].int,
                lon = json["city"]["coord"]["lon"].double,
                lat = json["city"]["coord"]["lat"].double,
                name = json["city"]["name"].string,
                cnt = json["cnt"].int,
                description = json["list"][i]["weather"][0]["description"].string,
                icon = json["list"][i]["weather"][0]["icon"].string,
                humidity = json["list"][i]["humidity"].double,
                pressure = json["list"][i]["pressure"].double,
                day = json["list"][i]["temp"]["day"].double,
                eve = json["list"][i]["temp"]["eve"].double,
                morn = json["list"][i]["temp"]["morn"].double,
                night = json["list"][i]["temp"]["night"].double,
                min = json["list"][i]["temp"]["min"].double,
                max = json["list"][i]["temp"]["max"].double,
                main = json["list"][i]["weather"][0]["main"].string,
                dt = json["list"][i]["dt"].int
            {
                weather.id = id
                weather.lon = lon
                weather.lat = lat
                weather.name = name
                weather.cnt = cnt
                weather.description = description
                weather.icon = icon
                weather.humidity = humidity
                weather.pressure = pressure
                weather.day = calcKelvin(day)
                weather.eve = calcKelvin(eve)
                weather.morn = calcKelvin(morn)
                weather.night = calcKelvin(night)
                weather.min = calcKelvin(min)
                weather.max = calcKelvin(max)
                weather.main = main
                weather.dt = translateUnixTime(dt)
            }
            
            dailyWeather.append(weather)
            
        }
        
        print(dailyWeather)
        
        return dailyWeather
    }
    
    static func calcKelvin(temp: Double) -> Double {
        return floor(temp - 273.15)
    }
    
    static func translateUnixTime(dt: Int) -> String? {
        let date = NSDate(timeIntervalSince1970: Double(dt))
        let format = NSDateFormatter()
        format.dateFormat = "MM/dd"
        return format.stringFromDate(date)
    }
}