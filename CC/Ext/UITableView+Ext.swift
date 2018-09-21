//
//  UITableViewExt.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/17.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit

public func register(_ tableView:UITableView , cell:AnyClass)->Void {
    tableView.register( cell, forCellReuseIdentifier: "\(cell)");
}

public func dequeue<T: UITableViewCell>(_ tableView:UITableView ,cell: T.Type ,indexPath:IndexPath) -> T {
    return tableView.dequeueReusableCell(withIdentifier: "\(cell)", for: indexPath) as! T ;
}

public extension UITableView {
    public func scrollToBottom() {
        let section = self.numberOfSections - 1
        let row = self.numberOfRows(inSection: section) - 1
        if section < 0 || row < 0 {
            return
        }
        let path = IndexPath(row: row, section: section)
        self.scrollToRow(at: path, at: .top, animated: false)
    }
}
