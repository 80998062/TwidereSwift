//
//  AppReducer.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/28.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftRouter

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        navigationState: NavigationReducer.handleAction(action, state: state?.navigationState),
        settingsState: settignsReducer(action: action, state: state?.settingsState)
    )
}

