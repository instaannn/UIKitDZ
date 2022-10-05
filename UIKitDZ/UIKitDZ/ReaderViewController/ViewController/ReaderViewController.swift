//
//  ReaderViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 21.09.2022.
//

import UIKit

protocol ReaderViewControllerDelegate: AnyObject {
    func setupFont(fontName: String, size: CGFloat)
    func setupFontSize(fontName: String, size: CGFloat)
    func setupFontColors(color: UIColor)
    func setupBoldFont(bold: UIFont)
    func setDarkMode(darkMode: Bool)
}

/// Экран отображения текста
final class ReaderViewController: UIViewController {
    
    private enum Constants {
        static let fontName = "AcademyEngravedLetPlain"
        static let nameLabelText = "Александр Пушкин"
        static let settingButtonSystemName = "ellipsis"
    }
    
    // MARK: - Private properties

    private lazy var nameLabel = makeNameLabel()
    private lazy var poemsTextView = makepoemsTextView()
    private lazy var settingButton = makeSettingButton()
    private lazy var poemText = Poem()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private actions
    
    @objc private func settingButtonAction() {
        let settingsViewController = SettingsViewController()
        settingsViewController.delegate = self
        if let sheet = settingsViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        present(settingsViewController, animated: true)
        
    }
}

// MARK: - ReaderViewControllerDelegate

extension ReaderViewController: ReaderViewControllerDelegate {
    
    func setupFont(fontName: String, size: CGFloat) {
        if size == 0 {
            poemsTextView.font = UIFont(name: fontName, size: 20)
        } else {
            poemsTextView.font = UIFont(name: fontName, size: size)
        }
    }
    
    func setupFontSize(fontName: String, size: CGFloat) {
        if fontName.isEmpty {
            poemsTextView.font = UIFont(name: Constants.fontName, size: size)
        } else {
            poemsTextView.font = UIFont(name: fontName, size: size)
        }
    }
    
    func setupFontColors(color: UIColor) {
        poemsTextView.textColor = color
    }
    
    func setupBoldFont(bold: UIFont) {
        poemsTextView.font = bold
    }
    
    func setDarkMode(darkMode: Bool) {
        if darkMode {
            poemsTextView.textColor = .white
            view.backgroundColor = .black
            poemsTextView.backgroundColor = .black
        } else {
            poemsTextView.textColor = .black
            view.backgroundColor = .white
            poemsTextView.backgroundColor = .white
        }
    }
}

// MARK: - SetupUI

private extension ReaderViewController {
    
    func setupUI() {
        view.addSubview(poemsTextView)
        view.addSubview(nameLabel)
        view.addSubview(settingButton)
    }
}

// MARK: - Factory

private extension ReaderViewController {
    
    func makepoemsTextView() -> UITextView {
        let textView = UITextView()
        textView.text = poemText.text
        textView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        textView.frame = CGRect(x: 20, y: 100, width: view.bounds.width - 40, height: view.bounds.height - 150)
        textView.font = UIFont(name: Constants.fontName, size: 20)
        textView.isUserInteractionEnabled = false
        return textView
    }
    
    func makeNameLabel() -> UILabel {
        let label = UILabel()
        label.text = Constants.nameLabelText
        label.frame = CGRect(x: 57, y: 50, width: 300, height: 20)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .systemGray2
        return label
    }
    
    func makeSettingButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.settingButtonSystemName), for: .normal)
        button.frame = CGRect(x: 357, y: 50, width: 20, height: 20)
        button.tintColor = .systemPink
        button.addTarget(self, action: #selector(settingButtonAction), for: .touchUpInside)
        return button
    }
}
