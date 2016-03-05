//
//  NibLoadableView.swift
//  GoodWeather
//
//  Created by Kenichi Saito on 1/31/16.
//  Copyright © 2016 Kenichi Saito. All rights reserved.
//

import UIKit

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
}

extension UITableViewCell: NibLoadableView {
    
}