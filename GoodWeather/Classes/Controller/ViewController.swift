//
//  ViewController.swift
//  GoodWeather
//
//  Created by Kenichi Saito on 12/5/15.
//  Copyright © 2015 Kenichi Saito. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ModelManager.sharedInstance.getDailyWeather(35, lon: 139, callback: {(error) in
            if error == nil {
                // reload table
            } else {
                print(error)
                // Show alert
            }
        })
        
        ModelManager.sharedInstance.getWeather(35, lon: 139, callback: {(error, weather) in
            print(weather)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

