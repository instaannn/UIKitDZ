//
//  ChangeLabelViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 21.09.2022.
//

import UIKit

/// Экран обработки текста в лейбле
final class ChangeLabelViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let nameColorLabelText = "Выберите цвет"
        static let nameNumberOfLineLabelText = "Кол-во линий"
        static let alertTitle = "Вот"
        static let alertMessage = "Здесь текст"
        static let textLabelText = "Здесь будет текст"
    }

    // MARK: - Visual Components
    
    private lazy var textLabel = makeTextLabel()
    private lazy var sizeSlider = makeSizeSlider()
    private lazy var nameColorLabel = makeLabel(text: Constants.nameColorLabelText, yCoordinate: 595)
    private lazy var nameNumberOfLineLabel = makeLabel(text: Constants.nameNumberOfLineLabelText, yCoordinate: 645)
    private lazy var colorPickerView = makePickerView(yCoordinate: 595)
    private lazy var linePickerView = makePickerView(yCoordinate: 645)
    
    // MARK: - Private properties
    
    private lazy var colors: [UIColor] = [
        .black,
        .systemRed,
        .systemGreen,
        .systemBlue,
        .darkGray,
        .systemYellow
    ]
    
    private lazy var labelColors = [
        "black",
        "red",
        "green",
        "blue",
        "gray",
        "yellow"
    ]
    private lazy var lines = ["1", "2", "3", "4", "5"]
    private lazy var numberLines = [1, 2, 3, 4, 5]
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    // MARK: - Private methods
    
    @objc private func sizeSliderAction(sender: UISlider) {
        let senderValue = CGFloat(sender.value)
        textLabel.font = UIFont.boldSystemFont(ofSize: senderValue)
    }
    
    @objc private func barButtonAction() {
        showAlert(title: Constants.alertTitle, message: Constants.alertMessage, label: textLabel)
    }
}

// MARK: - UIPickerViewDelegate

extension ChangeLabelViewController: UIPickerViewDelegate { }

// MARK: - UIPickerViewDataSource

extension ChangeLabelViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return colors.count
        case 1:
            return lines.count
        default:
            return 0
        }
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        attributedTitleForRow row: Int,
        forComponent component: Int
    ) -> NSAttributedString? {
        switch pickerView.tag {
        case 0:
            let attributedString = NSAttributedString(
                string: labelColors[row],
                attributes: [NSAttributedString.Key.foregroundColor: colors[row]]
            )
            return attributedString
        case 1:
            let attributedString = NSAttributedString(string: lines[row])
            return attributedString
        default:
            return NSAttributedString()
        }
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        switch pickerView.tag {
        case 0:
            textLabel.textColor = colors[row]
        case 1:
            textLabel.numberOfLines = numberLines[row]
        default:
            break
        }
    }
}

// MARK: - SetupUI

private extension ChangeLabelViewController {
    
    func setupUI() {
        addViews()
        setupNavigationController()
        setupPickerViews()
    }
    
    func addViews() {
        view.addSubview(textLabel)
        view.addSubview(sizeSlider)
        view.addSubview(nameColorLabel)
        view.addSubview(nameNumberOfLineLabel)
        view.addSubview(colorPickerView)
        view.addSubview(linePickerView)
    }
    
    func setupNavigationController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(barButtonAction)
        )
    }
    
    func setupPickerViews() {
        colorPickerView.delegate = self
        colorPickerView.dataSource = self
        colorPickerView.tag = 0
        linePickerView.delegate = self
        linePickerView.dataSource = self
        linePickerView.tag = 1
    }
}

// MARK: - Factory

private extension ChangeLabelViewController {
    
    func makeTextLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.text = Constants.textLabelText
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.layer.borderColor = CGColor(srgbRed: 213/255.0, green: 218/255.0, blue: 221/255.0, alpha: 1)
        label.layer.cornerRadius = 15
        label.layer.borderWidth = 0.5
        label.frame = CGRect(x: 27, y: 145, width: 360, height: 360)
        return label
    }
    
    func makeSizeSlider() -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 15
        slider.maximumValue = 100
        slider.addTarget(self, action: #selector(sizeSliderAction(sender:)), for: .valueChanged)
        slider.frame = CGRect(x: 57, y: 535, width: 300, height: 30)
        return slider
    }
    
    func makeLabel(text: String, yCoordinate: Int) -> UILabel {
        let label = UILabel()
        label.text = text
        label.frame = CGRect(x: 57, y: yCoordinate, width: 150, height: 30)
        label.textColor = .black
        return label
    }
    
    func makePickerView(yCoordinate: Int) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.frame = CGRect(x: 207, y: yCoordinate, width: 150, height: 40)
        return pickerView
    }
}
