//
//  UIAlertWorker.swift
//  weather
//
//  Created by David Parizek on 12/11/2020.
//

import UIKit

final class UIAlertWorker {
    static func showAlert(title: String, message: String?, presentingController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        presentingController.present(alert, animated: true, completion: nil)
    }
}
