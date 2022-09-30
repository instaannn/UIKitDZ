//
//  SendPostcardViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 26.09.2022.
//

import Foundation
import UIKit
/// Экран отправки открыток
final class SendPostcardViewController: UIViewController {
    
    // MARK: - IBOutlet

    @IBOutlet weak var nameSegmentedControl: UISegmentedControl!
    @IBOutlet weak var postcardImageView: UIImageView!
    @IBOutlet weak var congratulationTextField: UITextField!
    
    // MARK: - Private properties

    private lazy var imageArray = [UIImage(named: "1"),
                                   UIImage(named: "2"),
                                   UIImage(named: "3"),
                                   UIImage(named: "4")]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - IBAction
    
    @IBAction func selectSegmentedControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            postcardImageView.image = imageArray[sender.selectedSegmentIndex]
        case 1:
            postcardImageView.image = imageArray[sender.selectedSegmentIndex]
        case 2:
            postcardImageView.image = imageArray[sender.selectedSegmentIndex]
        case 3:
            postcardImageView.image = imageArray[sender.selectedSegmentIndex]
        default:
            break
        }
    }
    
    @IBAction func sendButtonAction(_ sender: UIButton) {
        guard let text = congratulationTextField.text else { return }
        if text.isEmpty {
            self.showAlert(title: "Ups!", message: "Сначала введите текст")
        } else {
            let selectedIndex = nameSegmentedControl.selectedSegmentIndex
            guard let image = imageArray[selectedIndex] else { return }
            let activity = UIActivityViewController(
                activityItems: [image, congratulationTextField.text ?? "nil"],
                applicationActivities: .none
            )
            present(activity, animated: true, completion: .none)
        }
    }
}

// MARK: - SetupUI

private extension SendPostcardViewController {
    
    func setupUI() {
        nameSegmentedControl.selectedSegmentIndex = 0
        postcardImageView.image = UIImage(named: "1")
    }
}
