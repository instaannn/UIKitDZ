//
//  GuestInformationViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 22.09.2022.
//

import UIKit
/// экран регистрации гостя
final class GuestInformationViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var guestCountTextField: UITextField!
    @IBOutlet weak var numberTableTextField: UITextField!
    @IBOutlet weak var billButton: UIButton!
    @IBOutlet weak var tableSwitch: UISwitch!
    @IBOutlet weak var prepaymentSwitch: UISwitch!
    @IBOutlet weak var vipSwitch: UISwitch!
    
    // MARK: - Private properties
    
    private var table = 0
    private var prepayment = 0
    private var vip = 0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - IBAction
    
    @IBAction func billButtonAction(_ sender: UIButton) {
        showAlert()
    }
    
    @IBAction func tableSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            table = 500
        } else {
            table = 0
        }
    }
    
    @IBAction func prepaymentSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            prepayment = 1000
        } else {
            prepayment = 0
        }
    }
    
    @IBAction func vipSwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            vip = 1000
        } else {
            vip = 0
        }
    }
    
    // MARK: - Private methods
    
    private func showAlert() {
        let alert = UIAlertController(title: "Вывести чек", message: .none, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "Чек", style: .default, handler: { _ in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let checkViewController = storyboard.instantiateViewController(
                    withIdentifier: "CheckViewController"
                ) as? CheckViewController else { return }
                checkViewController.table = self.table
                checkViewController.prepayment = self.prepayment
                checkViewController.vip = self.vip
                self.navigationController?.pushViewController(checkViewController, animated: true)
            })
        )
        alert.addAction(
            UIAlertAction(title: "Закрыть", style: .cancel, handler: { _ in
                print("")
            })
        )
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Setup

private extension GuestInformationViewController {
    
    func setupUI() {
        setupTextFields()
    }
    
    func setupTextFields() {
        nameTextField.setBottomBorder(color: .systemGray5)
        guestCountTextField.setBottomBorder(color: .systemGray5)
        numberTableTextField.setBottomBorder(color: .systemGray5)
    }
}
