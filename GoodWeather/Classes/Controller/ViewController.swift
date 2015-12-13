//
//  ViewController.swift
//  GoodWeather
//
//  Created by Kenichi Saito on 12/5/15.
//  Copyright © 2015 Kenichi Saito. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableViewTopConstrait: NSLayoutConstraint!
    
    var manager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.requestLocation()
        
        tableViewTopConstrait.constant = UIScreen.mainScreen().bounds.size.height / 2 - 64
        
        tableView.dataSource = self
        tableView.delegate = self
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelManager.sharedInstance.dailyWeather.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(dailyWeatherCellIdetifier, forIndexPath: indexPath) as! DailyWeatherTableViewCell
        let dailyWeather = ModelManager.sharedInstance.dailyWeather[indexPath.row]
        cell.setData(dailyWeather)
        return cell
    }
    
    func refreshWeather(lat: Double, lon: Double) {
        
        weak var weakSelf = self
        
        ModelManager.sharedInstance.getDailyWeather(lat, lon: lon, callback: {(error) in
            if error == nil {
                weakSelf?.tableView.reloadData()
            } else {
                print(error)
                // Show alert
            }
        })
        
        ModelManager.sharedInstance.getWeather(lat, lon: lon, callback: {(error, weather) in
            if error == nil {
                weakSelf?.nameLabel.text = weather?.name!
                weakSelf?.minLabel.text = String(format: "%g℃", (weather?.temp_min)!)
                weakSelf?.maxLabel.text = String(format: "%g℃", (weather?.temp_max)!)
                weakSelf?.imageView.image = UIImage(named: (weather?.main)!)
                weakSelf?.descriptionLabel.text = weather?.description!
            } else {
                print(error)
                // show alert
            }
        })
    }
}

