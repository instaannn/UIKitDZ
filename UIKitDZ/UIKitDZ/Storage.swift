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
    
    public lazy var defaults = UserDefaults.standard
    
    // MARK: - Public methods
    
    public func saveLoginPass(text: String, forKey: String) {
        defaults.set(text, forKey: forKey)
    }
    
    public func checkLoginPass(forKey: String) -> String {
        let name = defaults.value(forKey: forKey) as? String ?? ""
        return name
    }
}
