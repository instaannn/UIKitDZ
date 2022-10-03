//
//  RegisterViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 03.10.2022.
//

import UIKit
/// Экран регистрации
final class RegisterViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let keyLogin = "login"
        static let keyPassword = "password"
        static let alertTitle = "Oops"
        static let alertMessageEmptyTextField = "Fill in all the fields"
        static let alertMessageIncorrect = "Incorrect login or password"
        static let alertMassageLoginBusy = "This login is busy"
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var emailTextField: UITextField!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private actions
    
    @IBAction private func registerButtonAction(_ sender: UIButton) {
        guard let login = loginTextField.text,
              let password = passwordTextField.text else { return }
        
        if login.isEmpty || password.isEmpty {
            showAlert(title: Constants.alertTitle, message: Constants.alertMessageEmptyTextField)
        } else if login == SaveLoginPass.shared.checkLoginPass(forKey: Constants.keyLogin),
                  password == SaveLoginPass.shared.checkLoginPass(forKey: Constants.keyPassword) {
            showAlert(title: Constants.alertTitle, message: Constants.alertMassageLoginBusy)
        } else {
            SaveLoginPass.shared.saveLoginPass(text: login, forKey: Constants.keyLogin)
            SaveLoginPass.shared.saveLoginPass(text: password, forKey: Constants.keyPassword)
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc private func viewTapped() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}

// MARK: - SetupUI

private extension RegisterViewController {
    
    func setupUI() {
        setupTextFields()
        setTapView()
        setupNotificationCenter()
    }
    
    func setupTextFields() {
        loginTextField.setBottomBorder(color: .systemGray5)
        passwordTextField.setBottomBorder(color: .systemGray5)
        emailTextField.setBottomBorder(color: .systemGray5)
        loginTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self
        loginTextField.textContentType = .username
        loginTextField.keyboardType = .emailAddress
        passwordTextField.textContentType = .password
        passwordTextField.keyboardType = .default
    }
    
    func setTapView() {
        let theTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(theTap)
    }
    
    func setupNotificationCenter() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: nil
        ) { _ in
            self.view.frame.origin.y = -100
        }
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: nil
        ) { _ in
            self.view.frame.origin.y = 0
        }
    }
}
