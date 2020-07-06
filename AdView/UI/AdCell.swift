//
//  AdCell.swift
//  AdView
//
//  Created by Nicolas SABELLA on 05/07/2020.
//  Copyright © 2020 Nicolas SABELLA. All rights reserved.
//

import UIKit

class AdCell: UITableViewCell {

    var adModel: AdModel?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
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

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let urgentlabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Urgent"
        return label
    }()

    private let adImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(urgentlabel)

        let containerView = UIView()
        containerView.addSubview(adImageView)
        containerView.addSubview(stackView)

        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 3
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.black.cgColor

        contentView.backgroundColor = .backGround
        contentView.layer.cornerRadius = 8
        contentView.addSubview(containerView)

        containerView.anchor(top: topAnchor,
                             left: leftAnchor,
                             bottom: bottomAnchor,
                             right: rightAnchor,
                             paddingTop: 2.5,
                             paddingLeft: 5.0,
                             paddingBottom: 2.5,
                             paddingRight: 5.0,
                             width: 0.0,
                             height: 0.0,
                             enableInsets: false)

        adImageView.anchor(top: containerView.topAnchor,
                           left: containerView.leftAnchor,
                           bottom: bottomAnchor,
                           right: nil,
                           paddingTop: 0.0,
                           paddingLeft: 0.0,
                           paddingBottom: 0.0,
                           paddingRight: 0.0,
                           width: 100.0,
                           height: 0.0,
                           enableInsets: false)

        stackView.anchor(top: containerView.topAnchor,
                         left: adImageView.rightAnchor,
                         bottom: containerView.bottomAnchor,
                         right: containerView.rightAnchor,
                         paddingTop: 0.0,
                         paddingLeft: 10.0,
                         paddingBottom: 5.0,
                         paddingRight: 0.0,
                         width: 0.0,
                         height: 0.0,
                         enableInsets: false)
    }

    override func prepareForReuse() {
        titleLabel.text = nil
        adImageView.image = nil
        urgentlabel.isHidden = true
    }

    func configure(with adModel: AdModel, categoryService: CategoryService) {
        self.adModel = adModel

        titleLabel.text = adModel.title
        adImageView.downloaded(from: adModel.images.thumbnail)

        priceLabel.text = CurrencyFormatter.getFrenchCurrencyPrice(for: adModel.price)

        // Getting the category from the global list
        if let category = categoryService.getCategory(for: adModel.categoryId) {
            categoryLabel.text = category.name
        }

        if adModel.isUrgent {
            urgentlabel.isHidden = false
        } else {
            urgentlabel.isHidden = true
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
