//
//  ThemeViewController.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/20.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit

class ThemeViewController: UITableViewController, OptionViewProtocol {
    var type: Type!
    private let themes: [AppTheme] = [AppTheme.Classic,AppTheme.Dark,AppTheme.LadiesNight,AppTheme.PinkPower,AppTheme.YourName]
    
    private var selected: AppTheme = AppTheme.Classic
    private var cellSelected: IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        clearsSelectionOnViewWillAppear = false
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.estimatedRowHeight = 56
        tableView.rowHeight = UITableViewAutomaticDimension
        
        register(tableView, cell: ThemeCell.self)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeue(tableView, cell: ThemeCell.self, indexPath: indexPath)
        let it = themes[indexPath.row]
        let isSelected = it == selected
        if isSelected{
            cellSelected = indexPath
        }
        cell.bind(it, getThemeColors(theme: it),selected: isSelected)
        cell.checkboxListener = { checkbox in
            print("\(indexPath.row) + \(checkbox.isChecked)")
            if let last = self.cellSelected{
                let oldCell = tableView.cellForRow(at: last) as! ThemeCell
                oldCell.checkbox.setChecked(false, animated: true)
                oldCell.checkbox.isEnabled = true
            }
            self.cellSelected = indexPath
            self.selected = it
        }
        return cell
    }
}
