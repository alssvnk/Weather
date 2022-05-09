
import UIKit

class WeatherByDayCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    // MARK: - Properties
    class var identifier: String {
        String(describing: self)
    }
    
    class var nib: UINib {
        UINib(nibName: self.identifier, bundle: nil)
    }
    
    // MARK: - Setup
    func configure(model: WeatherByDay?) {
        guard let model = model else { return }
        self.dayLabel.text = model.timestamp
        self.weatherIcon.image = model.state.image
        self.minTempLabel.text = model.minTemp + String.degree
        self.maxTempLabel.text = model.maxTemp + String.degree
    }
}
