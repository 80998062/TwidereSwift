//
//  Language+Ext.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/9/18.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import PopMenu
import IconFont
import Localize

func languagePopMenuActions(handler: PopMenuAction.PopMenuActionHandler? , excludeBase: Bool = true) -> [PopMenuAction]{
    var actions = [PopMenuDefaultAction]()
    for type in (Localize.availableLanguages(true)) {
        let title = Localize.displayNameForLanguage(type)
        let action = PopMenuDefaultAction(title: title, image: nil, color: nil, didSelect: handler)
        actions.append(action)
    }
    return actions
}


func languageDisplayNames() -> [String]{
    return Localize.availableLanguages(true).map{ type in
        return Localize.displayNameForLanguage(type)
    }
}


public func addLanguageObserver(observer: Any, selector: Selector){
    NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
}

public func removeLanguageObserver(observer: Any){
    NotificationCenter.default.removeObserver(observer, name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
}

protocol LanguageObserver {
    func didLanguageChanged()
}
