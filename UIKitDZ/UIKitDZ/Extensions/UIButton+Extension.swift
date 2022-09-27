//
//  UIButton+Extension.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 27.09.2022.
//

import UIKit.UIButton

extension UIButton {
    
    func mainButton(text: String) {
        setTitle(text, for: .normal)
        backgroundColor = .orange
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 20)
        frame = CGRect(x: 70, y: 753, width: 273, height: 50)
        layer.cornerRadius = frame.height / 2
    }
}
