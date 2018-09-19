//
//  Language+Ext.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/9/18.
//  Copyright © 2018 Sinyuk. All rights reserved.
//
import UIKit
import PopMenu
import IconFont

enum LanguageType: String,CaseIterable {
    case zhHans, en , japanese
    static func actions(didSelect handler: PopMenuAction.PopMenuActionHandler?) -> [PopMenuAction]{
        var actions = [PopMenuDefaultAction]()
        let icon = UIImage.iconFont(imageSize: .icon_menu, icon: FontAwesome.github)
        for type in (LanguageType.allValues) {
            actions.append(PopMenuDefaultAction(title: type.rawValue, image: icon, color: nil, didSelect: handler))
        }
        return actions
    }
}
