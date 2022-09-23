//
//  ViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 21.09.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var additionButton = makeButton(text: "Cложение")
    private lazy var guessTheNumberButton = makeButton(text: "Угадай число")
    private lazy var stackView = makeStackView()
    private lazy var nameLabel = makeNameLabel()
    private lazy var isNumber = true
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        alertOneTextField(title: "Эй", message: "Введите ваше имя", isNumber: false)
    }
    
    // MARK: - Actions
    
    @objc private func additionAction() {
        alertTwoTextField(title: "Привет", message: "Введите два числа")
    }
    
    @objc private func guessTheNumberAction() {
        alertOneTextField(title: "Привет", message: "Угадай число от 1 до 10", isNumber: true)
    }
    
    // MARK: - Private methods

    private func alertOneTextField(title: String, message: String, isNumber: Bool) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField { textfield in
            textfield.delegate = self
            if isNumber {
                textfield.keyboardType = .numberPad
                self.isNumber.toggle()
            } else {
                textfield.keyboardType = .default
                self.isNumber.toggle()
            }
        }
        let alertAction = UIAlertAction(title: "Ok", style: .cancel) { _ in
            print()
        }
        
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: .none)
    }
    
    private func alertTwoTextField(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .cancel) { _ in
            guard let numberOne = alertController.textFields?.first?.text,
            let numberTwo = alertController.textFields?.last?.text else {
                return
            }
            if let numberOne = Int(numberOne),
               let numberTwo = Int(numberTwo) {
                self.nameLabel.text = String(numberOne + numberTwo)
            }
        }
        alertController.addTextField { textField in
            textField.keyboardType = .numberPad
        }
        alertController.addTextField { textField in
            textField.keyboardType = .numberPad
        }
        
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: .none)
    }
    
}

// MARK: - Setup

private extension ViewController {
    
    func setupUI() {
        view.addSubview(stackView)
        view.addSubview(nameLabel)
        stackView.addArrangedSubview(additionButton)
        stackView.addArrangedSubview(guessTheNumberButton)
        
        additionButton.addTarget(self, action: #selector(additionAction), for: .touchUpInside)
        guessTheNumberButton.addTarget(self, action: #selector(guessTheNumberAction), for: .touchUpInside)
    }
}

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if let number = Int(text) {
            if number == Int.random(in: 1...10) {
                nameLabel.text = "правильно, ты булочка с коричкой 🥐"
            } else {
                nameLabel.text = "не угадал"
            }
        } else {
            nameLabel.text = text
        }
    }
}

// MARK: - Factory

private extension ViewController {
    
    func makeStackView() -> UIStackView {
        let stackView = UIStackView(frame: CGRect(x: 50, y: 380, width: 310, height: 135))
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }
    
    func makeButton(text: String) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 310, height: 55))
        button.backgroundColor = .systemIndigo
        button.setTitle(text, for: .normal)
        button.layer.cornerRadius = 20
        return button
    }
    
    func makeNameLabel() -> UILabel {
        let label = UILabel(frame: CGRect(x: 50, y: 302, width: 310, height: 40))
        label.textAlignment = .center
        return label
    }
}
