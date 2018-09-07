//
//  File.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/9/5.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit

enum AccountType: String,CaseIterable {
    case Twitter, Weibo , Fanfou
}

enum AuthType: String, CaseIterable {
    case Basic, OAuth , OAuth2 , xAuth
}

struct Source{
    var url: URL
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
