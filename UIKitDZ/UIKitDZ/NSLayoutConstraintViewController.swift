//
//  NSLayoutConstraintViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 16.10.2022.
//

import UIKit

/// Экран со светофором NSLayoutConstraint
final class NSLayoutConstraintViewController: UIViewController {
    
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

private extension NSLayoutConstraintViewController {
    
    func setupUI() {
        addViews()
        setUpConstraints()
    }
    
    func addViews() {
        view.addSubview(containerView)
        [redView, yellowView, greenView].forEach { containerView.addSubview($0) }
    }
    
    func setUpConstraints() {
        setupYellowViewConstraints()
        setupRedViewConstraints()
        setupGreenViewConstraints()
        setupContainerViewConstraints()
    }
    
    func setupYellowViewConstraints() {
        let centerXConstraint = NSLayoutConstraint(
            item: yellowView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        )
        
        let centerYConstraint = NSLayoutConstraint(
            item: yellowView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerY,
            multiplier: 1,
            constant: 0
        )
        
        let widthConstraint = NSLayoutConstraint(
            item: yellowView,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .height,
            multiplier: 0.14,
            constant: 0
        )
        
        let heightConstraint = NSLayoutConstraint(
            item: yellowView,
            attribute: .height,
            relatedBy: .equal,
            toItem: yellowView,
            attribute: .width,
            multiplier: 1,
            constant: 0
        )
        
        NSLayoutConstraint.activate([
            centerXConstraint,
            centerYConstraint,
            widthConstraint,
            heightConstraint
        ])
    }
    
    func setupRedViewConstraints() {
        let bottomConstraint = NSLayoutConstraint(
            item: redView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: yellowView,
            attribute: .top,
            multiplier: 1,
            constant: -15
        )
        
        let centerXConstraint = NSLayoutConstraint(
            item: redView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: yellowView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        )
        
        let widthConstraint = NSLayoutConstraint(
            item: redView,
            attribute: .width,
            relatedBy: .equal,
            toItem: yellowView,
            attribute: .height,
            multiplier: 1,
            constant: 0
        )
        
        let heightConstraint = NSLayoutConstraint(
            item: redView,
            attribute: .height,
            relatedBy: .equal,
            toItem: yellowView,
            attribute: .width,
            multiplier: 1,
            constant: 0
        )
        
        NSLayoutConstraint.activate([
            bottomConstraint,
            centerXConstraint,
            widthConstraint,
            heightConstraint
        ])
    }
    
    func setupGreenViewConstraints() {
        let topConstraint = NSLayoutConstraint(
            item: greenView,
            attribute: .top,
            relatedBy: .equal,
            toItem: yellowView,
            attribute: .bottom,
            multiplier: 1,
            constant: 15
        )
        
        let centerXConstraint = NSLayoutConstraint(
            item: greenView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: yellowView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        )
        
        let widthConstraint = NSLayoutConstraint(
            item: greenView,
            attribute: .width,
            relatedBy: .equal,
            toItem: yellowView,
            attribute: .height,
            multiplier: 1,
            constant: 0
        )
        
        let heightConstraint = NSLayoutConstraint(
            item: greenView,
            attribute: .height,
            relatedBy: .equal,
            toItem: yellowView,
            attribute: .width,
            multiplier: 1,
            constant: 0
        )
        
        NSLayoutConstraint.activate([
            topConstraint,
            centerXConstraint,
            widthConstraint,
            heightConstraint
        ])
    }
    
    func setupContainerViewConstraints() {
        let leadingConstraint = NSLayoutConstraint(
            item: containerView,
            attribute: .leading,
            relatedBy: .equal,
            toItem: yellowView,
            attribute: .leading,
            multiplier: 1,
            constant: -15
        )
        
        let topConstraint = NSLayoutConstraint(
            item: containerView,
            attribute: .top,
            relatedBy: .equal,
            toItem: redView,
            attribute: .top,
            multiplier: 1,
            constant: -15
        )
        
        let trailingConstraint = NSLayoutConstraint(
            item: containerView,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: yellowView,
            attribute: .trailing,
            multiplier: 1,
            constant: 15
        )
        
        let bottomConstraint = NSLayoutConstraint(
            item: containerView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: greenView,
            attribute: .bottom,
            multiplier: 1,
            constant: 15
        )
        
        NSLayoutConstraint.activate([
            leadingConstraint,
            topConstraint,
            trailingConstraint,
            bottomConstraint
        ])
    }
}

// MARK: - Factory

private extension NSLayoutConstraintViewController {
    
    func makeView(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
