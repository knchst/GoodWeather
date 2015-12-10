//
//  ViewController.swift
//  GoodWeather
//
//  Created by Kenichi Saito on 12/5/15.
//  Copyright © 2015 Kenichi Saito. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.requestLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let
            lat = locations.first?.coordinate.latitude,
            lon = locations.first?.coordinate.longitude
        {
            refreshWeather(lat, lon: lon)
        } else {
            return
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status != .AuthorizedWhenInUse {
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func refreshWeather(lat: Double, lon: Double) {
        
        ModelManager.sharedInstance.getDailyWeather(lat, lon: lon, callback: {(error) in
            if error == nil {
                // reload table
            } else {
                print(error)
                // Show alert
            }
        })
        
        ModelManager.sharedInstance.getWeather(lat, lon: lon, callback: {(error, weather) in
            print(weather)
        })
    }
}

