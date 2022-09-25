//
//  UIViewController+Extention.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 25.09.2022.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, textField: UITextField) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let alertOk = UIAlertAction(title: "OK", style: .default) { _ in
            textField.text = alertController.textFields?.first?.text
        }
        alertController.addTextField()
        alertController.addAction(alertCancel)
        alertController.addAction(alertOk)
        present(alertController, animated: true, completion: nil)
    }
}
