//
//  SettingsViewController+Ext.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/23.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import  Foundation
import  YFIconFont
import SwiftTheme

extension SettingsViewController{
    public static func newInstance() -> UINavigationController  {
        let it = UINavigationController(rootViewController: SettingsViewController())
        it.navigationBar.prefersLargeTitles = false
        it.navigationBar.isTranslucent = false
        it.setToolbarHidden(true, animated: false)
        return it
    }
}


extension SettingsViewController{
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func setupBarButtons(){
        self.navigationItem.title = "Settings"
        let icon = UIImage.iconFont(imageSize: .icon_nav, icon: FontAwesome.close)
        let close = UIBarButtonItem(image: icon, style: .done, target: self, action: #selector(SettingsViewController.onBackPress))
        self.navigationItem.leftBarButtonItem = close
    }
    
    /// <#Description#>
    @objc dynamic func onBackPress(){
        print("onBackPress")
    }
}
