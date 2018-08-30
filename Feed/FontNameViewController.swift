//
//  FontNameViewController.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/27.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import YFIconFont
import SwiftTheme
import ReSwiftRouter



fileprivate class FontNameCell: UITableViewCell{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .default
        selectedBackgroundView = UIView(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(forFontName name: String, isSelected checked: Bool){
        textLabel?.text = name
        accessoryType = checked ? .checkmark : .none
        textLabel?.updateScaledFont(forFontName: name, forFontStyle: .body)
    }
}

class FontNameViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavgationBar()
        
        guard let fontName = SwiftyPlistManager.shared.fetchValue(for: "FontName", fromPlistWithName: "Prefs") else {
            return
        }
        
        self.selectedFontName = fontName as? String
        self.fontNames = ["System","Noteworthy"]
        
        clearsSelectionOnViewWillAppear = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        register(tableView, cell: FontNameCell.self)
    }
    
    fileprivate var fontNames = [String]()
    
    fileprivate  var selectedFontName: String? = nil
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontNames.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeue(tableView, cell: FontNameCell.self, indexPath: indexPath)
        let fontName = fontNames[indexPath.row]
        let selected = fontName == selectedFontName
        cell.bind(forFontName: fontName, isSelected: selected)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if fontNames[indexPath.row] != selectedFontName{
            selectedFontName = fontNames[indexPath.row]
            tableView.reloadData()
        }
    }
}

extension FontNameViewController{
    fileprivate func setupNavgationBar() -> Void{
        let done = UIBarButtonItem(barButtonSystemItem: .done,target: self, action: #selector(FontNameViewController.onDone))
        self.navigationItem.leftBarButtonItem = done
        self.navigationItem.title = "FontName"
    }
    
    @objc dynamic func onDone(){
        let newRoute = [InAppRoute.Settings.identifier()]
        appStore.dispatch(ReSwiftRouter.SetRouteAction(newRoute))
    }
    
}

extension FontNameViewController: Routable{
    
}



