//
//  CompositionViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 30.09.2022.
//

import UIKit
/// Экран состава
final class CompositionViewController: UIViewController {
    
    // MARK: - Public properties

    var pizza: Pizza?
    
    // MARK: - Private properties

    private lazy var textLabel = makeLabel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
}

// MARK: - SetupUI

private extension CompositionViewController {
    
    func setupUI() {
        view.addSubview(textLabel)
    }
}

// MARK: - Factory

private extension CompositionViewController {
    
    func makeLabel() -> UILabel {
        let label = UILabel()
        label.text = pizza?.composition
        label.frame = CGRect(x: 29, y: 140, width: 355, height: 330)
        label.numberOfLines = 0
        label.font = UIFont(name: "AlumniSans-Light", size: 25)
        return label
    }
}
