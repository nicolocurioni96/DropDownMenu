//
//  DropDownMenuAttributes+PlaceHolderStyle.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import UIKit

public extension DropDownMenuAttributes {

    /** Describes the style for row of the menu */
    enum PlaceHolderStyle {

        /** Placeholder with text and color */
        case value(text: String, textColor: UIColor)

        var placeHolderValues: (text: String, textColor: UIColor) {
            switch self {
            case let .value(text, textColor):
                return (text: text, textColor: textColor)
            }
        }
    }
}
