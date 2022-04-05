//
//  DropDownMenuAttributes+HeaderStyle.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import UIKit

public extension DropDownMenuAttributes {

    /** Describes the style for header of the menu */
    enum HeaderStyle {

        /** Row with background color */
        case value(backgroundColor: UIColor, height: Int)

        var headerStyleValues: (backgroundColor: UIColor, height: Int) {
            switch self {
            case let .value(backgroundColor, height):
                return (backgroundColor: backgroundColor, height: height)
            }
        }
    }
}
