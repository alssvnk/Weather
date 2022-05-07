//
//  AlertPresentable.swift
//  Weather
//
//  Created by Alisiya on 8.05.22.
//

import Foundation
import UIKit

protocol AlertPresentable {
    func showGoSettingsAlert(controller: UIViewController, title: String, message: String, completion: (() -> ())?)
    func showSystemAlert(controller: UIViewController, title: String, message: String, completion: (() -> ())?)
}

extension AlertPresentable {
    
    func showGoSettingsAlert(controller: UIViewController, title: String, message: String, completion: (() -> ())?) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        }))

        controller.present(alert, animated: true, completion: completion)
    }
    
    func showSystemAlert(controller: UIViewController, title: String, message: String, completion: (() -> ())?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        controller.present(alert, animated: true, completion: completion)
    }
    
}
