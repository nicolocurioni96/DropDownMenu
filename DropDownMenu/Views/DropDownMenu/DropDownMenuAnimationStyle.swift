//
//  DropDownMenuAnimationStyle.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import Foundation

/// Type describing the Animation Styles used to create the animation of Expanding and Collapsing `DropDownMenu`
public enum AnimationStyle {
    /// `DropDownMenu` animation should be linear (Smooth Animation)
    case linear
    
    /// `DropDownMenu` animnation should be spring (Bouncy Animation)
    case spring(level: SpringPowerLevel)
    
    /// Defines how bouncy the animation should be
    ///
    /// - low:         Bit of smotth and a bit of bounciness at the end
    /// - normal:   Not too bouncy and not too smoothy
    /// - high:       Too bouncy
    public enum SpringPowerLevel: Double {
        case low = 0.75
        case normal = 1.0
        case high = 1.5
    }
}
