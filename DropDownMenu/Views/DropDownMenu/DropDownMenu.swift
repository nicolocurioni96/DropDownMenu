//
//  DropDownMenu.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import Foundation
import UIKit

final public class DropDownMenu: UIView {
    
    public var heighConstraint: NSLayoutConstraint!
    
    // MARK: - Public Properties
    
    /// `selectedIndex` is a property to get and set selectedItem in `DropDownMenu` when it is a Single Selection
    
    public var selectedIndex: Int? {
        didSet {
            if selectedIndex == nil {
//                setPlaceholder()
            } else {
//                setSingleSelectedOption()
            }
        }
    }
    
    
}
