//
//  AdViewDetailViewController.swift
//  AdView
//
//  Created by Nicolas SABELLA on 02/07/2020.
//  Copyright © 2020 Nicolas SABELLA. All rights reserved.
//

import UIKit

class AdViewDetailViewController: UIViewController {

//MARK: - Model Vars
    var adModel: AdModel? {
        didSet {
            if let adModel = adModel {
                titleLabel.text = adModel.title
                imageView.downloaded(from: adModel.images.smallPicture)
                descTextView.text = adModel.desc
                priceLabel.text = CurrencyFormatter.getFrenchCurrencyPrice(for: adModel.price)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMMM yyyy hh:mm"
                dateLabel.text = dateFormatter.string(from: adModel.creationDate)
                if adModel.isUrgent {
                    urgentLabel.isHidden = false
                } else {
                    urgentLabel.isHidden = true
                }
            }
        }
    }

    var category: AdCategory? {
        didSet {
            if let category = category {
                categoryLabel.text = category.name
            }
        }
    }

// MARK: - UI Vars
    var scrollView = UIScrollView()

    var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10.0
        return stackView
    }()

    var categoryAndDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 1.0
        return stackView
    }()

    var priceAndUrgentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 1.0
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.text = "Urgent"
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let urgentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Urgent"
        return label
    }()
    private let descLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Description :"
        return label
    }()

    private let descTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.backgroundColor = .backGround
        return textView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupEmptyBackButton()
        view.backgroundColor = .backGround
        title = "Détails"

        configureScrollView()
        configureMainStackView()
        configureImageView()
        configureTitleLabel()
        configureCategoryAndDateStackView()
        configurePriceAndUrgentStackView()
        configureDescTextView()
    }
}

//MARK: - Setup UI

extension AdViewDetailViewController {
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        let leadingConstraint = scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingConstraint = scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let topConstraint = scrollView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }

    private func configureMainStackView() {
        scrollView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        let leadingConstraint = mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        let trailingConstraint = mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        let topConstraint = mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        let bottomConstraint = mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        let widthConstraint = mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint,
                                     topConstraint, bottomConstraint, widthConstraint])

    }

    private func configureImageView() {
        mainStackView.addArrangedSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
    }

    private func configureTitleLabel() {
        mainStackView.addArrangedSubview(getContainerView(for: titleLabel, leftPadding: 16.0, rightPadding: 16.0))
    }

    private func configureCategoryAndDateStackView() {
        mainStackView.addArrangedSubview(categoryAndDateStackView)

        categoryAndDateStackView.addArrangedSubview(getContainerView(for: categoryLabel, leftPadding: 16.0))
        categoryAndDateStackView.addArrangedSubview(getContainerView(for: dateLabel, rightPadding: 16.0))
    }

    private func configurePriceAndUrgentStackView() {
        mainStackView.addArrangedSubview(priceAndUrgentStackView)

        priceAndUrgentStackView.addArrangedSubview(getContainerView(for: priceLabel, leftPadding: 16.0))
        priceAndUrgentStackView.addArrangedSubview(getContainerView(for: urgentLabel, rightPadding: 16.0))
    }

    private func configureDescTextView() {
        mainStackView.addArrangedSubview(getContainerView(for: descLabel, leftPadding: 16.0))
        mainStackView.addArrangedSubview(getContainerView(for: descTextView, leftPadding: 12.0, rightPadding: 12.0))
    }
}

// MARK: - Utils

extension AdViewDetailViewController {
    private func setupEmptyBackButton() {
        let barButton = UIBarButtonItem()
        barButton.title = ""
        barButton.tintColor = .orange
        navigationController?.navigationBar.topItem?.backBarButtonItem = barButton
    }

    private func getContainerView(for view: UIView,
                                  with topPadding: CGFloat = 0.0,
                                  leftPadding: CGFloat = 0.0,
                                  bottomPadding: CGFloat = 0.0,
                                  rightPadding: CGFloat = 0.0) -> UIView {
        let containerView = UIView()
        containerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.anchor(top: containerView.topAnchor,
                             left: containerView.leftAnchor,
                             bottom: containerView.bottomAnchor,
                             right: containerView.rightAnchor,
                             paddingTop: topPadding,
                             paddingLeft: leftPadding,
                             paddingBottom: bottomPadding,
                             paddingRight: rightPadding,
                             width: 0.0,
                             height: 0.0,
                             enableInsets: false)
        return containerView
    }
}
