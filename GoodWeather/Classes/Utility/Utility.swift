//
//  Utility.swift
//  GoodWeather
//
//  Created by Kenichi Saito on 12/15/15.
//  Copyright © 2015 Kenichi Saito. All rights reserved.
//

import UIKit

class Utility {
    static func hexColor (var hex: String, alpha: CGFloat) -> UIColor {
        hex = hex.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: hex)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red: r, green: g, blue: b, alpha: alpha)
        } else {
            print("invalid hex string")
            return UIColor.whiteColor();
        }
    }
    
    static func imageFromLayer(layer: CAGradientLayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.frame.size)
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
        let renderedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return renderedImage
    }
    
    static func makeGradient(frame: CGRect) -> UIImage {
        let gradientColors = [
            lightBlueColor.CGColor,
            lightPinkColor.CGColor,
            lightGreenColor.CGColor,
            darkBlueColor.CGColor
        ]
        
        let topColor = gradientColors[random() % gradientColors.count]
        let bottomColor = gradientColors[random() % gradientColors.count]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.frame = frame
        
        let gradientImage = Utility.imageFromLayer(gradientLayer)
        
        return gradientImage
    }
    
    static func calcKelvin(temp: Double) -> Double {
        
        let celsius = floor(temp - 273.15)
        
        let units = Utility.getUnitsSetting()
        
        if !units {
            return floor(9 / 5 * celsius + 32)
        }
        
        return celsius
    }
    
    static func translateUnixTime(dt: Int) -> String? {
        let date = NSDate(timeIntervalSince1970: Double(dt))
        let format = NSDateFormatter()
        format.dateFormat = "MM/dd"
        return format.stringFromDate(date)
    }
    
    static func changeUnitsSetting() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let isTrue = defaults.valueForKey("units") as! Bool
        
        if isTrue {
            defaults.setBool(false, forKey: "units")
        } else {
            defaults.setBool(true, forKey: "units")
        }
        
        defaults.synchronize()
        
        print("Current setting is \(defaults.valueForKey("units"))")
    }
    
    static func getUnitsSetting() -> Bool {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        return defaults.valueForKey("units") as! Bool
    }
}