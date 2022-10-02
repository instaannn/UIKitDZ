//
//  SignInViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 21.09.2022.
//

import UIKit
/// Экран входа
final class SignInViewController: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var logoImageView = makeLogoImageView()
    private lazy var phoneLabel = makeLabel(text: "Телефон", yCoordinate: 374)
    private lazy var phoneTextField = makeTextField(
        placeholder: "Введите телефон",
        yCoordinate: 414,
        keyboardType: .numberPad
    )
    private lazy var passwordLabel = makeLabel(text: "Пароль", yCoordinate: 469)
    private lazy var passwordTextField = makeTextField(
        placeholder: "Введите пароль",
        yCoordinate: 509
    )
    private lazy var signInButton = UIButton()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Actions
    
    @objc private func signInButtonAction() {
        let catalogViewController = CatalogViewController()
        let navigationController = UINavigationController(rootViewController: catalogViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
}

// MARK: - setupUI

private extension SignInViewController {
    
    func setupUI() {
        addViews()
        setupSignInButton()
    }
    
    func addViews() {
        view.addSubview(logoImageView)
        view.addSubview(phoneLabel)
        view.addSubview(phoneTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
    }
    
    func setupSignInButton() {
        signInButton.mainButton(text: "Войти", xCoordinate: 35, yCoordinate: 631)
        signInButton.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
    }
}

// MARK: - Factory

private extension SignInViewController {
    
    func makeLogoImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.frame = CGRect(x: 117, y: 97, width: 180, height: 180)
        return imageView
    }
    
    func makeLabel(text: String, yCoordinate: Int) -> UILabel {
        let label = UILabel()
        label.text = text
        label.frame = CGRect(x: 35, y: yCoordinate, width: 344, height: 25)
        label.font = UIFont(name: "AlumniSans-Light", size: 25)
        return label
    }
    
    func makeTextField(
        placeholder: String,
        yCoordinate: Int,
        keyboardType: UIKeyboardType? = .default
    ) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.font = UIFont(name: "AlumniSans-Light", size: 25)
        textField.frame = CGRect(x: 35, y: yCoordinate, width: 344, height: 25)
        textField.keyboardType = keyboardType ?? .default
        return textField
    }
}
