//
//  WeatherByHourCell.swift
//  Weather
//
//  Created by Alisiya on 7.05.22.
//

import UIKit

class WeatherByHourCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    func configure(model: WeatherHourResponse?) {
        guard let model = model else { return }
        self.timeLabel.text = String(model.timestamp)
        self.weatherIcon.image = WeatherState.init(rawValue: model.state)?.image
        self.tempLabel.text = String(model.temp)
    }
}
