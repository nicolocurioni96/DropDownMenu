//
//  DropDownMenuAttributes+TextStyle.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import UIKit

public extension DropDownMenuAttributes {

    /** Describes the style for separator of the menu */
    enum TextStyle {

        case `default`

        case value(color: UIColor, separator: String, font: UIFont?)

        var textStyleValues: (color: UIColor, separator: String, font: UIFont?) {
            switch self {
            case let .value(color, separator, font):
                return (color: color, separator: separator, font: font)
            case .default:
                return (color: .black, separator: ", ", font: .systemFont(ofSize: 12))
            }
        }
    }
}

