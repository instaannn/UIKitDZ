//
//  PaymentViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 29.09.2022.
//

import UIKit
/// Экран оплаты
final class PaymentViewController: UIViewController {
    
    // MARK: Public properties
    
    var pizza: Pizza?
    weak var delegate: GoToCatalogVCDelegate?
    
    // MARK: - Private properties
    
    private lazy var yourOrderLabel = makeYourOrderLabel()
    private lazy var pizzaNameLabel = makePizzaNameLabel()
    private lazy var cardLabel = makeLabel(text: "Оплата картой", yCoordinate: 650)
    private lazy var cashLabel = makeLabel(text: "Оплата наличными", yCoordinate: 710)
    private lazy var cardSwitch = makeSwitch(yCoordinate: 650)
    private lazy var cashSwitch = makeSwitch(yCoordinate: 710)
    private lazy var payButton = makePayButton()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .white
        navigationItem.title = "Оплата"
        cardSwitch.isOn = true
    }
    
    // MARK: - Private Actions
    
    @objc private func switchAction(_ sender: UISwitch) {
        if cardSwitch === sender {
            cashSwitch.isOn.toggle()
        } else {
            cardSwitch.isOn.toggle()
        }
    }
    
    @objc private func payButtonAction() {
        let alertController = UIAlertController(
            title: "Заказ оплачен",
            message: "Ваш заказ оставят в течении 15 минут! Приятного аппетита",
            preferredStyle: .alert
        )
        let alertOk = UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: false)
            self.delegate?.goBack()
        }
        alertController.addAction(alertOk)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - setupUI

private extension PaymentViewController {
    
    func setupUI() {
        view.addSubview(yourOrderLabel)
        view.addSubview(pizzaNameLabel)
        view.addSubview(cardLabel)
        view.addSubview(cashLabel)
        view.addSubview(cardSwitch)
        view.addSubview(cashSwitch)
        view.addSubview(payButton)
        
        addIngredientLabels()
    }
    
    func addIngredientLabels() {
        guard let pizza = pizza,
              let ingredients = pizza.ingredient else { return }
        var yCoordinate = 260
        pizzaNameLabel.text = "1) \(pizza.name)"
        for (key, value) in ingredients.enumerated() {
            let label = UILabel()
            label.text = "\(key + 2)) \(value)"
            label.frame = CGRect(x: 57, y: yCoordinate, width: 300, height: 30)
            label.font = UIFont(name: "AlumniSans-Light", size: 30)
            view.addSubview(label)
            yCoordinate += 50
        }
    }
}

// MARK: - Factory

private extension PaymentViewController {
    
    func makeYourOrderLabel() -> UILabel {
        let label = UILabel()
        label.text = "Ваш заказ:"
        label.frame = CGRect(x: 57, y: 120, width: 300, height: 40)
        label.font = UIFont(name: "AlumniSans-Light", size: 40)
        return label
    }
    
    func makeLabel(text: String, yCoordinate: Int) -> UILabel {
        let label = UILabel()
        label.text = text
        label.frame = CGRect(x: 57, y: yCoordinate, width: 300, height: 40)
        label.font = UIFont(name: "AlumniSans-Light", size: 35)
        return label
    }
    
    func makeSwitch(yCoordinate: Int) -> UISwitch {
        let mySwitch = UISwitch()
        mySwitch.onTintColor = UIColor(displayP3Red: 227 / 252, green: 30 / 252, blue: 35 / 252, alpha: 1)
        mySwitch.frame = CGRect(x: 305, y: yCoordinate, width: 52, height: 32)
        mySwitch.addTarget(self, action: #selector(switchAction(_:)), for: .valueChanged)
        return mySwitch
    }
    
    func makePayButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = .black
        button.frame = CGRect(x: 35, y: 778, width: 344, height: 50)
        button.layer.cornerRadius = button.frame.height / 2
        button.setTitle("Оплатить", for: .normal)
        button.titleLabel?.font = UIFont(name: "AlumniSans-SemiBold", size: 20)
        button.addTarget(self, action: #selector(payButtonAction), for: .touchUpInside)
        return button
    }
    
    func makePizzaNameLabel() -> UILabel {
        let label = UILabel()
        label.frame = CGRect(x: 57, y: 200, width: 300, height: 30)
        label.font = UIFont(name: "AlumniSans-Light", size: 30)
        return label
    }
}
