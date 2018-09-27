//
//  CardDisplayViewController.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/21.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import SwiftTheme
import ReSwift
import ReSwiftRouter
import CC

class DisplayViewController: UITableViewController{
    fileprivate let Options = ["Display",
                               "FontSize",
                               "FontName",
                               "Media Previews",
                               "Hide Actions",
                               "Sound Effects"]
    
    fileprivate var fontName: String? {
        didSet{
            guard let section = Options.index(of: "FontName")else{
                fatalError()
            }
            tableView.reloadSections([section], with: .automatic)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearsSelectionOnViewWillAppear = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        register(tableView, cell: SwitchMenuCell.self)
        register(tableView, cell: FontSizeCell.self)
        register(tableView, cell: StaticFeedCell.self)
        register(tableView, cell: SelectedFontCell.self)
        self.fontName = currentFontName()
        
        //
        addFontNameObserver(observer: self, selector: #selector(self.didFontNameChanged))
        addLanguageObserver(observer: self, selector: #selector(self.didLanguageChanged))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Options.count
    }
    
    // MARK: - Let every cell to take a section in group tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .list_head_height
    }
    
    private lazy var headerFooterBackground: UIView = {
        let it  = UIView(frame: CGRect.zero)
        it.theme_backgroundColor = "Theme.windowBackground"
        return it
    }()
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let it = view as? UITableViewHeaderFooterView{
            it.textLabel?.theme_textColor = "Text.colorSecondary"
            it.backgroundView = headerFooterBackground
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let it = view as? UITableViewHeaderFooterView{
            it.textLabel?.backgroundColor = UIColor.clear
            it.backgroundView = headerFooterBackground
        }
    }
    
    // MARK -  cell spacing
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .cell_spacing
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let title = Options[section]
        return title == "Hide Actions" ?  nil : " "
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = Options[section]
        switch title {
        case "Display":
            return "Display".localized()
        case "Sound Effects":
            return "Sound".localized()
        default:
            return nil
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = Options[indexPath.section]
        switch title{
        case "Display":
            let cell = dequeue(tableView, cell: StaticFeedCell.self, indexPath: indexPath)
            cell.bind()
            return cell
        case "FontSize":
            let cell = dequeue(tableView, cell: FontSizeCell.self, indexPath: indexPath)
            return cell
        case "FontName":
            let cell = dequeue(tableView, cell: SelectedFontCell.self, indexPath: indexPath)
            cell.bind(fontName: self.fontName)
            return cell
        case "Media Previews", "Hide Actions","Sound Effects":
            let cell = dequeue(tableView, cell: SwitchMenuCell.self, indexPath: indexPath)
            cell.bind(title: title.localized(), subTitle: nil, isOn: true)
            return cell
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = Options[indexPath.section]
        switch title {
        case "FontName":
            mainStore.dispatch(SetRouteAction([SettingsNavViewController.route(),
                                               SettingsTabViewController.route(),
                                               FontNameViewController.route()]))
            break
        default:
            break
        }
    }
}

extension DisplayViewController: FontNameObserver , LanguageObserver {
    
    @objc dynamic func didFontNameChanged(notification: NSNotification) {
        if let newFontName = notification.userInfo?["FontName"] as? String{
            if newFontName != fontName{
                fontName = newFontName
            }
        }
    }
    
    @objc dynamic func didLanguageChanged(){
        tableView.reloadData()
    }
}




