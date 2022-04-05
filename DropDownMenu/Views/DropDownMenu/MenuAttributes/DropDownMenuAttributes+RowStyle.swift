//
//  DropDownMenuAttributes+RowStyle.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import UIKit

public extension DropDownMenuAttributes {

    /** Describes the style for row of the menu */
    enum RowStyle {

        /** Row with default color, background color and selected color */
        case `default`

        /** Row with color, background color and selected color */
        case value(height: Int, backgroundColor: UIColor, selectedColor: UIColor)

        var rowStyleValues: (height: Int, backgroundColor: UIColor, selectedColor: UIColor) {
            switch self {
            case let .value(height, backgroundColor, selectedColor):
                return (height: height, backgroundColor: backgroundColor, selectedColor: selectedColor)
            case .default:
                return (height: 35, backgroundColor: .white, selectedColor: .clear)
            }
        }
    }
}
