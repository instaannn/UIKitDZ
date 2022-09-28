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

    private lazy var logoImageView = makaLogoImageView()
    private lazy var signInLabel = makeSignInLabel()
    private lazy var emailLabel = makeLabel(text: "Email", yCoordinate: 320)
    private lazy var emailTextField = makeTextField(placeholder: "example@email.com", yCoordinate: 355)
    private lazy var passwordLabel = makeLabel(text: "Password", yCoordinate: 410)
    private lazy var passwordTextField = makeTextField(placeholder: "password", yCoordinate: 445)
    private lazy var faceIDLabel = makeFaceIDLabel()
    private lazy var faceIDSwitch = makeFaceIDSwitch()
    private lazy var signInButton = makeSignInButton()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    
    @objc private func signInButtonAction() {
        let friendsViewController = FriendsViewController()
        navigationController?.pushViewController(friendsViewController, animated: true)
    }
}

// MARK: - setupUI

private extension SignInViewController {
    
    func setupUI() {
        view.addSubview(logoImageView)
        view.addSubview(signInLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(faceIDLabel)
        view.addSubview(faceIDSwitch)
        view.addSubview(signInButton)
    }
}

// MARK: - Factory

private extension SignInViewController {
    
    func makaLogoImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.frame = CGRect(x: 82, y: 104, width: 250, height: 100)
        return imageView
    }
    
    func makeSignInLabel() -> UILabel {
        let label = UILabel()
        label.text = "Sign In"
        label.frame = CGRect(x: 62, y: 274, width: 289, height: 30)
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        return label
    }
    
    func makeLabel(text: String, yCoordinate: Int) -> UILabel {
        let label = UILabel()
        label.text = text
        label.frame = CGRect(x: 62, y: yCoordinate, width: 289, height: 20)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }
    
    func makeTextField(placeholder: String, yCoordinate: Int) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.setBottomBorder(color: .systemGray5)
        textField.frame = CGRect(x: 62, y: yCoordinate, width: 289, height: 20)
        return textField
    }
    
    func makeFaceIDLabel() -> UILabel {
        let label = UILabel()
        label.text = "Вход по Face ID"
        label.frame = CGRect(x: 164, y: 510, width: 117, height: 20)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        return label
    }
    
    func makeFaceIDSwitch() -> UISwitch {
        let uSwitch = UISwitch()
        uSwitch.frame = CGRect(x: 300, y: 503, width: 52, height: 32)
        uSwitch.isOn = false
        return uSwitch
    }
    
    func makeSignInButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.frame = CGRect(x: 62, y: 590, width: 289, height: 46)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
        return button
    }
}
