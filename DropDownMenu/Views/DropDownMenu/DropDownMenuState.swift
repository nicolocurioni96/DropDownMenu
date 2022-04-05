//
//  DropDownMenuState.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import Foundation

/// Type describing the current state of `DropDownMenu`.
public enum DropDownMenuState {
    /// `DropDownMenu` is expanded.
    case shown
    
    /// `DropDownMenu` is collapsed.
    case hidden
    
    /// Change the current state of DropDownMenu.
    mutating func toggle() {
        switch self {
        case .shown:
            self = .hidden
        case .hidden:
            self = .shown
        }
    }
}
