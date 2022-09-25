//
//  FriendsViewController.swift
//  UIKitDZ
//
//  Created by Анна Сычева on 25.09.2022.
//

import UIKit
/// Экран списка друзей
final class FriendsViewController: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var firstAvatarImageView = makeAvatarImageView(yCoordinate: 110)
    private lazy var secondAvatarImageView = makeAvatarImageView(yCoordinate: 200)
    private lazy var thirdAvatarImageView = makeAvatarImageView(yCoordinate: 292)
    private lazy var firstNameLabel = makeNameLabel(name: "Jeremy", yCoordinate: 108)
    private lazy var secondNameLabel = makeNameLabel(name: "Maria Lui", yCoordinate: 200)
    private lazy var thirdNameLabel = makeNameLabel(name: "Jony Stark", yCoordinate: 292)
    private lazy var firstBirthdayLabel = makeBirthdayLabel(birthday: Constants.firstBirthday, yCoordinate: 138)
    private lazy var secondBirthdayLabel = makeBirthdayLabel(birthday: Constants.secondBirthday, yCoordinate: 230)
    private lazy var thirdBirthdayLabel = makeBirthdayLabel(birthday: Constants.thirdBirthday, yCoordinate: 322)
    private lazy var firstDateLabel = makeDateLabel(date: "18 дней", yCoordinate: 108)
    private lazy var secondDateLabel = makeDateLabel(date: "28 дней", yCoordinate: 200)
    private lazy var thirdDateLabel = makeDateLabel(date: "53 дня", yCoordinate: 292)
    private lazy var firstSeparatorView = makeSeparatorView(yCoordinate: 179)
    private lazy var secondSeparatorView = makeSeparatorView(yCoordinate: 271)
    private lazy var thirdSeparatorView = makeSeparatorView(yCoordinate: 363)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .white
    }
    
    // MARK: - Actions
    
    @objc private func rightButtonAction() {
        let friendInfoViewController = FriendInfoViewController()
        friendInfoViewController.modalPresentationStyle = .formSheet
        navigationController?.present(friendInfoViewController, animated: true)
    }
    
    // MARK: - Private methods

    private func dayToBirthday(month: Int, day: Int) -> Int {
        let birthDateCoponents = DateComponents(month: month, day: day)
        guard let nextBirthDate = Calendar.current.nextDate(
            after: Date(),
            matching: birthDateCoponents,
            matchingPolicy: .nextTime
        ) else { return 0 }
        
        let difference = Calendar.current.dateComponents(
            [.day, .hour, .minute, .second],
            from: Date(),
            to: nextBirthDate
        )
        guard let day = difference.day else { return 0 }
        return day
    }
}

// MARK: - setupUI

private extension FriendsViewController {
    
    func setupUI() {
        addView()
        setupNavigationController()
        setupDays()
    }
    
    func addView() {
        view.addSubview(firstAvatarImageView)
        view.addSubview(secondAvatarImageView)
        view.addSubview(thirdAvatarImageView)
        view.addSubview(firstNameLabel)
        view.addSubview(secondNameLabel)
        view.addSubview(thirdNameLabel)
        view.addSubview(firstBirthdayLabel)
        view.addSubview(secondBirthdayLabel)
        view.addSubview(thirdBirthdayLabel)
        view.addSubview(firstDateLabel)
        view.addSubview(secondDateLabel)
        view.addSubview(thirdDateLabel)
        view.addSubview(firstSeparatorView)
        view.addSubview(secondSeparatorView)
        view.addSubview(thirdSeparatorView)
    }
    
    func setupNavigationController() {
        navigationItem.title = "Birthday"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(rightButtonAction)
        )
    }
    
    func setupDays() {
        firstDateLabel.text = "\(dayToBirthday(month: 3, day: 10)) дней"
        secondDateLabel.text = "\(dayToBirthday(month: 3, day: 30)) дней"
        thirdDateLabel.text = "\(dayToBirthday(month: 4, day: 20)) дней"
    }
}

// MARK: - Factory

private extension FriendsViewController {
    
    func makeAvatarImageView(yCoordinate: Int) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar")
        imageView.frame = CGRect(x: 15, y: yCoordinate, width: 60, height: 60)
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.backgroundColor = .systemGray5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    func makeNameLabel(name: String, yCoordinate: Int) -> UILabel {
        let label = UILabel()
        label.text = name
        label.frame = CGRect(x: 87, y: yCoordinate, width: 220, height: 25)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        return label
    }
    
    func makeBirthdayLabel(birthday: String, yCoordinate: Int) -> UILabel {
        let label = UILabel()
        label.text = birthday
        label.frame = CGRect(x: 87, y: yCoordinate, width: 300, height: 18)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .systemGray3
        return label
    }
    
    func makeDateLabel(date: String, yCoordinate: Int) -> UILabel {
        let label = UILabel()
        label.text = date
        label.frame = CGRect(x: 320, y: yCoordinate, width: 80, height: 25)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .systemGray3
        label.textAlignment = .right
        return label
    }
    
    func makeSeparatorView(yCoordinate: Int) -> UIView {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.frame = CGRect(x: 28, y: yCoordinate, width: 385, height: 2)
        return view
    }
 }

// MARK: - Constants

private extension FriendsViewController {
    
    enum Constants {
        static let firstBirthday: String = "10 марта, в среду исполнится 25 лет"
        static let secondBirthday: String = "30 марта, в четверг исполнится 20 лет"
        static let thirdBirthday: String = "20 апреля,  субботу исполится 25 лет"
    }
}
