//
//  DropDownMenuAttributes+SeparatorStyle.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import UIKit

public extension DropDownMenuAttributes {

    /** Describes the style for separator of the menu */
    enum SeparatorStyle {

        case `default`

        case value(color: UIColor, isBlured: Bool, style: UITableViewCell.SeparatorStyle)

        var separatorStyleValues: (color: UIColor, isBlured: Bool, style: UITableViewCell.SeparatorStyle) {
            switch self {
            case let .value(color, isBlured, style):
                return (color: color, isBlured: isBlured, style: style)
            case .default:
                return (color: .gray, isBlured: false, style: UITableViewCell.SeparatorStyle.singleLine)
            }
        }
    }
}
