//
//  SettingsViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 04.10.2022.
//

import UIKit
/// Экран настройки отображения текста
final class SettingsViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let smallASystemName = "textformat.size.smaller"
        static let largeASystemName = "textformat.size.larger"
        static let fontLabelText = "Выберите шрифт"
        static let segmentControlRegular = "Regular"
        static let segmentControlBold = "Bold"
    }
    
    // MARK: - Public properties
    
    weak var delegate: ReaderViewControllerDelegate?
    
    // MARK: - Private properties
    
    private lazy var fontLabel = makeFontLabel()
    private lazy var fontPicker = makeFontPicker()
    private lazy var fontSizeSlider = makeFontSizeSlider()
    private lazy var smallA = makeAImageView(name: Constants.smallASystemName, xCoordinate: 20)
    private lazy var largeA = makeAImageView(name: Constants.largeASystemName, xCoordinate: 374)
    private lazy var boldSegmentControl = makeBoldSegmentControl()
    private lazy var darkModeSwitch = makeDarkModeSwitch()
    private lazy var colors: [UIColor] = [.systemPink, .systemBlue, .systemBrown, .systemOrange]
    private lazy var fonts: [String] = [String]()
    private lazy var selectFont = ""
    private lazy var selectSize: CGFloat = 0

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    // MARK: - Private actions
    
    @objc private func fontSizeSliderAction(_ sender: UISlider) {
        let selectValue = CGFloat(sender.value)
        selectSize = selectValue
        delegate?.setupFontSize(fontName: selectFont, size: selectValue)
    }
    
    @objc private func colorsButtonAction(_ sender: UIButton) {
        guard let color = sender.backgroundColor else { return }
        delegate?.setupFontColors(color: color)
    }
    
    @objc private func segmentControlAction(_ sender: UISegmentedControl) {
        guard let font = UIFont(name: selectFont, size: selectSize) else { return }
        let selectIndex = sender.selectedSegmentIndex
        switch selectIndex {
        case 0:
            delegate?.setupBoldFont(bold: font)
        case 1:
            delegate?.setupBoldFont(bold: font.bold)
        default:
            break
        }
    }
    
    @objc private func darkModeSwitchAction() {
        delegate?.setDarkMode(darkMode: darkModeSwitch.isOn)
    }
}

// MARK: - UIPickerViewDelegate

extension SettingsViewController: UIPickerViewDelegate { }

// MARK: - UIPickerViewDataSource

extension SettingsViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fonts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fonts[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.setupFont(fontName: fonts[row], size: selectSize)
        selectFont = fonts[row]
    }
}

// MARK: - SetupUI

private extension SettingsViewController {
    
    func setupUI() {
        setupFontPicker()
        collectFonts()
        makeColorsButton()
        addViews()
    }
    
    func addViews() {
        view.addSubview(fontLabel)
        view.addSubview(fontPicker)
        view.addSubview(fontSizeSlider)
        view.addSubview(smallA)
        view.addSubview(largeA)
        view.addSubview(boldSegmentControl)
        view.addSubview(darkModeSwitch)
    }
    
    func setupFontPicker() {
        fontPicker.delegate = self
        fontPicker.dataSource = self
    }
    
    func collectFonts() {
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            fonts.append(names.first ?? "")
        }
    }
    
    func makeColorsButton() {
        var xCoordinate = 97
        for index in colors {
            let button = UIButton()
            button.backgroundColor = index
            button.frame = CGRect(x: xCoordinate, y: 160, width: 40, height: 40)
            button.layer.cornerRadius = button.frame.height / 2
            button.addTarget(self, action: #selector(colorsButtonAction(_:)), for: .touchUpInside)
            view.addSubview(button)
            xCoordinate += 60
        }
    }
}

// MARK: - Factory

private extension SettingsViewController {
    
    func makeFontLabel() -> UILabel {
        let label = UILabel()
        label.text = Constants.fontLabelText
        label.font = UIFont.systemFont(ofSize: 16)
        label.frame = CGRect(x: 20, y: 60, width: 180, height: 20)
        return label
    }
    
    func makeFontPicker() -> UIPickerView {
        let picker = UIPickerView()
        picker.frame = CGRect(x: 184, y: 50, width: 210, height: 40)
        picker.backgroundColor = .clear
        return picker
    }
    
    func makeFontSizeSlider() -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 20
        slider.maximumValue = 100
        slider.value = 20
        slider.addTarget(self, action: #selector(fontSizeSliderAction), for: .valueChanged)
        slider.frame = CGRect(x: 57, y: 105, width: 300, height: 30)
        return slider
    }
    
    func makeAImageView(name: String, xCoordinate: Int) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: name)
        imageView.frame = CGRect(x: xCoordinate, y: 110, width: 20, height: 20)
        imageView.tintColor = .black
        return imageView
    }
    
    func makeBoldSegmentControl() -> UISegmentedControl {
        let segmentControl = UISegmentedControl(items: [Constants.segmentControlRegular, Constants.segmentControlBold])
        segmentControl.frame = CGRect(x: 57, y: 225, width: 300, height: 30)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentControlAction(_:)), for: .valueChanged)
        return segmentControl
    }
    
    func makeDarkModeSwitch() -> UISwitch {
        let mySwitch = UISwitch()
        mySwitch.frame = CGRect(x: 181, y: 280, width: 52, height: 32)
        mySwitch.isOn = false
        mySwitch.addTarget(self, action: #selector(darkModeSwitchAction), for: .valueChanged)
        return mySwitch
    }
}
