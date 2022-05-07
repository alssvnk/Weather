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
    
    func configure(model: WeatherDayResponse?) {
        guard let model = model else { return }
        self.dayLabel.text = String(model.timestamp)
        self.minTempLabel.text = String(model.minTemp)
        self.maxTempLabel.text = String(model.maxTemp)
    }
    
}
