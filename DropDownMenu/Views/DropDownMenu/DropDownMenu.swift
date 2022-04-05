//
//  DropDownMenu.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import Foundation
import UIKit

final public class DropDownMenu: UIView {
    
    var heightConstraint: NSLayoutConstraint!
    
    // MARK: - Public Properties
    
    /// `selectedIndex` is a property to get and set selectedItem in `DropDownMenu` when it is a Single Selection
    
    public var selectedIndex: Int? {
        didSet {
            if selectedIndex == nil {
                setPlaceholder()
            } else {
                setSingleSelectedOption()
            }
        }
    }
    
    /// `selectedIndecis` is a property to get and set selected item in `DropDownMenu` when it is a Multi Selection.
    public var selectedIndecis: [Int: Int] = [:] {
        didSet {
            setMultiSelectedOptions()
        }
    }
    
    /// `items` is the `DropDownMenu` DataSource.
    ///
    /// The items that will appear in the `DropDownMenu`.
    public var items = [DropDownMenuDisplayable]() {
        didSet {
            self.itemsTableView.reloadData()
        }
    }
    
    /// `delegate` is the `DropDownMenu` delegate property.
    public weak var delegate: DropDownMenuDelegate?

    /// `separatorCharacters` is a property to get and set separator characters  in `DropDownMenu` when it is a Multi Selection.
    public var separatorCharacters: String?
    
    // MARK: - Public Callbacks
    
    /// `willExpand` is a completion closure that will be executed when `DropDownMenu` is going to expand.
    public var willExpand: (() -> Void) = { }
    
    /// `didExpand` is a completion closure that will be executed once `DropDownMenu` expanded.
    public var didExpand: (() -> Void) = { }
    
    /// `willCollapse` is a completion closure that will be executed when `DropDownMenu` is going to collapse.
    public var willCollapse: (() -> Void) = { }
    
    /// `didCollapse` is a completion closure that will be executed once `DropDownMenu` collapsed.
    public var didCollapse: (() -> Void) = { }
    
    /// `didSelectItem` is a completion closure that will be executed when select an item from `DropDownMenu`.
    /// - Parameters:
    ///   - menu: The `DropDownMenu` that was selected from it's items.
    ///   - item: The `Item` that had been selected from `DropDownMenu`.
    ///   - index: The `Index` of the selected `Item`.
    public var didSelectItem: ((_ menu: DropDownMenu,_ item: DropDownMenuDisplayable,_ index: Int) -> Void) = { _, _, _ in }

    // MARK: - Private Properties
    
    private var selectButton: UIButton!
    private var itemsTableView: UITableView!
    private var state: DropDownMenuState = .hidden
    private var width: CGFloat!
    private var height: CGFloat!
    private var setuped: Bool = false
    private var attributes: DropDownMenuAttributes!
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        selectButton = UIButton(frame: self.frame)
        itemsTableView = UITableView()
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        selectButton = UIButton(frame: self.frame)
        itemsTableView = UITableView()
    }
    
    // MARK: - LifeCycle
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if !setuped {
            setupUI()
            setupArrowImage()
            setuped = true
        }
    }
    
    // MARK: - Public Funcitons

    /// Configure `DropDownMenu` with attributes.
    public func configure(with attributes: DropDownMenuAttributes) {
        self.attributes = attributes
    }
    
    /// Expand or Collapse `DropDownMenu` from Code.
    public func toggle() {
        handleMenuState()
    }
}

// MARK: - UITableViewDataSource Functions

extension DropDownMenu: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].displayableValue
        cell.textLabel?.textColor = attributes.textStyle.textStyleValues.color
        cell.textLabel?.font = attributes.textStyle.textStyleValues.font
        cell.tintColor = attributes.textStyle.textStyleValues.color
        cell.backgroundColor = attributes.rowStyle.rowStyleValues.backgroundColor
        cell.selectionStyle = .none

        if attributes.multiSelect.isEnabled {
            if selectedIndecis[indexPath.row] != nil {
                cell.accessoryType = attributes.accessory.isEnabled ? .checkmark : .none
                cell.backgroundColor = attributes.rowStyle.rowStyleValues.selectedColor
            } else {
                cell.accessoryType = .none
            }
        } else {
            if indexPath.row == selectedIndex {
                cell.accessoryType = attributes.accessory.isEnabled ? .checkmark : .none
                cell.backgroundColor = attributes.rowStyle.rowStyleValues.selectedColor
            } else {
                cell.accessoryType = .none
            }
        }

        return cell
    }
}

