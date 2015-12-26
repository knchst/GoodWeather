//
//  SettingsTableViewController.swift
//  GoodWeather
//
//  Created by Kenichi Saito on 12/25/15.
//  Copyright © 2015 Kenichi Saito. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellTitle = [
        "UNITS",
        "NUMBER OF DAYS",
        "CREDIT"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clearColor()
        tableView.separatorStyle = .None
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: settingCellIdetifier)
        
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            self.view.backgroundColor = .clearColor()
            
            let blurEffect = UIBlurEffect(style: .Dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.view.frame
            
            tableView.backgroundView = blurEffectView
            
        } else {
            self.view.backgroundColor = .blackColor()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitle.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(settingCellIdetifier, forIndexPath: indexPath)
        cell.backgroundColor = .clearColor()
        cell.selectionStyle = .None
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 25)
        cell.textLabel?.textColor = .whiteColor()
        cell.textLabel?.textAlignment = .Center
        cell.textLabel?.text = cellTitle[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0: units()
        case 1: numberOfDays()
        case 2: print("")
        default: return
        }
    }
    
    func units() {
        let actionSheet = UIAlertController(title: "UNITS", message: "", preferredStyle: .ActionSheet)
        
        actionSheet.addAction(
            UIAlertAction(title: "Celsius", style: .Default, handler: {(action) in
                print(action.title)
                Utility.changeUnitsSetting(true)
            })
        )
        actionSheet.addAction(
            UIAlertAction(title: "Fahrenheit", style: .Default, handler: {(action) in
                print(action.title)
                Utility.changeUnitsSetting(false)
            })
        )
        actionSheet.addAction(
            UIAlertAction(title: "Cancel", style: .Cancel, handler: {(action) in
                print(action.title)
            })
        )
        
        self.navigationController?.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func numberOfDays() {
        let actionSheet = UIAlertController(title: "NUMBER OF DAYS", message: "", preferredStyle: .ActionSheet)
        
        actionSheet.addAction(
            UIAlertAction(title: "5 Days", style: .Default, handler: {(action) in
                print(action.title)
                Utility.changeNumberOfDaysSetting(5)
            })
        )
        actionSheet.addAction(
            UIAlertAction(title: "7 Days", style: .Default, handler: {(action) in
                print(action.title)
                Utility.changeNumberOfDaysSetting(7)
            })
        )
        actionSheet.addAction(
            UIAlertAction(title: "9 Days", style: .Default, handler: {(action) in
                print(action.title)
                Utility.changeNumberOfDaysSetting(9)
            })
        )
        actionSheet.addAction(
            UIAlertAction(title: "Cancel", style: .Cancel, handler: {(action) in
                print(action.title)
            })
        )
        
        self.navigationController?.presentViewController(actionSheet, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeAction(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
}