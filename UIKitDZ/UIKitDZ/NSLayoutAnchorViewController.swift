//
//  NSLayoutAnchorViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 16.10.2022.
//

import UIKit

/// Экран со светофором NSLayoutAnchor
final class NSLayoutAnchorViewController: UIViewController {
        
    // MARK: - Visual Components
    
    private lazy var containerView = makeView(color: .black)
    private lazy var redView = makeView(color: .systemRed)
    private lazy var yellowView = makeView(color: .systemYellow)
    private lazy var greenView = makeView(color: .systemGreen)
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - setupUI

private extension NSLayoutAnchorViewController {
    
    func setupUI() {
        addViews()
        setUpConstraints()
    }
    
    func addViews() {
        view.addSubview(containerView)
        [redView, yellowView, greenView].forEach { containerView.addSubview($0) }
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            yellowView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            yellowView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            yellowView.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.14),
            yellowView.heightAnchor.constraint(equalTo: yellowView.widthAnchor),
            
            redView.bottomAnchor.constraint(equalTo: yellowView.topAnchor, constant: -15),
            redView.centerXAnchor.constraint(equalTo: yellowView.centerXAnchor),
            redView.widthAnchor.constraint(equalTo: yellowView.heightAnchor),
            redView.heightAnchor.constraint(equalTo: yellowView.widthAnchor),
            
            greenView.topAnchor.constraint(equalTo: yellowView.bottomAnchor, constant: 15),
            greenView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greenView.widthAnchor.constraint(equalTo: yellowView.heightAnchor),
            greenView.heightAnchor.constraint(equalTo: yellowView.widthAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: yellowView.leadingAnchor, constant: -15),
            containerView.topAnchor.constraint(equalTo: redView.topAnchor, constant: -15),
            containerView.trailingAnchor.constraint(equalTo: yellowView.trailingAnchor, constant: 15),
            containerView.bottomAnchor.constraint(equalTo: greenView.bottomAnchor, constant: 15)
        ])
    }
}

// MARK: - Factory

private extension NSLayoutAnchorViewController {
    
    func makeView(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
