//
//  UIButton+Extension.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 29.09.2022.
//

import UIKit.UIButton

///  Главна кнопка для всех экранов
extension UIButton {
    
    func mainButton(text: String, xCoordinate: Int, yCoordinate: Int) {
        setTitle(text, for: .normal)
        backgroundColor = UIColor(displayP3Red: 227/252, green: 30/252, blue: 35/252, alpha: 1)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "AlumniSans-SemiBold", size: 20)
        frame = CGRect(x: xCoordinate, y: yCoordinate, width: 344, height: 50)
        layer.cornerRadius = frame.height / 2
    }
}
