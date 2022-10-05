//
//  UIFont+Extension.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 05.10.2022.
//

import UIKit.UIFont
/// Расширение для текста bold
extension UIFont {
    
    var bold: UIFont { return withWeight(.bold) }

    private func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]

        traits[.weight] = weight

        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName

        let descriptor = UIFontDescriptor(fontAttributes: attributes)

        return UIFont(descriptor: descriptor, size: pointSize)
    }
}
