//
//  DropDownMenuAttributes+AnimationTiming.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import Foundation

public extension DropDownMenuAttributes {

    /** Describes how long the menu animates */
    enum AnimationTiming {

        case `default`

        case value(duration: Double, delay: Double)

        var animationTimingValues: (duration: Double, delay: Double) {
            switch self {
            case let .value(duration, delay):
                return (duration: duration, delay: delay)
            case .default:
                return (duration: 0.5, delay: 0.0)
            }
        }
    }
}
