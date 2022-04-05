//
//  DropDownMenuAttributes+FrameStyle.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import CoreGraphics
import UIKit

public extension DropDownMenuAttributes {

    enum ListHeight {

        case `default`
        case value(height: Int)

        var listHeightValue: Int {
            switch self {
            case let .value(height):
                return height
            case .default:
                return 0
            }
        }

    }

    /** Corner radius of the entry - Specifies the corners */
    enum RoundCorners {

        /** *None* of the corners will be round */
        case none

        /** *All* of the corners will be round */
        case all(radius: CGFloat)

        var hasRoundCorners: Bool {
            switch self {
            case .none:
                return false
            default:
                return true
            }
        }

        var cornerValue: CGFloat? {
            switch self {
            case let .all(radius):
                return radius
            case .none:
                return nil
            }
        }
    }

    /** The border around the entry */
    enum Border {

        /** No border */
        case none

        /** Border wirh color and width */
        case value(color: UIColor, width: CGFloat)

        var hasBorder: Bool {
            switch self {
            case .none:
                return false
            default:
                return true
            }
        }

        var borderValues: (color: UIColor, width: CGFloat)? {
            switch self {
            case .value(color: let color, width: let width):
                return(color: color, width: width)
            case .none:
                return nil
            }
        }
    }
}
