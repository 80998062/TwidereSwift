//
//  Configuration.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/10/9.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import RealmSwift

func connectToRealmCloud(context aContext: UIViewController,ompletion handler: @escaping () -> Void){
    let creds = SyncCredentials.nickname(Constants.ADMIN_NAME, isAdmin: true)
    SyncUser.logIn(with: creds, server: Constants.AUTH_URL, onCompletion: { (user, err) in
        if let _ = user {
            handler()
        } else if let error = err {
            fatalError(error.localizedDescription)
        }
    })
}
