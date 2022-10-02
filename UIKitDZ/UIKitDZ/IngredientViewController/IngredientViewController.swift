//
//  IngredientViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 29.09.2022.
//

import UIKit

protocol GoToCatalogVCDelegate: AnyObject {
    func goBack()
}

/// Экран выбора ингредиентов
final class IngredientViewController: UIViewController {
    
    // MARK: - Public properties
    
    var pizza: Pizza?
    
    // MARK: - Private properties
    
    private lazy var pizzaNameLabel = makePizzaNameLabel()
    private lazy var pizzaImageView = makePizzaImageView()
    private lazy var cheeseLabel = makeIngredientLabel(text: "Сыр моцарелла", yCoordinate: 535)
    private lazy var hamLabel = makeIngredientLabel(text: "Ветчина", yCoordinate: 587)
    private lazy var mushroomsLabel = makeIngredientLabel(text: "Грибы", yCoordinate: 639)
    private lazy var olivesLabel = makeIngredientLabel(text: "Маслины", yCoordinate: 691)
    private lazy var cheeseSwitch = makeSwitch(yCoordinate: 535)
    private lazy var hamSwitch = makeSwitch(yCoordinate: 587)
    private lazy var mushroomsSwitch = makeSwitch(yCoordinate: 639)
    private lazy var olivesSwitch = makeSwitch(yCoordinate: 691)
    private lazy var selectButton = UIButton()
    private lazy var infoButton = makeInfoButton()
    private lazy var sizeSegmented = makeSizeSegmented()
    private lazy var sizeArray = ["Маленькая", "Средняя", "Большая"]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    // MARK: - Private Actions
    
    @objc private func selectButtonAction() {
        let paymentViewController = PaymentViewController()
        guard let name = pizza?.name else { return }
        paymentViewController.pizza = Pizza(
            name: name,
            imageName: nil,
            ingredient: updateModel(),
            composition: nil,
            images: nil
        )
        paymentViewController.delegate = self
        let navVc = UINavigationController(rootViewController: paymentViewController)
        navVc.modalPresentationStyle = .fullScreen
        present(navVc, animated: true)
    }
    
    @objc private func infoButtonAction() {
        let compositionViewController = CompositionViewController()
        compositionViewController.modalPresentationStyle = .pageSheet
        compositionViewController.pizza = pizza
        present(compositionViewController, animated: true)
    }
    
    @objc private func sizeSegmentAction(_ sender: UISegmentedControl) {
        let segmentIndex = sender.selectedSegmentIndex
        guard let images = pizza?.images else { return }
        switch segmentIndex {
        case 0...2:
            pizzaImageView.image = UIImage(named: images[segmentIndex])
        default:
            break
        }
    }
    
    // MARK: - Private methods

    // Как можно улучшить эту часть?
    private func updateModel() -> [String] {
        var ingredient: [String] = [String]()
        
        let switchesMap: [UISwitch: UILabel] = [cheeseSwitch: cheeseLabel,
                                                hamSwitch: hamLabel,
                                          mushroomsSwitch: mushroomsLabel,
                                             olivesSwitch: olivesLabel]
        
        for (key, value) in switchesMap where key.isOn {
            ingredient.append(value.text ?? "")
        }
        return ingredient
    }
}

// MARK: - GoToCatalogVCDelegate

extension IngredientViewController: GoToCatalogVCDelegate {
    
    func goBack() {
        if let vc = self.presentingViewController as? UINavigationController {
            dismiss(animated: false)
            view.isHidden = true
            vc.popToRootViewController(animated: false)
        }
    }
}

// MARK: - Setup

private extension IngredientViewController {
    
    func setupUI() {
        setupPizza()
        addViews()
        setupSelectButton()
    }
    
    func addViews() {
        view.addSubview(pizzaNameLabel)
        view.addSubview(pizzaImageView)
        view.addSubview(cheeseLabel)
        view.addSubview(hamLabel)
        view.addSubview(mushroomsLabel)
        view.addSubview(olivesLabel)
        view.addSubview(cheeseSwitch)
        view.addSubview(hamSwitch)
        view.addSubview(mushroomsSwitch)
        view.addSubview(olivesSwitch)
        view.addSubview(selectButton)
        view.addSubview(infoButton)
        view.addSubview(sizeSegmented)
    }
    
    func setupSelectButton() {
        selectButton.mainButton(text: "Выбрать", xCoordinate: 35, yCoordinate: 750)
        selectButton.addTarget(self, action: #selector(selectButtonAction), for: .touchUpInside)
    }
    
    func setupPizza() {
        guard let pizza = pizza else { return }
        pizzaNameLabel.text = pizza.name
        pizzaImageView.image = UIImage(named: pizza.imageName ?? "")
    }
}

// MARK: - Factory

private extension IngredientViewController {
    
    func makePizzaNameLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "AlumniSans-SemiBold", size: 50)
        label.frame = CGRect(x: 57, y: 50, width: 300, height: 50)
        label.textAlignment = .center
        return label
    }
    
    func makePizzaImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 29, y: 120, width: 355, height: 355)
        return imageView
    }
    
    func makeIngredientLabel(text: String, yCoordinate: Int) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: "AlumniSans-Light", size: 25)
        label.frame = CGRect(x: 29, y: yCoordinate, width: 270, height: 32)
        return label
    }
    
    func makeSwitch(yCoordinate: Int) -> UISwitch {
        let mySwitch = UISwitch()
        mySwitch.onTintColor = UIColor(displayP3Red: 227 / 252, green: 30 / 252, blue: 35 / 252, alpha: 1)
        mySwitch.frame = CGRect(x: 332, y: yCoordinate, width: 52, height: 32)
        return mySwitch
    }
    
    func makeInfoButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.tintColor = UIColor(displayP3Red: 227 / 252, green: 30 / 252, blue: 35 / 252, alpha: 1)
        button.frame = CGRect(x: 344, y: 55, width: 40, height: 40)
        button.addTarget(self, action: #selector(infoButtonAction), for: .touchUpInside)
        return button
    }
    
    func makeSizeSegmented() -> UISegmentedControl {
        let segmented = UISegmentedControl(items: sizeArray)
        segmented.selectedSegmentIndex = 0
        segmented.frame = CGRect(x: 29, y: 483, width: 355, height: 30)
        segmented.addTarget(self, action: #selector(sizeSegmentAction(_:)), for: .valueChanged)
        return segmented
    }
}
