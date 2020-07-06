//
//  UIView.swift
//  AdView
//
//  Created by Nicolas SABELLA on 05/07/2020.
//  Copyright © 2020 Nicolas SABELLA. All rights reserved.
//

import UIKit
extension UIView {

    func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)

        if #available(iOS 11, *), enableInsets {
            let insets = self.safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom

            print("Top: \(topInset)")
            print("bottom: \(bottomInset)")
        }

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

    }


    func addBorder(toSide side: UIRectEdge, withColor color: CGColor, andThickness thickness: CGFloat) {

        let border = CALayer()
        border.backgroundColor = color
        switch side {
        case .left:
            border.frame = CGRect(x: 0.0, y: 0.0, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.width-thickness, y: 0.0, width: thickness, height: frame.height)
        case .top:
            border.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: 0.0, y: frame.height-thickness, width: frame.width, height: thickness)
        default:
            break
        }

        layer.addSublayer(border)
    }
}
