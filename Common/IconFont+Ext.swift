//
//  IconFont+Ext.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/17.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import IconFont

public enum MyIconFont:String {
    public typealias RawValue = String
    case Back = "nil"
}

extension MyIconFont: IconFontType{
    public static var fontName: String {
        return "iconfont"
    }
    
    public static var fontFilePath: String?  = Bundle.main.path(forResource: "iconfont", ofType: "ttf")
    
    public var unicode: String {
        return self.rawValue
    }
}
