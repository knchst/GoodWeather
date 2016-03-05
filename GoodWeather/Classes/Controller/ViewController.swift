//
//  ViewController.swift
//  GoodWeather
//
//  Created by Kenichi Saito on 12/5/15.
//  Copyright © 2015 Kenichi Saito. All rights reserved.
//

import UIKit
import MapKit
import Walhalla

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableViewTopConstrait: NSLayoutConstraint!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var manager: CLLocationManager!
    var indicator: UIActivityIndicatorView!
    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        update()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelManager.sharedInstance.dailyWeather.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as DailyWeatherTableViewCell
        let dailyWeather = ModelManager.sharedInstance.dailyWeather[indexPath.row]
        cell.setData(dailyWeather)
        return cell
    }
}

// MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    
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
}

// MARK: - Private

extension ViewController {
    private func refreshWeather(lat: Double, lon: Double) {
        
        ModelManager.sharedInstance.getDailyWeather(lat, lon: lon, callback: { [weak self] error in
            if error == nil {
                self?.tableView.reloadData()
                self?.indicator.stopAnimating()
                self?.refreshControl.endRefreshing()
                self?.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
            } else {
                print(error)
                
                self?.indicator.stopAnimating()
                self?.refreshControl.endRefreshing()
                
                let alert = UIAlertController(title: "Error", message: "Oops! Please try again!!", preferredStyle: .Alert)
                let retryAction = UIAlertAction(title: "Try Again!", style: .Default, handler: { action in
                    self?.manager.requestLocation()
                })
                
                alert.addAction(retryAction)
                self?.presentViewController(alert, animated: true, completion: nil)
                
                return
            }
        })
        
        ModelManager.sharedInstance.getWeather(lat, lon: lon, callback: { [weak self] error, weather in
            if error == nil {
                self?.nameLabel.text = weather?.name!
                self?.minLabel.text = String(format: "%g°", (Utility.calcKelvin((weather?.temp_min!)!)))
                self?.maxLabel.text = String(format: "%g°", (Utility.calcKelvin((weather?.temp_max!)!)))
                self?.imageView.image = UIImage(named: (weather?.main)!)?.imageWithRenderingMode(.AlwaysTemplate)
                self?.descriptionLabel.text = weather?.description!
                
                Walhalla.performAnimation((self?.nameLabel)!, duration: 1.0, delay: 0, type: .FadeIn)
                Walhalla.performAnimation((self?.minLabel)!, duration: 1.0, delay: 0, type: .FadeIn)
                Walhalla.performAnimation((self?.maxLabel)!, duration: 1.0, delay: 0, type: .FadeIn)
                Walhalla.performAnimation((self?.imageView)!, duration: 1.0, delay: 0, type: .FadeIn)
                Walhalla.performAnimation((self?.descriptionLabel)!, duration: 1.0, delay: 0, type: .FadeIn)
            } else {
                print(error)
                // show alert
            }
        })
    }
    
    private func configure() {
        
        manager = CLLocationManager()
        manager.delegate = self
        
        tableViewTopConstrait.constant = UIScreen.mainScreen().bounds.size.height / 2 - 64
        
        tableView.dataSource = self
        tableView.separatorColor = .clearColor()
        tableView.register(DailyWeatherTableViewCell.self)
        
        NSTimer.scheduledTimerWithTimeInterval(6, target: self, selector: "transitionBackground", userInfo: nil, repeats: true)
        
        imageView.tintColor = .whiteColor()
        
        backgroundImageView.image = Utility.makeGradient(self.view.frame)
        
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        indicator.center = self.view.center
        indicator.tintColor = .darkGrayColor()
        self.view.addSubview(indicator)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "update", forControlEvents: .ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.tintColor = .darkGrayColor()
        tableView.addSubview(refreshControl)
    }
    
    func transitionBackground() {
        
        let transition = CATransition()
        transition.duration = 3.0
        transition.type = kCATransitionFade
        
        backgroundImageView.layer.addAnimation(transition, forKey: nil)
        backgroundImageView.image = Utility.makeGradient(self.view.frame)
    }
    
    func update() {
        
        if refreshControl.refreshing {
            refreshControl.attributedTitle = NSAttributedString(string: "Loading..")
        } else {
            indicator.startAnimating()
        }
        
        manager.requestLocation()
    }
    
    @IBAction func goSetting(sender: AnyObject) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(settingsViewControllerIdetifier)
        vc.modalPresentationStyle = .OverFullScreen
        self.navigationController?.presentViewController(vc, animated: true, completion: nil)
    }
}

