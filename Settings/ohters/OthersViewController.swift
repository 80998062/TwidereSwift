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
import CC
import Localize
import RxSwift

class OthersViewController: UITableViewController {
    
    fileprivate var currentLanguage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearsSelectionOnViewWillAppear = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        register(tableView, cell: PopMenuCell.self)
        currentLanguage = Localize.currentLanguage()
        
        //
        addLanguageObserver(observer: self, selector: #selector(self.didLanguageChanged))
    }
    
    private let sectionHeaders = ["Language"]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaders.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section].localized()
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
        return sectionFooters[section].localized()
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
            let name = currentLanguage == nil ? nil : Localize.displayNameForLanguage(currentLanguage!)
            cell.textLabel?.text = name
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
            manager.actions = languagePopMenuActions(handler: willSwitchLanguage)
            manager.present(sourceView: cell?.indicator, on: self, animated: true, completion: nil)
            break
        default:
            fatalError()
        }
    }
    
    
     /// will switch language
     ///
     /// - Parameter action: action
     @objc dynamic func willSwitchLanguage(action: PopMenuAction) -> Void{
        guard let title = action.title else{ fatalError() }
        guard  let index = languageDisplayNames().firstIndex(of: title) else{ fatalError() }
        
        let newValue = Localize.availableLanguages()[index]
        if newValue != currentLanguage{
            Localize.setCurrentLanguage(newValue)
            currentLanguage = newValue
        }
    }
    
}


extension OthersViewController: StoreSubscriber{
    typealias StoreSubscriberStateType = Others
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainStore.subscribe(self){ state in
            state.select{ $0.settingsState.others }
        }
    }
    
    func newState(state: Others) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        mainStore.unsubscribe(self)
    }
}


extension OthersViewController: LanguageObserver{
    @objc dynamic func didLanguageChanged(){
        tableView.reloadData()
    }
}
