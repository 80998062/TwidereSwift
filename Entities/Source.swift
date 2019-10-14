//
//  File.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/9/5.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import PopMenu
import IconFont
import RealmSwift

enum AccountType: String, CaseIterable {
    case Twitter, Weibo , Fanfou
    static func actions(didSelect handler: PopMenuAction.PopMenuActionHandler?) -> [PopMenuAction]{
        var actions = [PopMenuDefaultAction]()
        let icon = UIImage.iconFont(imageSize: .icon_menu, icon: FontAwesome.github)
        for type in (AccountType.allCases) {
            actions.append(PopMenuDefaultAction(title: type.rawValue.localized(), image: icon, color: nil, didSelect: handler))
        }
        return actions
    }
}

enum AuthType: String, CaseIterable {
    case Basic, OAuth , OAuth2 , xAuth , twipO
    static func actions(didSelect handler: PopMenuAction.PopMenuActionHandler?) -> [PopMenuAction]{
        var actions = [PopMenuDefaultAction]()
        for type in (AuthType.allCases) {
            actions.append(PopMenuDefaultAction(title: type.rawValue, image: nil, color: nil, didSelect: handler))
        }
        return actions
    }
    
}

enum URLMasks: String{
    typealias RawValue = String
    case TwitterURL = "https://[DOMAIN].twitter.com/"
    case FanfouURL = "https://api.fanfou.com/"
}

class Source: Object{
    @objc dynamic var createdAt:Date = Date()
    @objc dynamic var endPoint: String = "/"
    let urlForSigning = RealmOptional<Bool>()
    let versionSuffix = RealmOptional<Bool>()
    @objc dynamic var accountType: String = AccountType.Twitter.rawValue
    @objc dynamic var authTypes: String = AuthType.OAuth2.rawValue    
    override static func primaryKey() -> String? {
        return "createdAt"
    }
}



/// From a async Realm
class App: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var state: String?
    @objc dynamic var scope: String?
    @objc dynamic var desc: String?
    @objc dynamic var homepage: String?
    @objc dynamic var consumerKey: String = ""
    @objc dynamic var consumerSecret: String = ""
    @objc dynamic var requestTokenUrl: String = ""
    @objc dynamic var accessTokenUrl: String = ""
    @objc dynamic var authorizeUrl: String = ""
    @objc dynamic var callbackUrl: String = ""
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
