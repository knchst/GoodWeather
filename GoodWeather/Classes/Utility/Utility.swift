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
}