//
//  AppsTableViewController.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/10/9.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import RealmSwift

class AppsTableViewController: UITableViewController {

    private lazy var realm: Realm = {
        let syncConfig = SyncConfiguration(user: SyncUser.current!, realmURL: Constants.REALM_URL)
        return try! Realm(configuration: Realm.Configuration(syncConfiguration: syncConfig, objectTypes:[App.self]))
    }()
   
    private lazy var items: Results<App> = {
        return realm.objects(App.self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearsSelectionOnViewWillAppear = false
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.selectionStyle = .none
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        cell.accessoryType =  UITableViewCell.AccessoryType.checkmark
        return cell
    }

}
