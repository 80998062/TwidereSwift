//
//  NewPopMenu+Ext.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/9/7.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import PopMenu
import SwiftTheme

extension PopMenuManager: ThemeObserver{
    func didThemeSwitched() {
        let tint = ThemeManager.color(for: "Control.colorNormal")!
        popMenuAppearance.popMenuColor.actionColor = PopMenuActionColor.tint(tint)
        let accent = ThemeManager.color(for: "Theme.colorVerified")!
        let light = ThemeManager.color(for: "Theme.colorLight")!
        popMenuAppearance.popMenuColor.backgroundColor = .gradient(fill: light, accent)
    }
    
    func registerThemeManager(){
        let tint = ThemeManager.color(for: "Control.colorNormal")!
        popMenuAppearance.popMenuColor.actionColor = PopMenuActionColor.tint(tint)
        let accent = ThemeManager.color(for: "Theme.colorVerified")!
        let light = ThemeManager.color(for: "Theme.colorLight")!
        popMenuAppearance.popMenuColor.backgroundColor = .gradient(fill: light, accent)
    }
}

