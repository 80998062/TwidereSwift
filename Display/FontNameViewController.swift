//
//  FontNameViewController.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/27.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import SwiftTheme
import ReSwift
import ReSwiftRouter
import CC



fileprivate class FontNameCell: UITableViewCell{

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
    }
}

class FontNameViewController: UITableViewController {
    
    fileprivate var sourceFontName:String?
    fileprivate var selectedFontName: String? = nil
    fileprivate var selectedIndexPath: IndexPath? = nil
    fileprivate let fontNames = ["System", "Noteworthy", "Pink"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavgationBar()
        clearsSelectionOnViewWillAppear = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        register(tableView, cell: FontNameCell.self)
        
        selectedFontName = currentFontName()
        sourceFontName = selectedFontName
        if selectedFontName != nil, let index = fontNames.firstIndex(of: selectedFontName!){
            selectedIndexPath = IndexPath.init(row: index, section: 0)
        }
    }
    
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
        var willUpdate = [indexPath]
        if selectedIndexPath != nil{
            willUpdate.append(selectedIndexPath!)
        }
        selectedIndexPath = indexPath
        selectedFontName = fontNames[indexPath.row]
        tableView.reloadRows(at: willUpdate, with: .automatic)
    }
}

extension FontNameViewController{
    fileprivate func setupNavgationBar() -> Void{
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        let done = UIBarButtonItem(barButtonSystemItem: .done,target: self, action: #selector(FontNameViewController.onDone))
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel,target: self, action: #selector(FontNameViewController.onCancel))
        
        navigationItem.leftBarButtonItem = cancel
        navigationItem.rightBarButtonItem = done
        navigationItem.title = "FontName".localized()
    }
    
    @objc dynamic func onCancel(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc dynamic func onDone(){
        // send notification:
//        if selectedFontName != nil && selectedFontName != sourceFontName{
//            SwiftyPlistManager.shared.save(selectedFontName!, forKey: "FontName", toPlistWithName: "Preferences"){ e in
//                if e == nil{
//                    NotificationCenter.default.post(name: NSNotification.Name(FontNameNotification), object: nil, userInfo: ["FontName": self.selectedFontName!])
//                    navigationController?.popViewController(animated: true)
//                }
//            }
//        }
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Required to update the route, when this VC was dismissed through back button from
        // NavigationController, since we can't intercept the back button
        if mainStore.state.navigationState.route ==
            [SettingsNavViewController.route(),
             SettingsTabViewController.route(),
             FontNameViewController.route()] {
            mainStore.dispatch(SetRouteAction([SettingsNavViewController.route(),
                                               SettingsTabViewController.route()]))
        }
    }
}





