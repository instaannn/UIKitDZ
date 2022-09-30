//
//  CatalogViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 28.09.2022.
//

import UIKit
/// Экран каталога суши и пицца
final class CatalogViewController: UIViewController {
    
    // MARK: - Private properties

    private lazy var pizzaShadowView = makeShadowView(yCoordinate: 181)
    private lazy var pizzaImageView = makeImageView(named: "pizza", yCoordinate: 200)
    private lazy var pizzaLabel = makeLabel(text: "PIZZA", yCoordinate: 200)
    private lazy var sushiShadowView = makeShadowView(yCoordinate: 356)
    private lazy var sushiImageView = makeImageView(named: "sushi", yCoordinate: 376)
    private lazy var sushiLabel = makeLabel(text: "SUSHI", yCoordinate: 376)
    private lazy var openPizzaButton = makeOpenPizzaButton()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .white
    }
    
    // MARK: - Actions
    
    @objc private func openPizzaButtonAction() {
        let pizzasViewController = PizzasViewController()
        pizzasViewController.pizza = [
            Pizza(
                name: "ПЕППЕРОНИ",
                imageName: "pepperonismall",
                ingredient: nil,
                composition: """
Традиционное тесто
Пикантная пепперони, увеличенная порция моцареллы, фирменный томатный соус

Пищевая ценность на 100 г
Энерг. ценность 270 ккал
Белки 10,9 г
Жиры 10,8 г
Углеводы 30,4 г
""",
                images: ["pepperonismall", "pepperonimedium", "pepperoni"]
            ),
            Pizza(
                name: "ВЕТЧИНА-СЫР",
                imageName: "cheesesmall",
                ingredient: nil,
                composition: """
Традиционное тесто, 670 г
Ветчина, моцарелла, фирменный соус альфредо

Пищевая ценность на 100 г
Энерг. ценность 273,4 ккал
Белки 10 г
Жиры 9,7 г
Углеводы 34,6 г
""",
                images: ["cheesesmall", "cheesemedium", "cheese"]
            )
        ]
        navigationController?.pushViewController(pizzasViewController, animated: true)
    }
}

// MARK: - setupUI

private extension CatalogViewController {
    
    func setupUI() {
        view.addSubview(pizzaShadowView)
        view.addSubview(pizzaImageView)
        view.addSubview(pizzaLabel)
        view.addSubview(sushiShadowView)
        view.addSubview(sushiImageView)
        view.addSubview(sushiLabel)
        view.addSubview(openPizzaButton)
        
        setupNavigationController()
    }
    
    func setupNavigationController() {
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.title = "PIZZA & SUSHI"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

// MARK: - Factory

private extension CatalogViewController {
    
    func makeShadowView(yCoordinate: Int) -> UIView {
        let view = UIView()
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.1)
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.frame = CGRect(x: 37, y: yCoordinate, width: 345, height: 140)
        return view
    }
    
    func makeImageView(named: String, yCoordinate: Int) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: named)
        imageView.frame = CGRect(x: 80, y: yCoordinate, width: 100, height: 100)
        return imageView
    }
    
    func makeLabel(text: String, yCoordinate: Int) -> UILabel {
        let label = UILabel()
        label.text = text
        label.frame = CGRect(x: 207, y: yCoordinate, width: 100, height: 100)
        label.font = UIFont(name: "AlumniSans-Light", size: 40)
        return label
    }
    
    func makeOpenPizzaButton() -> UIButton {
        let button = UIButton()
        button.frame = CGRect(x: 37, y: 181, width: 345, height: 140)
        button.addTarget(self, action: #selector(openPizzaButtonAction), for: .touchUpInside)
        return button
    }
}
