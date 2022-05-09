
import UIKit

protocol AlertPresentable {
    func showGoSettingsAlert(controller: UIViewController, title: String, message: String, completion: (() -> Void)?)
    func showSystemAlert(controller: UIViewController, title: String, message: String, completion: (() -> Void)?)
}

extension AlertPresentable {
    func showGoSettingsAlert(controller: UIViewController,
                             title: String, message: String,
                             completion: (() -> Void)?) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                      UIApplication.shared.canOpenURL(settingsUrl) else { return }
                UIApplication.shared.open(settingsUrl)
            }))
        DispatchQueue.main.async { [weak controller] in
            controller?.present(alert, animated: true, completion: completion)
        }
    }
    
    func showSystemAlert(controller: UIViewController, title: String, message: String, completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil))
        DispatchQueue.main.async { [weak controller] in
            controller.present(alert, animated: true, completion: completion)
        }
    }
}
