//
//  RepeatVideoViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 21.09.2022.
//

import UIKit
/// Повтор видео
final class RepeatVideoViewController: UIViewController, UITextFieldDelegate {
    
    var buttonShare = UIButton()
    var textField = UITextField()
    var activityViewController: UIActivityViewController?
    var something = ["one", "two", "three"]
    
    @IBOutlet weak var somethingPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTextField()
        createButton()
        setupPickerView()
    }
    
    // MARK: - Method
    
    func createTextField() {
        textField.frame = CGRect(x: 0, y: 0, width: 280, height: 30)
        textField.center = view.center
        textField.borderStyle = .roundedRect
        textField.delegate = self
        view.addSubview(textField)
    }
    
    func createButton() {
        buttonShare = UIButton(type: .roundedRect)
        buttonShare.frame = CGRect(x: 50, y: 350, width: 280, height: 44)
        buttonShare.setTitle("Расшарить", for: .normal)
        buttonShare.addTarget(self, action: #selector(hendelShare), for: .touchUpInside)
        view.addSubview(buttonShare)
    }
    
    func setupPickerView() {
        somethingPickerView.delegate = self
        somethingPickerView.dataSource = self
    }
    
    @objc func hendelShare(paramSender: Any) {
        let text = textField.text
        if text?.count == 0 {
            let message = "Сначала введите текст, потом нажмите кнопку"
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel)
            alertController.addAction(action)
            present(alertController, animated: true)
        }
        
        activityViewController = UIActivityViewController(
            activityItems: [textField.text ?? ""],
            applicationActivities: nil
        )
        guard let activityViewController = activityViewController else { return }
        present(activityViewController, animated: true)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension RepeatVideoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return something.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return something[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 2 {
            activityViewController = UIActivityViewController(
                activityItems: [something[row]],
                applicationActivities: nil
            )
            guard let activityViewController = activityViewController else { return }
            present(activityViewController, animated: true)
        }
    }
}
