//
//  SignInViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 21.09.2022.
//

import UIKit
 /// экран входа
final class SignInViewController: UIViewController {
    
    // MARK: - IBOutlet

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Setup

private extension SignInViewController {

    func setupUI() {
        setupTextFields()
    }
    
    func setupTextFields() {
        passwordTextField.setBottomBorder(color: .systemGray5)
        emailTextField.setBottomBorder(color: .systemGray5)
    }
}
