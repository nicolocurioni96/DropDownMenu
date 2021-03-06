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
    
    private let tapGesture = UITapGestureRecognizer()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        isMenuOpen()
    }
    
    // MARK: - Methods
    
    // Private
    private func setupUI() {
        title = "DropDownMenu"
        view.backgroundColor = UIColor(named: "MainWhiteBG")
        
        dropDownMenu.imageView?.frame.size = CGSize(width: 30, height: 30)
        dropDownMenu.imageView?.contentMode = .scaleAspectFit
        dropDownMenu.setTitleColor(.black, for: .normal)
        dropDownMenu.titleLabel?.adjustsFontSizeToFitWidth = true
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
        dropDownMenu.widthAnchor.constraint(equalToConstant: 180).isActive = true
        dropDownMenu.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func isMenuOpen() {
        if !dropDownMenu.isOpen {
            dropDownMenu.roundCorners(corners: [.allCorners], radius: 5)
            dropDownMenu.backgroundColor = .clear
            dropDownMenu.layer.shadowColor = UIColor.clear.cgColor
            dropDownMenu.setImage(UIImage(named: "ArrowDown"), for: .normal)
        } else {
            dropDownMenu.setImage(UIImage(named: "ArrowUp"), for: .normal)
            dropDownMenu.backgroundColor = .white
            dropDownMenu.roundCorners(corners: [.topLeft, .topRight], radius: 5)
            dropDownMenu.dropDownMenuView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 5)
            dropDownMenu.layer.shadowColor = UIColor.black.cgColor
            dropDownMenu.layer.shadowRadius = 3.0
            dropDownMenu.layer.shadowOpacity = 1.0
            dropDownMenu.layer.shadowOffset = CGSize(width: 4, height: 4)
            dropDownMenu.layer.masksToBounds = false
            dropDownMenu.dropDownMenuView.clipsToBounds = true
            dropDownMenu.dropDownMenuView.layer.masksToBounds = false
            dropDownMenu.dropDownMenuView.layer.shadowColor = UIColor.lightGray.cgColor
            dropDownMenu.dropDownMenuView.layer.shadowOffset = CGSize(width: 0, height: 10)
            dropDownMenu.dropDownMenuView.layer.shadowOpacity = 0.6
        }
    }
}
