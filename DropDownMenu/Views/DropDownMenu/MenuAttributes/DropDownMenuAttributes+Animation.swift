//
//  DropDownMenuAttributes+Animation.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import Foundation

extension DropDownMenuAttributes {
    /// Type describing the Animation Styles used to create the animation of Expanding and Collapsing `SwiftyMenu`.
    public enum Animation {
        /// `SwiftyMenu` animation should be linear (Smooth Animation)
        case linear

        /// `SwiftyMenu` animation should be spring (Bouncy Animation)
        case spring(level: SpringPowerLevel)

        /// Defines how bouncy the animation should be
        ///
        /// - low: Bit of smooth and a bit of bounciness at the end
        /// - normal: Not too bouncy and not too smooth
        /// - high: Too bouncy
        public enum SpringPowerLevel: Double {
            case low = 0.75
            case normal = 1.0
            case high = 1.5
        }

        var springPower: Double? {
            switch self {
            case let .spring(level):
                return level.rawValue
            default:
                return nil
            }
        }
    }
}
