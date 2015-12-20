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
        let gradientColors: [[CGColor]] = [
            [lightBlueColor.CGColor, lightPinkColor.CGColor],
            [lightBlueColor.CGColor, lightGreenColor.CGColor],
            [darkBlueColor.CGColor, lightGreenColor.CGColor],
            [lightPinkColor.CGColor, lightGreenColor.CGColor]
        ]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors[random() % gradientColors.count]
        gradientLayer.frame = frame
        
        let gradientImage = Utility.imageFromLayer(gradientLayer)
        
        return gradientImage
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