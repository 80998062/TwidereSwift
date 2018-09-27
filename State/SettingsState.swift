//
//  File.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/9/13.
//  Copyright © 2018 Sinyuk. All rights reserved.
//


struct SettingsState {
    public static let _default = SettingsState(
        login: Login._default,
        theme: Theme._default,
        display: Display._default,
        others: Others._default)
    
    var login: Login
    var theme: Theme
    var display: Display
    var others: Others
}

struct Login {
    public static let _default = Login()
}


struct Theme {
    public static let _default = Theme(name: "a")
    var name: String
}

struct Display {
    public static let _default = Display(fontName: "System")
    var fontName: String
}

struct Others {
    public static let _default = Others()
}
