//
//  DropDownMenuAttributes.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import UIKit

public struct DropDownMenuAttributes {

    /**
     A settable **optional** name that matches the menu-attributes.
     */
    public var name: String?

    /**
     Describes the scrolling behaviour of the menu.
     */
    public var scroll = Scroll.enabled

    /**
     Describes the accessory behaviour of the menu.
     */
    public var accessory = Accessory.enabled

    /**
     Describes the selection behaviour of the menu.
     */
    public var multiSelect = MultiSelection.enabled

    /**
     Describes the after selection behaviour of the menu.
     */
    public var hideOptionsWhenSelect = HideMenuWhenSelection.enabled

    /**
     Describes the style for row of the menu.
     */
    public var rowStyle = RowStyle.default

    /**
     Describes the style for header of the menu.
     */
    public var headerStyle = HeaderStyle.value(backgroundColor: .clear, height: 40)

    /**
     Describes the style for arrow of the menu.
     */
    public var arrowStyle = ArrowStyle.default

    /**
     Describes the style for separator of the menu.
     */
    public var separatorStyle = SeparatorStyle.default

    /**
     Describes the style for text of the menu.
     */
    public var textStyle = TextStyle.default

    /**
     Describes the style for row of the menu.
     */
    public var placeHolderStyle = PlaceHolderStyle.value(text: "", textColor: .black)

    /** The corner attributes */
    public var roundCorners = RoundCorners.none

    /** The border around the menue */
    public var border = Border.none

    /** The height of the menue */
    public var height = ListHeight.default

    /** Describes how the menu animates while expanding */
    public var expandingAnimation = Animation.linear

    /** Describes how the menu animates while collapsing */
    public var collapsingAnimation = Animation.linear

    /** Describes how long the menu animates while expanding */
    public var expandingTiming = AnimationTiming.default

    /** Describes how long the menu animates while collapsing */
    public var collapsingTiming = AnimationTiming.default

    /** Init with default attributes */
    public init() { }
}
