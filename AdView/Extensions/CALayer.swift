//
//  CALayer.swift
//  AdView
//
//  Created by Nicolas SABELLA on 06/07/2020.
//  Copyright © 2020 Nicolas SABELLA. All rights reserved.
//

import UIKit

extension CALayer {

    /**
     Add view's border.

     - Properties:
     - edge: The border's edge
     - color: The border's color
     - thickness: The border's thickness
     */
    func addBorder(
        edge: UIRectEdge,
        color: UIColor,
        thickness: CGFloat
    ) {
        let border = CALayer()
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
        case UIRectEdge.right:
            border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
        default:
            break
        }
        border.backgroundColor = color.cgColor
        addSublayer(border)
    }

}
