
import UIKit

class WeatherByHourCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    // MARK: - Properties
    class var identifier: String {
        String(describing: self)
    }
    
    class var nib: UINib {
        UINib(nibName: self.identifier, bundle: nil)
    }
    
    func configure(model: WeatherByHour?) {
        guard let model = model else { return }
        self.weatherIcon.image = WeatherState.init(rawValue: model.state.rawValue)?.image
        self.timeLabel.text = model.timestamp
        self.tempLabel.text = model.temperature + String.degree
    }
}
