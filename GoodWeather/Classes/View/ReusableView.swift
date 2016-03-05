//
//  ReusableView.swift
//  GoodWeather
//
//  Created by Kenichi Saito on 1/31/16.
//  Copyright © 2016 Kenichi Saito. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UITableViewCell: ReusableView {

}
