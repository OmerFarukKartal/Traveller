//
//  UIView+Ext.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 2.05.2024.
//

import UIKit

extension UIView {
    // Anchor extension method
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }

        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }

        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }

        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

    // for addsubview
    func addSubviewsFromExt(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }

    // for width and height
    func configSize(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    // Anchor extension method for centering horizontally
    func anchorToCenterX(of parentView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
    }

    // Anchor extension method for aligning to bottom with optional constant
    func anchorToBottom(of parentView: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: constant).isActive = true
    }
}
