//
//  UIView+Extensions.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import UIKit

extension UIView {
    /// Returns the `ParentViewController` for any view.
    var parentViewController: UIViewController? {
        var responder: UIResponder? = self
        while !(responder is UIViewController) {
            responder = responder?.next
            if responder == nil {
                break
            }
        }
        return (responder as? UIViewController)
    }
}
