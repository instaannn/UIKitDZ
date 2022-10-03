//
//  UIStoryboard+Extension.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 03.10.2022.
//

import UIKit.UIStoryboard
/// Создание вью контроллера с идентификатором сториборда
extension UIStoryboard {
    
    static let main = UIStoryboard(name: "Main", bundle: nil)
    
    func instantiateViewControllerWithIdentifier<T>(_ identifier: T.Type) -> T? {
        let identifier = String(describing: identifier)
        return instantiateViewController(withIdentifier: identifier) as? T
    }
}
