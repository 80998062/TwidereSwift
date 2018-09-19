//
//  SettingsReducer.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/9/19.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import Foundation
import ReSwift

func settignsReducer(action: Action, state: SettingsState?) -> SettingsState {
    let state = state ?? SettingsState._default
    switch action {
    case _ as ReSwiftInit:
        break
    default:
        break
    }
    return state
}
