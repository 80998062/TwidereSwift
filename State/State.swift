//
//  State.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/9/14.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftRouter

struct AppState: StateType, HasNavigationState {
    var navigationState: NavigationState
}
