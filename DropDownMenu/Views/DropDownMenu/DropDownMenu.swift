//
//  DropDownMenu.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import Foundation
import UIKit


protocol DropDownMenuDelegate {
    func dropDownMenuPressed(string : String)
}

class DropDownMenu: UIButton {
    
    var dropDownMenuView = DropDownMenuView()
        
    var height = NSLayoutConstraint()
    
    var isOpen = false

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        self.superview?.addSubview(dropDownMenuView)
        self.superview?.bringSubviewToFront(dropDownMenuView)
        dropDownMenuView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dropDownMenuView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dropDownMenuView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        height = dropDownMenuView.heightAnchor.constraint(equalToConstant: 0)
        self.clipsToBounds = true
    }
    
    
    // MARK: - Methods
    
    // Private
    
    private func setupUI() {
        
        dropDownMenuView = DropDownMenuView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        dropDownMenuView.delegate = self
        dropDownMenuView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false {
            
            isOpen = true
            
            NSLayoutConstraint.deactivate([self.height])
            
            if self.dropDownMenuView.tableView.contentSize.height > 150 {
                self.height.constant = 150
            } else {
                self.height.constant = self.dropDownMenuView.tableView.contentSize.height
            }
            
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropDownMenuView.layoutIfNeeded()
                self.dropDownMenuView.center.y += self.dropDownMenuView.frame.height / 2
            }, completion: nil)
        } else {
            isOpen = false
            
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropDownMenuView.center.y -= self.dropDownMenuView.frame.height / 2
                self.dropDownMenuView.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    func dismissDropDownMenu() {
        isOpen = false
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropDownMenuView.center.y -= self.dropDownMenuView.frame.height / 2
            self.dropDownMenuView.layoutIfNeeded()
        }, completion: nil)
    }
}

extension DropDownMenu: DropDownMenuDelegate {
    func dropDownMenuPressed(string: String) {
        self.setTitle(string, for: .normal)
        self.dismissDropDownMenu()
    }
}
