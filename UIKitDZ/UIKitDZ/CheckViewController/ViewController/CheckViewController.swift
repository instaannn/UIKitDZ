//
//  CheckViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 22.09.2022.
//

import UIKit
/// экран выдачи чека
final class CheckViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var totalButton: UIButton!
    
    // MARK: - Public properties
    
    var table = 0
    var prepayment = 0
    var vip = 0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - IBAction
    
    @IBAction func totalButtonAction(_ sender: UIButton) {
        totalButton.setTitle("ИТОГО: 0 р", for: .normal)
        showAlert()
    }
    
    // MARK: - Private methods

    private func showAlert() {
        let alert = UIAlertController(title: "Ура!", message: "Чек отправлен", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: { _ in }))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Setup

private extension CheckViewController {

    func setupUI() {
        navigationItem.title = "Чек"
        totalButton.setTitle("ИТОГО: \(700 + table + prepayment + vip) р", for: .normal)
    }
}
