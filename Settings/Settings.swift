//
//  File.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/9/13.
//  Copyright © 2018 Sinyuk. All rights reserved.
//


struct SettingState {
    public static let defaults = Settings(
        login: Settings.Login(),
        theme: Settings.Theme(name: ""),
        display: Settings.Display(fontName: ""))
    
    var login: Login
    struct Login {
        
    }
    
    var theme: Theme
    struct Theme {
        var name: String
    }
    
    var display: Display
    struct Display {
        var fontName: String
    }
}

