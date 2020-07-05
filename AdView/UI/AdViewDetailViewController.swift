//
//  AdViewDetailViewController.swift
//  AdView
//
//  Created by Nicolas SABELLA on 02/07/2020.
//  Copyright © 2020 Nicolas SABELLA. All rights reserved.
//

import UIKit

class AdViewDetailViewController: UIViewController {

    // Model
    var adModel: AdModel?

    // UI Conponents
    var scrollView = UIScrollView()
    /// StackViews
    var mainStackView = UIStackView()
    var infoStackView = UIStackView()
    var leftInfoStackView = UIStackView()
    var rightInfoStackView = UIStackView()

    let titleLabel = UILabel()
    let categoryLabel = UILabel()
    let priceLabel = UILabel()
    let descTextView = UITextView()
    let imageView = UIImageView()
    let isUrgentImage = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        configureScrollView()
        configureMainStackView()
        configureImageView()
        configureInfoStackView()
        configureLeftInfoStackView()
//        configureRightInfoStackView()
        configureDescTextView()
    }

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
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        mainStackView.spacing = 1.0
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        let leadingConstraint = mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        let trailingConstraint = mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        let topConstraint = mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        let bottomConstraint = mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        let widthConstraint = mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint,
                                     topConstraint, bottomConstraint, widthConstraint])

    }

    private func configureInfoStackView() {
        let containerView = UIView()
        containerView.addSubview(infoStackView)
        mainStackView.addArrangedSubview(containerView)

        infoStackView.axis = .horizontal
        infoStackView.alignment = .center
        infoStackView.distribution = .fill
        infoStackView.spacing = 1.0

        infoStackView.translatesAutoresizingMaskIntoConstraints = false

        infoStackView.anchor(top: containerView.topAnchor,
                                 left: containerView.leftAnchor,
                                 bottom: containerView.bottomAnchor,
                                 right: containerView.rightAnchor,
                                 paddingTop: 0.0,
                                 paddingLeft: 0.0,
                                 paddingBottom: 0.0,
                                 paddingRight: 0.0,
                                 width: 0.0,
                                 height: 100.0,
                                 enableInsets: false)


//        let leadingConstraint = infoStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor)
//        let trailingConstraint = infoStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
//        NSLayoutConstraint.activate([ leadingConstraint, trailingConstraint])
    }

    private func configureLeftInfoStackView() {
        leftInfoStackView.axis = .vertical
        leftInfoStackView.alignment = .center
        leftInfoStackView.distribution = .fillEqually
        leftInfoStackView.spacing = 1.0

        let containerView = UIView()
        containerView.addSubview(leftInfoStackView)
        infoStackView.addSubview(containerView)

        leftInfoStackView.anchor(top: containerView.topAnchor,
                                 left: containerView.leftAnchor,
                                 bottom: containerView.bottomAnchor,
                                 right: containerView.rightAnchor,
                                 paddingTop: 0.0,
                                 paddingLeft: 0.0,
                                 paddingBottom: 0.0,
                                 paddingRight: 0.0,
                                 width: 0.0,
                                 height: 0.0,
                                 enableInsets: false)

        // TO delete
        titleLabel.text = "Title"
        categoryLabel.text = "Category"
        let titleContainer = UIView()
        let categoryContainer = UIView()
//        titleContainer.addSubview(titleLabel)
//        categoryContainer.addSubview(categoryLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.anchor(top: titleContainer.topAnchor,
                          left: titleContainer.leftAnchor,
                          bottom: titleContainer.bottomAnchor,
                          right: titleContainer.rightAnchor,
                          paddingTop: 8.0,
                          paddingLeft: 16.0,
                          paddingBottom: 8.0,
                          paddingRight: 16.0,
                          width: 0.0,
                          height: 0.0,
                          enableInsets: false)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.anchor(top: categoryContainer.topAnchor,
                             left: categoryContainer.leftAnchor,
                             bottom: categoryContainer.bottomAnchor,
                             right: categoryContainer.rightAnchor,
                             paddingTop: 8.0,
                             paddingLeft: 16.0,
                             paddingBottom: 8.0,
                             paddingRight: 16.0,
                             width: 0.0,
                             height: 0.0,
                             enableInsets: false)

        leftInfoStackView.addArrangedSubview(titleContainer)
        leftInfoStackView.addArrangedSubview(categoryContainer)
    }

    private func configureRightInfoStackView() {
        let containerView = UIView()
        containerView.addSubview(rightInfoStackView)
        infoStackView.addSubview(containerView)

        rightInfoStackView.axis = .vertical
        rightInfoStackView.alignment = .center
        rightInfoStackView.distribution = .fill
        rightInfoStackView.spacing = 1.0

        rightInfoStackView.anchor(top: containerView.topAnchor,
                                  left: containerView.leftAnchor,
                                  bottom: containerView.bottomAnchor,
                                  right: containerView.rightAnchor,
                                  paddingTop: 0.0,
                                  paddingLeft: 0.0,
                                  paddingBottom: 0.0,
                                  paddingRight: 0.0,
                                  width: 0.0,
                                  height: 0.0,
                                  enableInsets: false)

        // To delete
        priceLabel.text = "100.0€"
        isUrgentImage.backgroundColor = .red
//        isUrgentImage.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
//        isUrgentImage.widthAnchor.constraint(equalToConstant: 50.0).isActive = true

        rightInfoStackView.addArrangedSubview(isUrgentImage)
        rightInfoStackView.addArrangedSubview(priceLabel)
    }

    private func configureImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .green
        mainStackView.addArrangedSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 150.0)
        NSLayoutConstraint.activate([heightConstraint])
    }
    private func configureDescTextView() {
        descTextView.isEditable = false
        descTextView.isSelectable = false
        descTextView.isScrollEnabled = false
        descTextView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Orci a scelerisque purus semper eget. Facilisis mauris sit amet massa vitae tortor condimentum lacinia. Purus viverra accumsan in nisl nisi scelerisque. Cursus euismod quis viverra nibh cras pulvinar mattis nunc. Aliquam faucibus purus in massa. Id eu nisl nunc mi ipsum faucibus vitae. Eget nullam non nisi est sit amet facilisis. Aliquam eleifend mi in nulla posuere sollicitudin aliquam ultrices sagittis. Urna nunc id cursus metus. Fames ac turpis egestas integer eget aliquet nibh. Vitae congue eu consequat ac. At lectus urna duis convallis convallis tellus id. Purus gravida quis blandit turpis cursus in hac habitasse platea. Vestibulum rhoncus est pellentesque elit ullamcorper dignissim cras. Faucibus ornare suspendisse sed nisi lacus sed. Ut lectus arcu bibendum at varius vel pharetra vel turpis. In metus vulputate eu scelerisque. Mi in nulla posuere sollicitudin aliquam ultrices sagittis orci. Ut consequat semper viverra nam libero justo laoreet. Sed sed risus pretium quam vulputate dignissim suspendisse. Convallis aenean et tortor at risus viverra. Sit amet dictum sit amet justo. Euismod lacinia at quis risus sed vulputate. Congue eu consequat ac felis donec et. Volutpat maecenas volutpat blandit aliquam etiam. Nibh sed pulvinar proin gravida hendrerit lectus a. Purus sit amet volutpat consequat mauris nunc congue nisi. Quam vulputate dignissim suspendisse in est ante in. Diam maecenas ultricies mi eget mauris pharetra et ultrices. Diam sit amet nisl suscipit adipiscing. Posuere morbi leo urna molestie at elementum. Ornare arcu dui vivamus arcu felis. Arcu odio ut sem nulla pharetra diam sit amet nisl. Convallis aenean et tortor at risus viverra adipiscing at. Netus et malesuada fames ac turpis egestas sed tempus. Condimentum vitae sapien pellentesque habitant morbi tristique senectus et. Purus semper eget duis at tellus at urna condimentum. Imperdiet sed euismod nisi porta lorem mollis. Ac tortor dignissim convallis aenean et tortor at. Nulla posuere sollicitudin aliquam ultrices sagittis. In metus vulputate eu scelerisque. Est placerat in egestas erat imperdiet. Phasellus vestibulum lorem sed risus ultricies tristique nulla aliquet. Enim praesent elementum facilisis leo vel. Habitasse platea dictumst vestibulum rhoncus est pellentesque elit. Ut consequat semper viverra nam libero justo. Amet consectetur adipiscing elit pellentesque habitant morbi tristique. Tincidunt praesent semper feugiat nibh sed. Turpis in eu mi bibendum neque egestas congue quisque."
        mainStackView.addArrangedSubview(descTextView)
    }
}
