
import UIKit

class CurrentWeatherView: UIView {

    @IBOutlet weak private var cityNameLabel: UILabel!
    @IBOutlet weak private var currentTempLabel: UILabel!
    
    var state: WeatherState?

    func setupView(model: WeatherAtMoment?) {
        guard let model = model else { return }
        self.cityNameLabel.text = model.city
        self.currentTempLabel.text = model.temperature + String.degree
    }
}
