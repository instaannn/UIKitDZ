//
//  PizzasViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 28.09.2022.
//

import UIKit
/// Экран каталога пицц
final class PizzasViewController: UIViewController {
    
    // MARK: - Public properties
    
    var pizza: [Pizza] = [Pizza]()
    
    // MARK: - Private properties

    private lazy var pepperoniImageView = makeImageView(named: "pepperoni", yCoordinate: 128)
    private lazy var mushroomsImageView = makeImageView(named: "cheese", yCoordinate: 279)
    private lazy var pepperoniLabel = makeLabel(text: "ПЕППЕРОНИ", yCoordinate: 168)
    private lazy var mushroomsLabel = makeLabel(text: "ВЕТЧИНА-СЫР", yCoordinate: 319)
    private lazy var selectPepperoni = makeButton(yCoordinate: 168)
    private lazy var selectMushrooms = makeButton(yCoordinate: 319)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .white
    }
    
    @objc private func goToIngredientViewController(_ sender: UIButton) {
        switch sender.tag {
        case 0...1:
            let ingredientViewController = IngredientViewController()
            ingredientViewController.pizza = pizza[sender.tag]
            ingredientViewController.modalPresentationStyle = .pageSheet
            navigationController?.present(ingredientViewController, animated: true)
        default:
            break
        }
    }
}

// MARK: - setupUI

private extension PizzasViewController {
    
    func setupUI() {
        view.addSubview(pepperoniImageView)
        view.addSubview(mushroomsImageView)
        view.addSubview(pepperoniLabel)
        view.addSubview(mushroomsLabel)
        view.addSubview(selectPepperoni)
        view.addSubview(selectMushrooms)
        
        setupNAvigationController()
        setupPlusButton()
    }
    
    func setupNAvigationController() {
        navigationItem.title = "PIZZA"
        navigationItem.backButtonTitle = ""
    }
    
    func setupPlusButton() {
        selectPepperoni.tag = 0
        selectMushrooms.tag = 1
    }
}

// MARK: - Factory

private extension PizzasViewController {
    
    func makeImageView(named: String, yCoordinate: Int) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: named)
        imageView.frame = CGRect(x: 20, y: yCoordinate, width: 115, height: 115)
        return imageView
    }
    
    func makeLabel(text: String, yCoordinate: Int) -> UILabel {
        let label = UILabel()
        label.text = text
        label.frame = CGRect(x: 155, y: yCoordinate, width: 184, height: 40)
        label.font = UIFont(name: "AlumniSans-Light", size: 40)
        return label
    }
    
    func makeButton(yCoordinate: Int) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(displayP3Red: 227/252, green: 30/252, blue: 35/252, alpha: 1)
        button.frame = CGRect(x: 354, y: yCoordinate, width: 40, height: 40)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(goToIngredientViewController(_:)), for: .touchUpInside)
        return button
    }
}
