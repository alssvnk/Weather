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
    
    func configure(model: WeatherByHour?) {
        guard let model = model else { return }
        self.weatherIcon.image = WeatherState.init(rawValue: model.state.rawValue)?.image
        self.timeLabel.text = model.timestamp
        self.tempLabel.text = model.temperature + String.degree
    }
}
