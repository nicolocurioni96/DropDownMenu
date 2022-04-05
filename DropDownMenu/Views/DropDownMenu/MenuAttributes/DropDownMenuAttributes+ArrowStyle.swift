//
//  DropDownMenuAttributes+ArrowStyle.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import UIKit

public extension DropDownMenuAttributes {

    /** Describes the style for row of the menu */
    enum ArrowStyle {

        case `default`

        case value(isEnabled: Bool, image: UIImage? = nil)

        var arrowStyleValues: (isEnabled: Bool, image: UIImage?) {
            let frameworkBundle = Bundle(for: DropDownMenu.self)
            let defaultImage = UIImage(named: ButtonImageName.arrowBottom.rawValue, in: frameworkBundle, compatibleWith: nil)!

            switch self {
            case let .value(isEnabled, image):
                if isEnabled && image != nil {
                    return (isEnabled: isEnabled, image: image)
                } else if isEnabled {
                    return (isEnabled: isEnabled, image: defaultImage)
                } else {
                    return (isEnabled: isEnabled, image: nil)
                }
            case .default:
                return (isEnabled: true, image: defaultImage)
            }
        }
    }
}

