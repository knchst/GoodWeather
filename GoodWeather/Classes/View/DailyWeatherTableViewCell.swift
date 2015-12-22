//
//  DailyWeatherTableViewCell.swift
//  GoodWeather
//
//  Created by Kenichi Saito on 12/11/15.
//  Copyright © 2015 Kenichi Saito. All rights reserved.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        weatherImageView.tintColor = .whiteColor()
        self.selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(dailyWeather: DailyWeather) {
        
        weatherImageView.image = UIImage(named: dailyWeather.main!)?.imageWithRenderingMode(.AlwaysTemplate)
        dateLabel.text = dailyWeather.dt!
        descriptionLabel.text = dailyWeather.description
        tempMaxLabel.text = String(format: "%g°", dailyWeather.max!)
        tempMinLabel.text = String(format: "%g°", dailyWeather.min!)
    }
}
