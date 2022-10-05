//
//  Storage.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 03.10.2022.
//

import UIKit

// MARK: - SaveLoginPass
/// Хранение и проверка логина и пароля
final class SaveLoginPass {
    
    // MARK: - Public properties
    
    static var shared = SaveLoginPass()
    
    lazy var defaults = UserDefaults.standard
    
    // MARK: - Public methods
    
    func saveLoginPass(text: String, forKey: String) {
        defaults.set(text, forKey: forKey)
    }
    
    func checkLoginPass(forKey: String) -> String {
        let name = defaults.value(forKey: forKey) as? String ?? ""
        return name
    }
}
