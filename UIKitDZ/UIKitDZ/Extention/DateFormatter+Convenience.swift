//
//  DateFormatter+Convenience.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 25.09.2022.
//

import Foundation

// MARK: - DateFormatter

extension DateFormatter {
    
    static let dayWithTimeDateLongFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy EEE. HH:mm"
        formatter.locale = Locale(identifier: "ru")
        return formatter
    }()
}
