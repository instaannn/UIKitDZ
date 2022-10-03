//
//  CatViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 03.10.2022.
//

import UIKit
/// Экран отображения картинки
final class CatViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private var catImageView: UIImageView!
    @IBOutlet private var colorSegmentControl: UISegmentedControl!
    @IBOutlet private var alphaSlider: UISlider!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction
    
    @IBAction private func colorSegmentAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            view.backgroundColor = .systemMint
        case 1:
            view.backgroundColor = .systemPink
        default:
            view.backgroundColor = .white
        }
    }
    
    @IBAction private func sliderAction(_ sender: UISlider) {
        catImageView.alpha = CGFloat(sender.value)
    }
    
    @IBAction private func switchAction(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            catImageView.isHidden = false
            colorSegmentControl.isHidden = false
            alphaSlider.isHidden = false
        case false:
            catImageView.isHidden = true
            colorSegmentControl.isHidden = true
            alphaSlider.isHidden = true
        }
    }
    
    @IBAction private func exitButtonAction(_ sender: UIButton) {
        removeLoginPass()
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Private methods
    
    private func removeLoginPass() {
        guard let domain = Bundle.main.bundleIdentifier else { return }
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}
