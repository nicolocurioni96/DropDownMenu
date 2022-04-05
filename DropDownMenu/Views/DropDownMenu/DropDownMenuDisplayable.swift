//
//  DropDownMenuDisplayable.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import Foundation

/// `DropDownMenuDisplayable` is the markable interface to allow custom types to be used with DropDownMenu
public protocol DropDownMenuDisplayable {
    /// The value that will be displayed in the menu item
    var displayableValue: String { get }
    
    /// The value that will be returned when select menu item
    var retrievableValue: Any { get }
}
