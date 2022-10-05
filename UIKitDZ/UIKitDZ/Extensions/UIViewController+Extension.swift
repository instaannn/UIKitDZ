//
//  UIViewController+Extension.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 03.10.2022.
//

import UIKit
/// Вызов алерта с кнопкой Ok
extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: .none)
        alert.addAction(action)
        present(alert, animated: true, completion: .none)
    }
}
