//
//  SettingsViewController+Ext.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/23.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import ReSwift

class SettingsNavViewController: UINavigationController{
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.prefersLargeTitles = false
        navigationBar.isTranslucent = false
        navigationItem.setHidesBackButton(false, animated: true)
    }
}


extension SettingsNavViewController: Routable{

    static var URL: String {
        return appRoute(path: "/settings")
    }
}
