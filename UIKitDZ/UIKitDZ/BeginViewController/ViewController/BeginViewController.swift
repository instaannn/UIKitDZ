//
//  BeginViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 21.09.2022.
//

import UIKit

final class BeginViewController: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var beginButton = makeButton()
    private lazy var wordLabel = makeLabel()
    private lazy var model = WordModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    
    @objc private func beginButtonAction() {
        let alertController = UIAlertController(title: .none, message: Constants.alertMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: Constants.titleAlertAction, style: .cancel) { _ in
            guard let text = alertController.textFields?.first?.text else {
                return
            }
            self.wordLabel.text = self.model.makeWord(text: text)
        }
        alertController.addTextField()
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: .none)
    }
}

// MARK: - Setup

private extension BeginViewController {
    
    func setupUI() {
        view.addSubview(beginButton)
        view.addSubview(wordLabel)
    }
}

// MARK: - Factory

private extension BeginViewController {
    
    func makeButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
        button.center = view.center
        button.backgroundColor = .systemBlue
        button.setTitle(Constants.titleButton, for: .normal)
        button.layer.cornerRadius = Constants.cornerRadius
        button.addTarget(self, action: #selector(beginButtonAction), for: .touchUpInside)
        return button
    }
    
    func makeLabel() -> UILabel {
        let label = UILabel(frame: CGRect(x: 82, y: 350, width: 250, height: 30))
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }
}

// MARK: - Constants

private extension BeginViewController {
    
    enum Constants {
        static let titleButton: String = "Begin"
        static let alertMessage: String = "Введите слово"
        static let titleAlertAction: String = "Ok"
        static let cornerRadius: CGFloat = 5
    }
}
