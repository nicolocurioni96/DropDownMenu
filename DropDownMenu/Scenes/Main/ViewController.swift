//
//  ViewController.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import UIKit

class ViewController: UIViewController {

    var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    var dropDownMenu: DropDownMenu = {
        let menu = DropDownMenu()
        menu.translatesAutoresizingMaskIntoConstraints = false
        return menu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !dropDownMenu.isOpen {
            dropDownMenu.roundCorners(corners: [.allCorners], radius: 10)
            dropDownMenu.backgroundColor = .clear
        } else {
            dropDownMenu.roundCorners(corners: [.topLeft, .topRight], radius: 10)
            dropDownMenu.dropDownMenuView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
            dropDownMenu.backgroundColor = .darkGray
        }
        
    }
    
    // MARK: - Methods
    
    // Private
    private func setupUI() {
        title = "DropDownMenu"
        view.backgroundColor = UIColor(named: "MainBG")
        
        dropDownMenu.dropDownMenuView.clipsToBounds = true
        dropDownMenu.dropDownMenuView.layer.masksToBounds = true
        dropDownMenu.dropDownMenuView.layer.shadowColor = UIColor.black.cgColor
        dropDownMenu.dropDownMenuView.layer.shadowOffset = CGSize(width: 2, height: 2)
        dropDownMenu.dropDownMenuView.layer.shadowOpacity = 0.6
        
        dropDownMenu.layer.masksToBounds = true
        dropDownMenu.layer.shadowColor = UIColor.black.cgColor
        dropDownMenu.layer.shadowOffset = CGSize(width: 2, height: 2)
        dropDownMenu.layer.shadowOpacity = 0.6
        dropDownMenu.setTitle("Select Item", for: .normal)
        dropDownMenu.dropDownMenuView.dropDownMenuOptions = ["Option 1", "Option 2", "Option 3"]
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        [dropDownMenu].forEach(view.addSubview(_:))
        
        dropDownMenu.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        dropDownMenu.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        dropDownMenu.widthAnchor.constraint(equalToConstant: 140).isActive = true
        dropDownMenu.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