// MARK: - UITableViewDelegate Functions

extension DropDownMenu: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(attributes.rowStyle.rowStyleValues.height)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if attributes.multiSelect.isEnabled {
            if selectedIndecis[indexPath.row] != nil {
                selectedIndecis[indexPath.row] = nil
                setSelectedOptionsAsTitle()
                tableView.reloadData()
                if attributes.hideOptionsWhenSelect.isEnabled {
                    handleMenuState()
                }
            } else {
                selectedIndecis[indexPath.row] = indexPath.row
                setSelectedOptionsAsTitle()
                let selectedText = self.items[selectedIndecis[indexPath.row]!]
                delegate?.menu(self, didSelectItem: selectedText, atIndex: indexPath.row)
                self.didSelectItem(self, selectedText, indexPath.row)
                tableView.reloadData()
                if attributes.hideOptionsWhenSelect.isEnabled {
                    handleMenuState()
                }
            }
        } else {
            if selectedIndex == indexPath.row {
                if attributes.hideOptionsWhenSelect.isEnabled {
                    handleMenuState()
                }
            } else {
                selectedIndex = indexPath.row
                setSelectedOptionsAsTitle()
                let selectedText = self.items[self.selectedIndex!]
                delegate?.menu(self, didSelectItem: selectedText, atIndex: indexPath.row)
                self.didSelectItem(self, selectedText, indexPath.row)
                tableView.reloadData()
                if attributes.hideOptionsWhenSelect.isEnabled {
                    handleMenuState()
                }
            }
        }
    }
}

// MARK: - Setup SwiftyMenu Views Functions

extension DropDownMenu {
    private func setupUI () {
        setupView()
        getViewWidth()
        getViewHeight()
        setupSelectButton()
        setupDataTableView()
        setupSeparatorStyle()
    }

    public func setupSeparatorStyle() {
        itemsTableView.separatorStyle = attributes.separatorStyle.separatorStyleValues.style
        if attributes.separatorStyle.separatorStyleValues.isBlured {
            itemsTableView.separatorEffect = UIBlurEffect()
        }
        itemsTableView.separatorColor = attributes.separatorStyle.separatorStyleValues.color
    }
    
