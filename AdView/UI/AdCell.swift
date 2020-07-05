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

    private let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()

    private let categoryLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let adImageView : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        addSubview(categoryLabel)
        addSubview(adImageView)


        adImageView.anchor(top: topAnchor,
                           left: leftAnchor,
                           bottom: bottomAnchor,
                           right: nil,
                           paddingTop: 0,
                           paddingLeft: 0,
                           paddingBottom: 0,
                           paddingRight: 0,
                           width: 100,
                           height: 0,
                           enableInsets: false)
        titleLabel.anchor(top: topAnchor,
                          left: adImageView.rightAnchor,
                          bottom: nil,
                          right: rightAnchor,
                          paddingTop: 20,
                          paddingLeft: 10,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: frame.size.width / 2,
                          height: 0,
                          enableInsets: false)
        categoryLabel.anchor(top: titleLabel.bottomAnchor,
                             left: adImageView.rightAnchor,
                             bottom: nil,
                             right: nil,
                             paddingTop: 0,
                             paddingLeft: 10,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: frame.size.width / 2,
                             height: 0,
                             enableInsets: false)
    }

    override func prepareForReuse() {
        adImageView.image = nil
    }

    func configure(with adModel: AdModel) {
        self.adModel = adModel

        titleLabel.text = adModel.title
//        categoryLabel.text = adModel.category.name
        adImageView.downloaded(from: adModel.images.thumbnail)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
