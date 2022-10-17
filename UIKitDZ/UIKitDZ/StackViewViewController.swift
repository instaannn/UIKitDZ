//
//  StackViewViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 16.10.2022.
//

import UIKit

/// Экран со светофором StackView
final class StackViewViewController: UIViewController {
    
    // MARK: - Visual Components
    
    private lazy var colorsStackView = makeStackView()
    private lazy var redView = makeView(color: .systemRed)
    private lazy var yellowView = makeView(color: .systemYellow)
    private lazy var greenView = makeView(color: .systemGreen)
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setBorderAndSpacingSize()
    }
    
    // MARK: - Private methods
    
    private func setBorderAndSpacingSize() {
        colorsStackView.spacing = 15
        colorsStackView.layoutMargins = UIEdgeInsets(
            top: 15,
            left: 15,
            bottom: 15,
            right: 15
        )
        colorsStackView.isLayoutMarginsRelativeArrangement = true
    }
}

// MARK: - setupUI

private extension StackViewViewController {
    
    func setupUI() {
        addViews()
        setUpConstraints()
    }
    
    func addViews() {
        view.addSubview(colorsStackView)
    }
    
    func setUpConstraints() {
        colorsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorsStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            colorsStackView.widthAnchor.constraint(equalTo: colorsStackView.heightAnchor, multiplier: 1/3),
            colorsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - Factory

private extension StackViewViewController {
    
    func makeStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [redView, yellowView, greenView])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.backgroundColor = .black
        return stackView
    }
    
    func makeView(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        return view
    }
}
