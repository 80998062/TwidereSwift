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
    typealias Location = String
    case zhHans = "zh-Hans", en , ja
    static func actions(didSelect handler: PopMenuAction.PopMenuActionHandler?) -> [PopMenuAction]{
        var actions = [PopMenuDefaultAction]()
        let icon = UIImage.iconFont(imageSize: .icon_menu, icon: FontAwesome.github)
        for type in (LanguageType.allCases) {
            actions.append(PopMenuDefaultAction(title: type.localizable(), image: icon, color: nil, didSelect: handler))
        }
        return actions
    }
    
    func localizable() -> String{
        return NSLocalizedString(rawValue, comment: "Language name")
    }
}