    private func setupArrowImage() {
        let spacing = self.selectButton.frame.width - 20 // the amount of spacing to appear between image and title
        var imageEdgeInsets = UIEdgeInsets(top: 0, left: CGFloat(spacing), bottom: 0, right: 0)
        if UIView.userInterfaceLayoutDirection(for: selectButton.semanticContentAttribute) == .rightToLeft {
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: CGFloat(spacing))
        }
        selectButton.imageEdgeInsets = imageEdgeInsets
    }
    
    private func setupView() {
        clipsToBounds = true
        layer.cornerRadius = attributes.roundCorners.cornerValue ?? 0
        layer.borderWidth = attributes.border.borderValues?.width ?? 0
        layer.borderColor = attributes.border.borderValues?.color.cgColor
    }
    
    private func setupSelectButton() {
        self.addSubview(selectButton)
        
//        selectButton.snp.makeConstraints { maker in
//            maker.leading.trailing.top.equalTo(self)
//            maker.height.equalTo(height)
//        }
        
        NSLayoutConstraint.activate([
            selectButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            selectButton.topAnchor.constraint(equalTo: self.topAnchor),
            selectButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            selectButton.heightAnchor.constraint(equalToConstant: height),
        ])

        let color = attributes.placeHolderStyle.placeHolderValues.textColor
        selectButton.setTitleColor(color, for: .normal)
        UIView.performWithoutAnimation {
            selectButton.setTitle(attributes.placeHolderStyle.placeHolderValues.text, for: .normal)
            selectButton.layoutIfNeeded()
        }
        selectButton.titleLabel?.font = attributes.textStyle.textStyleValues.font

        selectButton.imageEdgeInsets.right = width - 16
        selectButton.imageEdgeInsets.left = width - 16
        
        if UIView.userInterfaceLayoutDirection(for: selectButton.semanticContentAttribute) == .rightToLeft {
            selectButton.titleEdgeInsets.right = 16
            selectButton.titleEdgeInsets.left = attributes.arrowStyle.arrowStyleValues.isEnabled ? 32 : 16
            selectButton.titleLabel?.lineBreakMode = .byTruncatingHead
        } else {
            selectButton.titleEdgeInsets.right = attributes.arrowStyle.arrowStyleValues.isEnabled ? 32 : 16
            selectButton.titleEdgeInsets.left = 16
            selectButton.titleLabel?.lineBreakMode = .byTruncatingTail
        }

        selectButton.backgroundColor = attributes.headerStyle.headerStyleValues.backgroundColor

        let arrow = attributes.arrowStyle.arrowStyleValues.image

        if attributes.arrowStyle.arrowStyleValues.isEnabled {
            if UIView.userInterfaceLayoutDirection(for: selectButton.semanticContentAttribute) == .rightToLeft {
                selectButton.titleEdgeInsets.right = 4
            } else {
                selectButton.titleEdgeInsets.left = 4
            }
            selectButton.setImage(arrow, for: .normal)
        }
        
        if #available(iOS 11.0, *) {
            selectButton.contentHorizontalAlignment = .leading
        } else {
            selectButton.contentHorizontalAlignment = .left
        }
        
        selectButton.addTarget(self, action: #selector(handleMenuState), for: .touchUpInside)
    }
    
    private func setupDataTableView() {
        self.addSubview(itemsTableView)
        
//        itemsTableView.snp.makeConstraints { maker in
//            maker.leading.trailing.bottom.equalTo(self)
//            maker.top.equalTo(selectButton.snp.bottom)
//        }
        
        NSLayoutConstraint.activate([
            itemsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            itemsTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            itemsTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            itemsTableView.topAnchor.constraint(equalTo: selectButton.bottomAnchor),
        ])
        
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        itemsTableView.rowHeight = CGFloat(attributes.rowStyle.rowStyleValues.height)
        itemsTableView.separatorInset.left = 8
        itemsTableView.separatorInset.right = 8
        itemsTableView.backgroundColor = attributes.rowStyle.rowStyleValues.backgroundColor
        itemsTableView.isScrollEnabled = attributes.scroll.isEnabled
        itemsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "OptionCell")
        itemsTableView.showsVerticalScrollIndicator = false
    }
    
    @objc private func handleMenuState() {
        switch self.state {
        case .shown:
            collapseDropDownMenu()
        case .hidden:
            expandDropDownMenu()
        }
        state.toggle()
    }
}

// MARK: - Private Functions

extension DropDownMenu {
    private func getViewWidth() {
        width = self.frame.width
    }
    
    private func getViewHeight() {
        height = self.frame.height
    }
    
    private func setMultiSelectedOptions() {
        let titles = selectedIndecis.mapValues { (index) -> String in
            return items[index].displayableValue
        }
        var selectedTitle = ""
        selectedTitle = titles.values.joined(separator: separatorCharacters ?? ", ")
        UIView.performWithoutAnimation {
            selectButton.setTitle(selectedTitle, for: .normal)
            selectButton.layoutIfNeeded()
        }
        selectButton.setTitleColor(attributes.textStyle.textStyleValues.color, for: .normal)
    }
    
    private func setSingleSelectedOption() {
        UIView.performWithoutAnimation {
            selectButton.setTitle(items[selectedIndex!].displayableValue, for: .normal)
            selectButton.layoutIfNeeded()
        }
        selectButton.setTitleColor(attributes.textStyle.textStyleValues.color, for: .normal)
    }
    
