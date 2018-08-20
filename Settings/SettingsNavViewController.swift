
//
//  SettingsNavigationViewController.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/19.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import YFIconFont

class SettingsNavViewController: UINavigationController {

    public static func newInstance() -> UINavigationController  {
        return SettingsNavViewController(rootViewController: SettingsViewController())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        navigationBar.isTranslucent = false
        navigationItem.title = "XXX"
        navigationItem.backBarButtonItem = {
            let icon = UIImage.iconFont(imageSize: .icon_nav, icon: FontAwesome.windowclose)
            let it = UIBarButtonItem(image: icon, style: UIBarButtonItemStyle.plain, target: self, action: nil)
            return it
        }()
    }

}
