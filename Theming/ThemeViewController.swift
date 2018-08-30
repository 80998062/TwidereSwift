//
//  ThemeViewController.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/20.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import SwiftTheme
import ReSwift
import ReSwiftRouter

class ThemeViewController: UITableViewController {
    
    private let themes: [AppTheme] = [AppTheme.Classic,AppTheme.PinkPower]
    private lazy var colors: [[UIColor]] = themes.compactMap{ it -> [UIColor] in
        return it.colors()
    }
    
    private lazy var defaultTheme: AppTheme? = {
        guard let dict = ThemeManager.currentTheme else{
            return nil
        }
        guard let currentThemeName = dict["Name"] as? String else{
            fatalError("Key name in Theme don't have a valid name")
        }
        return AppTheme(rawValue: currentThemeName)
    }()
    
    
    private var selected: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for (i , v) in themes.enumerated(){
            if v == defaultTheme{
                selected = i
                break
            }
        }
        clearsSelectionOnViewWillAppear = false
        tableView.allowsSelection = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.estimatedRowHeight = 56
        tableView.rowHeight = UITableViewAutomaticDimension
        register(tableView, cell: ThemeCell.self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeue(tableView, cell: ThemeCell.self, indexPath: indexPath)
        let data = self.themes[indexPath.row]
        cell.bind(data, colors[indexPath.row], indexPath.row == self.selected)
        cell.checkboxListener = { checkbox in
            self.tryToSwitchTheme(from: data, to: self.themes[indexPath.row])
        }
        return cell
    }
    
    private func tryToSwitchTheme(from oldTheme: AppTheme, to newTheme: AppTheme) -> Void{
        SwiftyPlistManager.shared.save(newTheme.rawValue, forKey: "ThemeName", toPlistWithName: "Prefs") { (err) in
            if err == nil {
                ThemeManager.setTheme(plistName: newTheme.rawValue, path: .mainBundle)
                self.selected = themes.index(of: newTheme)
            }else{
                self.selected = themes.index(of: oldTheme)
            }
            self.tableView.reloadData()
        }
    }
}

extension ThemeViewController: Routable{
    
}
