//
//  Weather.swift
//  GoodWeather
//
//  Created by Kenichi Saito on 12/5/15.
//  Copyright © 2015 Kenichi Saito. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Weather {
    var id: Int?
    var lon: Double?
    var lat: Double?
    var main: String?
    var description: String?
    var icon: String?
    var temp: Double?
    var pressure: Double?
    var humidity: Double?
    var temp_min: Double?
    var temp_max: Double?
    
    static func parseJSON(data: NSData) -> Weather {
        let json = JSON(data: data)
        var weather = Weather()
        
        if let
            id = json["id"].int,
            lon = json["coord"]["lon"].double,
            lat = json["coord"]["lat"].double,
            main = json["weather"][0]["main"].string,
            description = json["weather"][0]["description"].string,
            icon = json["weather"][0]["icon"].string,
            temp = json["main"]["temp"].double,
            pressure = json["main"]["pressure"].double,
            humidity = json["main"]["humidity"].double,
            temp_max = json["main"]["temp_max"].double,
            temp_min = json["main"]["temp_min"].double
        {
            weather.id = id
            weather.lon = lon
            weather.lat = lat
            weather.main = main
            weather.description = description
            weather.icon = icon
            weather.temp = temp
            weather.pressure = pressure
            weather.humidity = humidity
            weather.temp_max = temp_max
            weather.temp_min = temp_min
        }
        
        print(weather)
        
        return weather
    }
}