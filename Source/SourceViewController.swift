//
//  SourceViewController.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/24.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import ReSwift
import URLNavigator

extension SourceViewController: Routable{
    static var URL: String {
        return appRoute(path: "settings/source")
    }
}

class SourceViewController: UITableViewController {
    
    let navigator = container.resolve(NavigatorType.self)!

    override func viewDidLoad() {
        super.viewDidLoad()
        clearsSelectionOnViewWillAppear = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.setEditing(true, animated: true)
        tableView.allowsSelectionDuringEditing = true
        register(tableView, cell: SourceCell.self)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeue(tableView, cell: SourceCell.self, indexPath: indexPath)
        cell.bind(screenName: "Sinyuk \(indexPath.row)", id: "@sinyuk\(indexPath.row)", urlFor: nil)
        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
 
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select row at \(indexPath.row)")
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        guard let it = self.navigationController else {
            fatalError()
        }
        navigator.push(EditSourceController.URL, context: nil, from: it, animated: true)
    }
}



