//
//  CatalogViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 21.09.2022.
//

import UIKit
/// Экран каталог товаров
final class CatalogViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var product = Product()
    private lazy var imageView = makeImageView()
    private lazy var nameLabel = makeNameLabel()
    private lazy var descriptionLabel = makeDescriptionLabel()
    private lazy var productsSegmentedControl = makeSegmentedControl(
        items: product.images,
        yCoordinate: 588
    )
    private lazy var customProductSegmentedControl = makeSegmentedControl(
        items: product.customProducts,
        yCoordinate: 628
    )
    private lazy var fireImageView = makeFireImageView()
    private lazy var priceLabel = makePriceLabel()
    private lazy var orderButton = UIButton()
    private var orderInfo: (String, String) = ("", "")
    private var orderCustom = ""
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    
    @objc private func productsSegmentedControlAction(target: UISegmentedControl) {
        if target == productsSegmentedControl {
            let segmentIndex = target.selectedSegmentIndex
            switch segmentIndex {
            case 0...2:
                imageView.image = UIImage(named: product.images[segmentIndex])
                priceLabel.text = "\(product.prices[segmentIndex]) р"
                nameLabel.text = product.names[segmentIndex]
                descriptionLabel.text = product.description[segmentIndex]
                orderInfo = (product.prices[segmentIndex], product.names[segmentIndex])
            default:
                break
            }
        }
    }
    
    @objc private func customProductSegmentedControlAction(target: UISegmentedControl) {
        if target == customProductSegmentedControl {
            let segmentIndex = target.selectedSegmentIndex
            switch segmentIndex {
            case 0:
                orderCustom = product.customProducts[segmentIndex]
                fireImageView.isHidden = false
            case 1:
                fireImageView.isHidden = true
                orderCustom = product.customProducts[segmentIndex]
            default:
                break
            }
        }
    }
    
    @objc private func orderButtonAction() {
        let orderViewController = OrderViewController()
        orderViewController.modalPresentationStyle = .fullScreen
        orderViewController.orderInfo = orderInfo
        orderViewController.orderCustom = orderCustom
        present(orderViewController, animated: true)
    }
}

// MARK: - setupUI

private extension CatalogViewController {
    
    func setupUI() {
        addViews()
        addAction()
        
        orderButton.mainButton(text: "Заказать")
    }
    
    func addViews() {
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(productsSegmentedControl)
        view.addSubview(customProductSegmentedControl)
        view.addSubview(fireImageView)
        view.addSubview(priceLabel)
        view.addSubview(orderButton)
    }
    
    func addAction() {
        productsSegmentedControl.addTarget(
            self,
            action: #selector(productsSegmentedControlAction),
            for: .valueChanged
        )
        customProductSegmentedControl.addTarget(
            self,
            action: #selector(customProductSegmentedControlAction),
            for: .valueChanged
        )
        orderButton.addTarget(self, action: #selector(orderButtonAction), for: .touchUpInside)
    }
}

// MARK: - Factory

private extension CatalogViewController {
    
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "orange")
        imageView.frame = CGRect(x: 29, y: 93, width: 355, height: 355)
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }
    
    func makeNameLabel() -> UILabel {
        let label = UILabel()
        label.text = "TROPICAL VIBES"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 25)
        label.frame = CGRect(x: 29, y: 473, width: 355, height: 30)
        return label
    }
    
    func makeDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.text = "Нетрадиционный чай с яркими ягодными топингами"
        label.font = UIFont(name: "Montserrat-Light", size: 20)
        label.frame = CGRect(x: 29, y: 513, width: 355, height: 50)
        label.numberOfLines = 0
        return label
    }
    
    func makeSegmentedControl(items: [String], yCoordinate: Int) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.frame = CGRect(x: 29, y: yCoordinate, width: 355, height: 30)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }
    
    func makeFireImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "flame.circle.fill")
        imageView.frame = CGRect(x: 347, y: 78, width: 50, height: 50)
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.backgroundColor = .white
        imageView.isHidden = false
        return imageView
    }
    
    func makePriceLabel() -> UILabel {
        let label = UILabel()
        label.text = "500 р"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 20)
        label.frame = CGRect(x: 264, y: 683, width: 120, height: 30)
        label.textAlignment = .right
        return label
    }
}
