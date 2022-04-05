//
//  DropDownMenuAttributes+SelectionBehavior.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import Foundation

public extension DropDownMenuAttributes {

    /** Describes the event of scroll user interaction */
    enum MultiSelection {

        /** The scroll ability is totally disabled */
        case disabled

        /** The scroll abiliby is enabled */
        case enabled

        var isEnabled: Bool {
            switch self {
            case .disabled:
                return false
            default:
                return true
            }
        }
    }

    /** Describes the event of scroll user interaction */
    enum HideMenuWhenSelection {

        /** The scroll ability is totally disabled */
        case disabled

        /** The scroll abiliby is enabled */
        case enabled

        var isEnabled: Bool {
            switch self {
            case .disabled:
                return false
            default:
                return true
            }
        }
    }
}
