//
//  UIView+Extensions.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import UIKit

extension UIView {
    /// Usage:
    /// aView.roundCorners(corners: [.topLeft, .topRight], radius: 3.0)
    /// -
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    // Add Shadow
    func applyShadowWithColor(color: UIColor?, opacity: Float?, offset: CGSize?, radius: CGFloat, viewCornerRadius: CGFloat?) {
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: viewCornerRadius ?? 0.0).cgPath
        layer.shadowColor = color?.cgColor ?? UIColor.black.cgColor
        layer.shadowOpacity = opacity ?? 1.0
        layer.shadowOffset = offset ?? CGSize.zero
        layer.shadowRadius = radius
    }
}
