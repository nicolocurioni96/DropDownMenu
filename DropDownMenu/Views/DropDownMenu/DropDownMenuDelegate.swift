//
//  DropDownMenuDelegate.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import Foundation

/// `DropDownMenuDelegate` is the delegate interface to delegate different actions of DropDownMenu
public protocol DropDownMenuDelegate: AnyObject {
    /// Called when select an item from `DropDownMenu`.
    ///
    /// - Parameters:
    /// - menu: The `DropDownMenu` that was selected from it's items.
    /// - item:      The `Item` that had been selected from `DropDownMenu`.
    /// - index:    The `Index` of the selected `Item`.
    func menu(_ menu: DropDownMenu, didSelectItem irtem: DropDownMenuDisplayable, atIndex index: Int)
    
    /// Called when `DropDownMenu` will going to expand.
    ///
    /// - Parameter menu: The `DropDownMenu` that Expanded.
    func menu(willExpand menu: DropDownMenu)
    
    /// Called when `DropDownMenu` will going to expand.
    ///
    /// - Parameter menu: The `DropDownMenu` that Expanded.
    func menu(didExpand menu: DropDownMenu)
    
    /// Called when `DropDownMenu` will going to Collapse.
    ///
    /// - Parameter menu: The `DropDownMenu` that is going to Collapse.
    func menu(willCollapse menu: DropDownMenu)
    
    /// Called when `DropDownMenu` Collapsed.
    ///
    /// - Parameter menu: The `DropDownMenu` that Collapsed.
    func menu(didCollapse menu: DropDownMenu)
}

/// `DropDownMenuDelegate` Default implementation to workaround Optionally.
public extension DropDownMenuDelegate {
    func menu(willExpand menu: DropDownMenu)    { }
    func menu(didExpand menu: DropDownMenu)     { }
    func menu(willCollapse menu: DropDownMenu)  { }
    func menu(didCollapse menu: DropDownMenu)   { }
}
