//
//  CardDisplayViewController.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/21.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import SwiftTheme
import ReSwiftRouter

class FeedDisplayViewController: UITableViewController{
    
    public static func embedInNavigationController() -> UINavigationController{
        let it = UINavigationController(rootViewController: FeedDisplayViewController())
        it.isNavigationBarHidden = true
        return it
    }
    
    private let Options = ["Preview",
                           "FontSize",
                           "FontName",
                           "MediaPreviews",
                           "HideActions",
                           "SoundEffects"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        register(tableView, cell: SwitchMenuCell.self)
        register(tableView, cell: FontSizeCell.self)
        register(tableView, cell: StaticFeedCell.self)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FontName")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Options.count
    }
    
    // MARK: - Let every cell to take a section in group tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .cell_spacing
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
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let title = Options[section]
        return title == "HideActions" ?  nil : " "
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = Options[section]
        switch title {
        case "Preview":
            return "Display"
        case "SoundEffects":
            return "Sound"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .list_head_height
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = Options[indexPath.section]
        switch title{
        case "Preview":
            let cell = dequeue(tableView, cell: StaticFeedCell.self, indexPath: indexPath)
            return cell
        case "FontSize":
            let cell = dequeue(tableView, cell: FontSizeCell.self, indexPath: indexPath)
            return cell
        case "FontName":
            let cell = tableView.dequeueReusableCell(withIdentifier: "FontName", for: indexPath)
            cell.textLabel?.text = "FontName"
            cell.accessoryType = .disclosureIndicator
            return cell
        case "MediaPreviews", "HideActions","SoundEffects":
            let cell = dequeue(tableView, cell: SwitchMenuCell.self, indexPath: indexPath)
            cell.bind(title: title, subTitle: nil, isOn: true)
            return cell
        default:
            let cell = dequeue(tableView, cell: SwitchMenuCell.self, indexPath: indexPath)
            cell.bind(title: "Section: \(indexPath.section)", subTitle: nil, isOn: true)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = Options[indexPath.section]
        switch title {
        case "FontName":
            let newRoute = [settingsRoute, fontNameRoute]
            appStore.dispatch(ReSwiftRouter.SetRouteAction(newRoute))
            break
        default:
            break
        }
    }
    
}
