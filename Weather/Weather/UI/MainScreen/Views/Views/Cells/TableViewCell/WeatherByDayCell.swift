//
//  WeatherByDayCell.swift
//  Weather
//
//  Created by Alisiya on 7.05.22.
//

import UIKit

class WeatherByDayCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    func configure(model: WeatherByDay?) {
        guard let model = model else { return }
        self.dayLabel.text = model.timestamp
        self.minTempLabel.text = model.minTemp + String.degree
        self.maxTempLabel.text = model.maxTemp + String.degree
    }
    
}
