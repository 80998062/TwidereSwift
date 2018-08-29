//
//  Font+Ext.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/24.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import SwiftTheme

extension UILabel: ThemeObserver{
    
    func updateScaledFont(forFontName name: String?,forFontStyle style: UIFontTextStyle){
        font = ScaledFont(fontName: name).font(forTextStyle: style)
        adjustsFontForContentSizeCategory = true
    }
    
    @objc dynamic func didThemeSwitched() {
        if let it = ThemeManager.string(for: "Text.font"){
            if font.fontName != it{
                let style =  font.fontDescriptor.object(forKey: UIFontDescriptor.AttributeName.textStyle) as! String
                updateScaledFont(forFontName: it, forFontStyle: UIFontTextStyle.init(style))
            }
        }
    }
}


extension UIButton: ThemeObserver{
    
    func updateScaledFont(forFontName name: String?,forFontStyle style: UIFontTextStyle){
        titleLabel?.font = ScaledFont(fontName: name).font(forTextStyle: style)
        titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
    func didThemeSwitched() {
        if let it = ThemeManager.string(for: "Text.font"){
            if titleLabel?.font.fontName != it{
                let style =  titleLabel?.font.fontDescriptor.object(forKey: UIFontDescriptor.AttributeName.textStyle) as! String
                updateScaledFont(forFontName: it, forFontStyle: UIFontTextStyle.init(style))
            }
        }
    }
}



