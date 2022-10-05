//
//  SignInViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 21.09.2022.
//

import UIKit
/// Экран входа
final class SignInViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let keyLogin = "login"
        static let keyPassword = "password"
        static let alertTitle = "Oops"
        static let alertMessageEmptyTextField = "Fill in all the fields"
        static let alertMessageIncorrect = "Incorrect login or password"
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginTextField.text = ""
        passwordTextField.text = ""
    }
    
    // MARK: - IBAction
    
    @IBAction private func signInButtonAction(_ sender: UIButton) {
        guard let login = loginTextField.text,
              let password = passwordTextField.text else { return }
        if login.isEmpty || password.isEmpty {
            showAlert(title: Constants.alertTitle, message: Constants.alertMessageEmptyTextField)
        } else if login == SaveLoginPass.shared.checkLoginPass(forKey: Constants.keyLogin),
                  password == SaveLoginPass.shared.checkLoginPass(forKey: Constants.keyPassword) {
            guard let catViewController = UIStoryboard.main.instantiateViewControllerWithIdentifier(
                CatViewController.self
            ) else { return }
            catViewController.modalPresentationStyle = .fullScreen
            navigationItem.backBarButtonItem = UIBarButtonItem(
                title: "",
                style: .plain,
                target: nil,
                action: nil
            )
            navigationController?.pushViewController(catViewController, animated: true)
        } else {
            showAlert(title: Constants.alertTitle, message: Constants.alertMessageIncorrect)
        }
    }
    
    @IBAction private func registerButtonAction(_ sender: UIButton) {
        guard let registerViewController = UIStoryboard.main.instantiateViewControllerWithIdentifier(
            RegisterViewController.self
        ) else { return }
        registerViewController.modalPresentationStyle = .fullScreen
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}

// MARK: - SetupUI

private extension SignInViewController {
    
    func setupUI() {
        setupTextFields()
    }
    
    func setupTextFields() {
        loginTextField.setBottomBorder(color: .systemGray5)
        loginTextField.textContentType = .username
        loginTextField.keyboardType = .emailAddress
        passwordTextField.setBottomBorder(color: .systemGray5)
        passwordTextField.textContentType = .password
        passwordTextField.keyboardType = .default
    }
}
