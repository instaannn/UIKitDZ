//
//  File.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 26.09.2022.
//

import UIKit

extension UIViewController {
    
     func showAlert(title: String, message: String) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let action = UIAlertAction(title: "Ok", style: .cancel, handler: .none)
           
           alert.addAction(action)
           present(alert, animated: true, completion: .none)
       }
}
