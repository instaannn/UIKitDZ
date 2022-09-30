//
//  DateFormatter+Convenience.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 27.09.2022.
//

import Foundation

// MARK: - DateFormatter
extension DateFormatter {

    static let dayDateLongFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        formatter.locale = Locale(identifier: "ru")
        return formatter
    }()
}
