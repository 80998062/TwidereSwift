//
//  EditSourceController.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/24.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import PopMenu
import YFIconFont
import RxSwift
import ReSwiftRouter

extension EditSourceController{
    func setupNavigationBar(){
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationItem.title = "Edit Source"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(EditSourceController.onDone))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .done, target: self, action: #selector(EditSourceController.onScanQRCode))
        
    }
    
    @objc dynamic func onDone(){
        print("done")
        navigationController?.popViewController(animated: true)
    }
    
    
    
    @objc dynamic func onScanQRCode(){
        print("onScanQRCode")
    }
}



class EditSourceController: UITableViewController {
    
    fileprivate var sourceCopy: Source?{
        didSet{
            tableView.reloadData()
        }
    }
    
    convenience init(source: Source?){
        self.init(nibName: nil, bundle: nil)
        if nil == source{
            self.sourceCopy = source
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearsSelectionOnViewWillAppear = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        register(tableView, cell: PopMenuCell.self)
        register(tableView, cell: SwitchMenuCell.self)
        register(tableView, cell: TextFieldCell.self)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    private let sectionTitles = ["API URL",nil,"Account Type","Auth Type",nil,"Consumer Identity",nil,]
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
            it.backgroundView = headerFooterBackground
        }
    }
    
    private lazy var headerFooterBackground: UIView = {
        let it  = UIView(frame: CGRect.zero)
        it.theme_backgroundColor = "Theme.windowBackground"
        return it
    }()
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let title = sectionTitles[section]
        return title == nil ? nil : " "
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .cell_spacing
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .list_head_height
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            let cell = dequeue(tableView, cell: TextFieldCell.self, indexPath: indexPath)
            let hint = "URL Format"
            cell.textField.placeholder = hint
            return cell
        case 1:
            let cell = dequeue(tableView, cell: SwitchMenuCell.self, indexPath: indexPath)
            cell.bind(title: "Version Suffix", subTitle: nil, isOn: false)
            return cell
        case 2:
            let cell = dequeue(tableView, cell: PopMenuCell.self, indexPath: indexPath)
            cell.textLabel?.text = "Twitter"
            return cell
        case 3: // Auth Type
            let cell = dequeue(tableView, cell: PopMenuCell.self, indexPath: indexPath)
            cell.textLabel?.text = "Basic"
            return cell
        case 4:
            let cell = dequeue(tableView, cell: SwitchMenuCell.self, indexPath: indexPath)
            cell.bind(title: "Use same URL for OAuth signing", subTitle: nil, isOn: false)
            return cell
        case 5:
            let cell = dequeue(tableView, cell: TextFieldCell.self, indexPath: indexPath)
            cell.textField.placeholder = "Consumer Key"
            return cell
        case 6:
            let cell = dequeue(tableView, cell: TextFieldCell.self, indexPath: indexPath)
            cell.textField.placeholder = "Consumer Secret"
            return cell
            
        default:
            fatalError()
        }
    }
    
    
    let manager: PopMenuManager = container.resolve(PopMenuManager.self)!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        switch section {
        case 0,1,4,5,6:
            break
        case 2:
            let cell = tableView.cellForRow(at: indexPath) as? PopMenuCell
            manager.actions = AccountType.actions(didSelect: accoutTypeHandler)
            manager.present(sourceView: cell?.indicator, on: self, animated: true, completion: nil)
            break
        case 3:
            let cell = tableView.cellForRow(at: indexPath) as? PopMenuCell
            manager.actions = AuthType.actions(didSelect: authTypeHandler)
            manager.present(sourceView: cell?.indicator, on: self, animated: true, completion: nil)
            break
        default:
            fatalError()
        }
        
    }
    
    private let accoutTypeHandler: PopMenuAction.PopMenuActionHandler = { action in
        if nil != action.title{
            guard let it = AccountType(rawValue: action.title!) else{
                fatalError()
            }
//            sourceCopy?.accountType = it
            print("\(String(describing: action.title)) is selected")
        }
    }
    
    
    private let authTypeHandler: PopMenuAction.PopMenuActionHandler = { action in
        if nil != action.title{
            guard let it = AuthType(rawValue: action.title!) else{
                fatalError()
            }
            //            sourceCopy?.accountType = it
            print("\(String(describing: action.title)) is selected")
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        // Required to update the route, when this VC was dismissed through back button from
        // NavigationController, since we can't intercept the back button
        if mainStore.state.navigationState.route ==
            [SettingsNavViewController.route(),
             SettingsTabViewController.route(),
             EditSourceController.route()] {
            mainStore.dispatch(SetRouteAction([SettingsNavViewController.route(),
                                               SettingsTabViewController.route()]))
        }
    }
}
