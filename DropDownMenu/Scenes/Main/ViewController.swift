//
//  ViewController.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import UIKit

class ViewController: UIViewController {

    var buttonOption: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Methods
    
    // Private
    private func setupUI() {
        title = "DropDownMenu"
        view.backgroundColor = UIColor(named: "MainBG")
        
        buttonOption.backgroundColor = UIColor(named: "NormalButton")
        buttonOption.semanticContentAttribute = .forceLeftToRight
        buttonOption.setTitle("Select option", for: .normal)
        buttonOption.clipsToBounds = true
        buttonOption.layer.cornerRadius = 8
        buttonOption.setTitleColor(.black, for: .normal)
        buttonOption.layer.shadowColor = UIColor.black.cgColor
        buttonOption.layer.shadowOffset = CGSize(width: -4, height: 3)
        buttonOption.layer.shadowOpacity = 0.6
        buttonOption.addTarget(self, action: #selector(didTapOnSelectOption(_:)), for: .touchUpInside)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        [buttonOption].forEach(view.addSubview(_:))
        
        NSLayoutConstraint.activate([
            buttonOption.heightAnchor.constraint(equalToConstant: 52),
            buttonOption.widthAnchor.constraint(equalToConstant: 200),
            buttonOption.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonOption.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc
    private func didTapOnSelectOption(_ sender: Any) { }
}

