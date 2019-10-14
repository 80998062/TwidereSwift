//
//  SettingsViewController+Ext.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/23.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

class SettingsNavViewController: UINavigationController{
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        
        mainStore.dispatch(ReSwiftRouter.SetRouteAction([
            SettingsNavViewController.route(),
            SignInViewController.route()]))
    }
}
