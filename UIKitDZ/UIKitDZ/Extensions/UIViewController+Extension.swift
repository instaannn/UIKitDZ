//
//  UIViewController+Extension.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 07.10.2022.
//

import UIKit

/// Универсальный алерт контроллер
extension UIViewController {
    
    func showAlert(title: String, message: String, label: UILabel) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "OK", style: .default) { _ in
            label.text = alertController.textFields?.first?.text
        }
        alertController.addTextField()
        alertController.addAction(alertOk)
        present(alertController, animated: true, completion: nil)
    }
}
