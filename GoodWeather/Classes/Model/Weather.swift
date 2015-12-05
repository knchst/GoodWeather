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
        
        if let id = json["id"].int {
            weather.id = id
        }
        
        if let lon = json["coord"]["lon"].double {
            weather.lon = lon
        }
        
        if let lat = json["coord"]["lat"].double {
            weather.lat = lat
        }
        
        if let main = json["weather"][0]["main"].string {
            weather.main = main
        }
        
        if let description = json["weather"][0]["description"].string {
            weather.description = description
        }
        
        if let icon = json["weather"][0]["icon"].string {
            weather.icon = icon
        }
        
        if let temp = json["main"]["temp"].double {
            weather.temp = temp
        }
        
        if let pressure = json["main"]["pressure"].double {
            weather.pressure = pressure
        }
        
        if let humidity = json["main"]["humidity"].double {
            weather.humidity = humidity
        }
        
        if let temp_max = json["main"]["temp_max"].double {
            weather.temp_max = temp_max
        }
        
        if let temp_min = json["main"]["temp_min"].double {
            weather.temp_min = temp_min
        }
        
        print(weather)
        
        return weather
    }
}