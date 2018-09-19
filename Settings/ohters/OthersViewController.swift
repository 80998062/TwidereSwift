//
//  OthersViewController.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/9/18.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter
import PopMenu

class OthersViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        clearsSelectionOnViewWillAppear = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        register(tableView, cell: PopMenuCell.self)
    }


    private let sectionHeaders = ["Language"]

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaders.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section]
    }

    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let it = view as? UITableViewHeaderFooterView{
            it.textLabel?.theme_textColor = "Text.colorSecondary"
            it.backgroundView = headerFooterBackground
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let it = view as? UITableViewHeaderFooterView{
            it.textLabel?.backgroundColor = UIColor.clear
            it.textLabel?.theme_textColor = "Text.colorSecondary"
            it.textLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
            it.textLabel?.adjustsFontForContentSizeCategory = true
            it.backgroundView = headerFooterBackground
        }
    }
    
    private lazy var headerFooterBackground: UIView = {
        let it  = UIView(frame: CGRect.zero)
        it.theme_backgroundColor = "Theme.windowBackground"
        return it
    }()
    
    private let sectionFooters = ["The changes will take effect when the app is restarted"]
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sectionFooters[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .list_footer_height
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .list_head_height
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            let cell = dequeue(tableView, cell: PopMenuCell.self, indexPath: indexPath)
            cell.textLabel?.text = "Chinese(Simplify)"
            return cell
        default:
            fatalError()
        }
    }
    
    let manager: PopMenuManager = container.resolve(PopMenuManager.self)!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        switch section {
        case 0:
            let cell = tableView.cellForRow(at: indexPath) as? PopMenuCell
            manager.actions = LanguageType.actions(didSelect: languageTypeHandler)
            manager.present(sourceView: cell?.indicator, on: self, animated: true, completion: nil)
            break
        default:
            fatalError()
        }
    }
    
    private let languageTypeHandler: PopMenuAction.PopMenuActionHandler = { action in
        if nil != action.title{
            guard let it = LanguageType(rawValue: action.title!) else{
                fatalError()
            }
            //            sourceCopy?.accountType = it
            print("\(String(describing: action.title)) is selected")
        }
    }
}