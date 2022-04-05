//
//  DropDownMenuView.swift
//  DropDownMenu
//
//  Created by Nicolò Curioni on 05/04/22.
//

import Foundation
import UIKit

class DropDownMenuView: UIView {
    var dropDownMenuOptions = [String]()
    
    var tableView = UITableView()
    
    var delegate : DropDownMenuDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    // Private
    
    private func setupUI() {
        self.backgroundColor = UIColor.white
        self.tableView.clipsToBounds = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

extension DropDownMenuView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownMenuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let item = dropDownMenuOptions[indexPath.row]
        
        cell.textLabel?.text = item
        cell.textLabel?.textColor = .black
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.dropDownMenuPressed(string: dropDownMenuOptions[indexPath.row])
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
