//
//  OrderViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 27.09.2022.
//

import UIKit
/// Экран оформления заказа
final class OrderViewController: UIViewController {
    
    // MARK: Public properties
    
    var orderInfo: (String, String) = ("", "")
    var orderCustom = ""
    
    // MARK: - Private properties
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var nameLabel = makeLabel(text: "Имя", yCoordinate: 134)
    private lazy var nameTextField = makeTextfield(placeholder: "Введите имя", yCoordinate: 168)
    private lazy var dateDeliveryLabel = makeLabel(text: "Дата доставки", yCoordinate: 217)
    private lazy var dateDeliveryTextField = makeTextfield(placeholder: "Выберите дату", yCoordinate: 251)
    private lazy var datePicker = makeDatePicker()
    private lazy var orderInfoLabelLabel = makeLabel(text: "Состав заказа", yCoordinate: 300)
    private lazy var orderLabel = makeOrderLabel()
    private lazy var checkLabel = makeLabel(text: "Отправить чек на почту?", yCoordinate: 449)
    private lazy var checkSwitch = makeCheckSwitch()
    private lazy var saleLabel = makeLabel(text: "Списать доступные бонусы", yCoordinate: 498)
    private lazy var saleSlider = makeSaleSlider()
    private lazy var summNameLabel = makeLabel(text: "Итого", yCoordinate: 626)
    private lazy var summLabel = makeSummLabel()
    private lazy var payButton = UIButton()
    private lazy var closeButton = makeCloseButton()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        view.backgroundColor = .white
    }
    
    // MARK: - Action
    
    @objc private func doneAction() {
        dateDeliveryTextField.text = DateFormatter.dayDateLongFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @objc private func sliderAction() {
        guard let summ = Int(orderInfo.0) else { return }
        summLabel.text = "\(summ - Int(saleSlider.value)) р"
    }
    
    @objc private func closeButtonAction() {
        dismiss(animated: true)
    }
    
    @objc private func payButtonAction() {
        let textViewController = TextViewController()
        textViewController.modalPresentationStyle = .fullScreen
        textViewController.text = "Спасибо за заказ!"
        present(textViewController, animated: true)
    }
}

// MARK: - setupUI

private extension OrderViewController {
    
    func setupUI() {
        setupTextFields()
        setupToolBar()
        addViews()
        setupPayButton()
    }
    
    func addViews() {
        view.addSubview(titleLabel)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(dateDeliveryLabel)
        view.addSubview(dateDeliveryTextField)
        view.addSubview(orderInfoLabelLabel)
        view.addSubview(orderLabel)
        view.addSubview(checkLabel)
        view.addSubview(checkSwitch)
        view.addSubview(saleLabel)
        view.addSubview(saleSlider)
        view.addSubview(summNameLabel)
        view.addSubview(summLabel)
        view.addSubview(payButton)
        view.addSubview(closeButton)
    }
    
    func setupPayButton() {
        payButton.mainButton(text: "Оплатить")
        payButton.addTarget(self, action: #selector(payButtonAction), for: .touchUpInside)
    }
    
    func setupTextFields() {
        dateDeliveryTextField.inputView = datePicker
    }
    
    func setupToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace, doneButton], animated: true)
        dateDeliveryTextField.inputAccessoryView = toolbar
    }
}

// MARK: - Factory

private extension OrderViewController {
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "Оформление заказа"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 25)
        label.frame = CGRect(x: 60, y: 85, width: 294, height: 30)
        return label
    }
    
    func makeLabel(text: String, yCoordinate: Int) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: "Montserrat-Light", size: 20)
        label.frame = CGRect(x: 40, y: yCoordinate, width: 294, height: 30)
        return label
    }
    
    func makeTextfield(placeholder: String, yCoordinate: Int) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.frame = CGRect(x: 40, y: yCoordinate, width: 294, height: 30)
        return textField
    }
    
    func makeDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.frame.size = CGSize(width: 0, height: 300)
        return datePicker
    }
    
    func makeOrderLabel() -> UILabel {
        let label = UILabel()
        label.text = "\(orderInfo.1), \(orderInfo.0) р, \nсделать \(orderCustom)"
        label.font = UIFont(name: "Montserrat-Light", size: 18)
        label.frame = CGRect(x: 40, y: 334, width: 294, height: 90)
        label.numberOfLines = 0
        return label
    }
    
    func makeCheckSwitch() -> UISwitch {
        let checkSwitch = UISwitch()
        checkSwitch.frame = CGRect(x: 322, y: 449, width: 52, height: 32)
        return checkSwitch
    }
    
    func makeSaleSlider() -> UISlider {
        let slider = UISlider()
        slider.frame = CGRect(x: 40, y: 532, width: 294, height: 30)
        slider.minimumValue = 0
        slider.maximumValue = 150
        slider.addTarget(self, action: #selector(sliderAction), for: .valueChanged)
        return slider
    }
    
    func makeSummLabel() -> UILabel {
        let label = UILabel()
        label.text = "\(orderInfo.0) р"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 25)
        label.frame = CGRect(x: 274, y: 626, width: 100, height: 30)
        return label
    }
    
    func makeCloseButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.frame = CGRect(x: 354, y: 50, width: 40, height: 40)
        button.tintColor = .systemGray3
        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        return button
    }
}
