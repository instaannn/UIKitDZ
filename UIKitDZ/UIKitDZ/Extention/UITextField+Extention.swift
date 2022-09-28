//
//  UITextField+Extention.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 25.09.2022.
//

import UIKit.UITextField

// MARK: - UITextField
/// нижнее подчеркивание текстфилда
extension UITextField {

    // MARK: - Public methods
    
    func setBottomBorder(color: UIColor) {
        borderStyle = .none
        layer.backgroundColor = UIColor.white.cgColor
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
    }
}
