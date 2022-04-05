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
            dropDownMenu.roundCorners(corners: [.allCorners], radius: 5)
            dropDownMenu.backgroundColor = .clear
            dropDownMenu.layer.shadowColor = UIColor.clear.cgColor
        } else {
            dropDownMenu.roundCorners(corners: [.topLeft, .topRight], radius: 5)
            dropDownMenu.dropDownMenuView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 5)
            dropDownMenu.backgroundColor = .white
            dropDownMenu.layer.shadowColor = UIColor.lightGray.cgColor
            dropDownMenu.layer.shadowOffset = CGSize(width: 0, height: 8)
            dropDownMenu.layer.shadowRadius = 50
            dropDownMenu.layer.shadowOpacity = 0.8
            dropDownMenu.layer.shadowPath = UIBezierPath(rect: dropDownMenu.layer.bounds).cgPath
            dropDownMenu.dropDownMenuView.clipsToBounds = true
            dropDownMenu.dropDownMenuView.layer.masksToBounds = true
            dropDownMenu.dropDownMenuView.layer.shadowColor = UIColor.red.cgColor
            dropDownMenu.dropDownMenuView.layer.shadowOffset = CGSize(width: 0, height: 10)
            dropDownMenu.dropDownMenuView.layer.shadowOpacity = 0.6
        }
    }
    
    // MARK: - Methods
    
    // Private
    private func setupUI() {
        title = "DropDownMenu"
        view.backgroundColor = UIColor(named: "MainWhiteBG")
        
        let shadowLayer = CALayer.init()
        
        shadowLayer.masksToBounds = true
        shadowLayer.frame = dropDownMenu.bounds
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOpacity = 0.08
        shadowLayer.shadowRadius = 20
        shadowLayer.shadowPath = CGPath.init(rect: shadowLayer.bounds, transform: nil)
        
        dropDownMenu.layer.insertSublayer(shadowLayer, below: dropDownMenu.layer)
        
        dropDownMenu.setTitleColor(.black, for: .normal)
        dropDownMenu.dropDownMenuView.dropDownMenuOptions = ["Option 1", "Option 2", "Option 3"]
        
        if dropDownMenu.dropDownMenuView.dropDownMenuOptions.count != 0 {
            guard let itemTitle = dropDownMenu.dropDownMenuView.dropDownMenuOptions.first else { return }
            
            dropDownMenu.setTitle(itemTitle, for: .normal)
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        [dropDownMenu].forEach(view.addSubview(_:))
        
        dropDownMenu.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        dropDownMenu.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        dropDownMenu.widthAnchor.constraint(equalToConstant: 160).isActive = true
        dropDownMenu.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
