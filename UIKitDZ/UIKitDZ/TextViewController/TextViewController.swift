//
//  TextViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 27.09.2022.
//

import UIKit
/// Экран для отображения текста
final class TextViewController: UIViewController {
    
    // MARK: - Public properties
    
    var text = ""
    
    // MARK: - Private properties
        
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 32, y: 398, width: 350, height: 100)
        label.text = text
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-SemiBold", size: 25)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textLabel)
        view.backgroundColor = .white
    }
}
