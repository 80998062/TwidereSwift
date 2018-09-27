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

struct Source{
    public static let _default = Source(uniqueId: Date().description,
                                        url: URLMasks.TwitterURL.rawValue,
                                        urlForSigning: false,
                                        versionSuffix: false,
                                        accountType: AccountType.Twitter,
                                        authTypes: AuthType.Basic,
                                        consumer: nil)
    
    var uniqueId:String
    var url: String
    var urlForSigning: Bool?
    var versionSuffix: Bool?
    var accountType: AccountType
    var authTypes: AuthType
    var consumer: Consumer?
    
    struct Consumer {
        var consumerKey: String
        var consumerSecret: String
    }
    
    
    //    init(url: URL, accountType: AccountType ,sameUrlForSigning: Bool? = false,noVersionSuffix: Bool? = false, consumerKey: String? = nil ,consumerSecret: String? = nil) {
    //        self.url = url
    //        self.accountType = accountType
    //        self.authType = authType
    //        self.sameUrlForSigning = sameUrlForSigning
    //        self.noVersionSuffix = noVersionSuffix
    //        self.consumerKey = consumerKey
    //        self.consumerSecret = consumerSecret
    //    }
}
