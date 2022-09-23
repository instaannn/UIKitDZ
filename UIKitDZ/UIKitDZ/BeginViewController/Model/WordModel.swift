//
//  WordModel.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 22.09.2022.
//

import Foundation

import UIKit

/// модель обработки слов
struct Word {
    
    func makeWord(text: String) -> String {
        switch text {
        case "leohl":
            return "Hello"
        default:
            return "Не знаю такого слова"
        }
    }
}