    private func setPlaceholder() {
        UIView.performWithoutAnimation {
            selectButton.setTitle(attributes.placeHolderStyle.placeHolderValues.text, for: .normal)
            selectButton.layoutIfNeeded()
        }
        selectButton.setTitleColor(attributes.placeHolderStyle.placeHolderValues.textColor, for: .normal)
    }
    
    private func setSelectedOptionsAsTitle() {
        if attributes.multiSelect.isEnabled {
            if selectedIndecis.isEmpty {
                setPlaceholder()
            } else {
                setMultiSelectedOptions()
            }
        } else {
            if selectedIndex == nil {
                setPlaceholder()
            } else {
                setSingleSelectedOption()
            }
        }
    }
}

// MARK: - SwiftyMenu Expand and Collapse Functions

extension DropDownMenu {
    /// Called to Expand `SwiftyMenu`.
    private func expandDropDownMenu() {
        delegate?.menu(willExpand: self)
        self.willExpand()
        heightConstraint.constant = attributes.height.listHeightValue == 0 || !attributes.scroll.isEnabled || (CGFloat(Double(attributes.rowStyle.rowStyleValues.height) * Double(items.count + 1)) < CGFloat(attributes.height.listHeightValue)) ? CGFloat(Double(attributes.rowStyle.rowStyleValues.height) * Double(items.count + 1)) : CGFloat(attributes.height.listHeightValue)

        switch attributes.expandingAnimation {
        case .linear:
            UIView.animate(withDuration: attributes.expandingTiming.animationTimingValues.duration,
                           delay: attributes.expandingTiming.animationTimingValues.delay,
                           animations: animationBlock,
                           completion: expandingAnimationCompletionBlock)
            
        case .spring(level: let powerLevel):
            let damping = CGFloat(0.5 / powerLevel.rawValue)
            let initialVelocity = CGFloat(0.5 * powerLevel.rawValue)
            
            UIView.animate(withDuration: attributes.expandingTiming.animationTimingValues.duration,
                           delay: attributes.expandingTiming.animationTimingValues.delay,
                           usingSpringWithDamping: damping,
                           initialSpringVelocity: initialVelocity,
                           options: [],
                           animations: animationBlock,
                           completion: expandingAnimationCompletionBlock)
        }
    }
    
    /// Called to Collapse `SwiftyMenu`.
    private func collapseDropDownMenu() {
        delegate?.menu(willCollapse: self)
        self.willCollapse()
        heightConstraint.constant = CGFloat(attributes.headerStyle.headerStyleValues.height)
        
        switch attributes.collapsingAnimation {
        case .linear:
            UIView.animate(withDuration: attributes.collapsingTiming.animationTimingValues.duration,
                           delay: attributes.collapsingTiming.animationTimingValues.delay,
                           animations: animationBlock,
                           completion: collapsingAnimationCompletionBlock)
            
        case .spring(level: let powerLevel):
            let damping = CGFloat(1.0 * powerLevel.rawValue)
            let initialVelocity = CGFloat(10.0 * powerLevel.rawValue)
            
            UIView.animate(withDuration: attributes.collapsingTiming.animationTimingValues.duration,
                           delay: attributes.collapsingTiming.animationTimingValues.delay,
                           usingSpringWithDamping: damping,
                           initialSpringVelocity: initialVelocity,
                           options: .curveEaseIn,
                           animations: animationBlock,
                           completion: collapsingAnimationCompletionBlock)
        }
    }
}

// MARK: - DropDownMenu Animation Functions

extension DropDownMenu {
    private func animationBlock() {
        if attributes.arrowStyle.arrowStyleValues.isEnabled {
            self.selectButton.imageView?.transform = self.selectButton.imageView!.transform.rotated(by: CGFloat.pi)
        }
        self.parentViewController?.view.layoutIfNeeded()
    }
    
    private func expandingAnimationCompletionBlock(didAppeared: Bool) {
        if didAppeared {
            self.delegate?.menu(didExpand: self)
            self.didExpand()
        }
    }
    
    private func collapsingAnimationCompletionBlock(didAppeared: Bool) {
        if didAppeared {
            self.delegate?.menu(didCollapse: self)
            self.didCollapse()
        }
    }
}
