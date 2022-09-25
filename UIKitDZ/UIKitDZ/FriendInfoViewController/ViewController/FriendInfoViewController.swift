//
//  FriendInfoViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 25.09.2022.
//

import UIKit
/// Экран информации о друге
final class FriendInfoViewController: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var cancelButton = makeTextButton(title: "Отмена", xCoordinate: 15, yCoordinate: 25, width: 100)
    private lazy var addButton = makeTextButton(title: "Добавить", xCoordinate: 299, yCoordinate: 25, width: 100)
    private lazy var avatarImageView = makeAvatarImageView()
    private lazy var changePhotoButton = makeTextButton(
        title: "Изменить фото",
        xCoordinate: 129,
        yCoordinate: 222,
        width: 156
    )
    private lazy var nameLabel = makeLabel(text: "Имя", yCoordinate: 280)
    private lazy var dateLabel = makeLabel(text: "Дата", yCoordinate: 375)
    private lazy var ageLabel = makeLabel(text: "Возраст", yCoordinate: 470)
    private lazy var genderLabel = makeLabel(text: "Пол", yCoordinate: 565)
    private lazy var instagramLabel = makeLabel(text: "Instagram", yCoordinate: 660)
    private lazy var nameTextField = makeTextField(placeholder: "Введите имя", yCoordinate: 317)
    private lazy var dateTextField = makeTextField(placeholder: "Введите дату", yCoordinate: 412)
    private lazy var ageTextField = makeTextField(placeholder: "Введите возраст", yCoordinate: 507)
    private lazy var genderTextField = makeTextField(placeholder: "Выберите пол", yCoordinate: 602)
    private lazy var instagramTextField = makeTextField(placeholder: "Добавить ник в instagram", yCoordinate: 697)
    private lazy var datePicker = makeDatePicker()
    private lazy var agePicker = makePicker(tag: 1)
    private lazy var genderPicker = makePicker(tag: 2)
    private lazy var ageGender = AgeGender()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .white
    }
    
    // MARK: - Actions
    
    @objc private func cancelButtonAction() {
        dismiss(animated: true)
    }
    
    @objc private func addButtonAction() {
        dismiss(animated: true)
    }
    
    @objc private func doneAction() {
        dateTextField.text = DateFormatter.dayWithTimeDateLongFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @objc private func tapGestureDone() {
        view.endEditing(true)
    }
}

// MARK: - UIPickerViewDelegate

extension FriendInfoViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView.tag {
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return ageGender.age.count
        case 2:
            return ageGender.gender.count
        default:
            return 0
        }
    }
}

// MARK: - UIPickerViewDelegate

extension FriendInfoViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            let result = ageGender.age[row]
            return result
        case 2:
            let result = ageGender.gender[row]
            return result
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            ageTextField.text = ageGender.age[row]
        case 2:
            genderTextField.text = ageGender.gender[row]
        default:
            break
        }
    }
}

// MARK: - UITextFieldDelegate

extension FriendInfoViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showAlert(title: "Hi", message: "Введите аккаунт instagram", textField: textField)
    }
}

// MARK: - setupUI

private extension FriendInfoViewController {
    
    func setupUI() {
        addAction()
        addView()
        setupTextFields()
        setupToolBar()
        addTapGesture()
    }
    
    func addView() {
        view.addSubview(cancelButton)
        view.addSubview(addButton)
        view.addSubview(avatarImageView)
        view.addSubview(changePhotoButton)
        view.addSubview(nameLabel)
        view.addSubview(dateLabel)
        view.addSubview(ageLabel)
        view.addSubview(genderLabel)
        view.addSubview(instagramLabel)
        view.addSubview(nameTextField)
        view.addSubview(dateTextField)
        view.addSubview(ageTextField)
        view.addSubview(genderTextField)
        view.addSubview(instagramTextField)
        view.addSubview(datePicker)
        view.addSubview(agePicker)
        view.addSubview(genderPicker)
    }
    
    func addAction() {
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
    }
    
    func setupTextFields() {
        dateTextField.inputView = datePicker
        ageTextField.inputView = agePicker
        genderTextField.inputView = genderPicker
        instagramTextField.delegate = self
    }
    
    func setupToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace, doneButton], animated: true)
        dateTextField.inputAccessoryView = toolbar
    }
    
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        view.addGestureRecognizer(tapGesture)
    }
}

// MARK: - Factory

private extension FriendInfoViewController {
    
    func makeTextButton(title: String, xCoordinate: Int, yCoordinate: Int, width: Int) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.frame = CGRect(x: xCoordinate, y: yCoordinate, width: width, height: 25)
        return button
    }
    
    func makeAvatarImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar")
        imageView.frame = CGRect(x: 137, y: 69, width: 140, height: 140)
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.backgroundColor = .systemGray5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func makeLabel(text: String, yCoordinate: Int) -> UILabel {
        let label = UILabel()
        label.text = text
        label.frame = CGRect(x: 30, y: yCoordinate, width: 180, height: 25)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .blue
        return label
    }
    
    func makeTextField(placeholder: String, yCoordinate: Int) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.setBottomBorder(color: .systemGray5)
        textField.frame = CGRect(x: 30, y: yCoordinate, width: 310, height: 25)
        textField.placeholder = placeholder
        return textField
    }
    
    func makeDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.frame.size = CGSize(width: 0, height: 300)
        return datePicker
    }
    
    func makePicker(tag: Int) -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.frame.size = CGSize(width: 0, height: 300)
        picker.tag = tag
        return picker
    }
}
