//
//  Font+Ext.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/24.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import CC

public let FontNameNotification = "SinyukFontNameNotification"

public func addFontNameObserver(observer: Any, selector: Selector){
    removeFontNameObserver(observer: observer)
    NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name.init(FontNameNotification), object: nil)
}

public func removeFontNameObserver(observer: Any){
    NotificationCenter.default.removeObserver(observer, name: NSNotification.Name.init(FontNameNotification), object: nil)
}

public func currentFontName() -> String?{
    guard let fontName = SwiftyPlistManager.shared.fetchValue(for: "FontName", fromPlistWithName: "Preferences") else {
        return nil
    }
    
    return fontName as? String
}

protocol FontNameObserver {
    func didFontNameChanged(notification: NSNotification)
}

extension UILabel{
    
    func updateScaledFont(_ name: String? = nil,_ style: UIFont.TextStyle? = nil){
        var defaultStyle = style ??
            font.fontDescriptor.object(forKey: UIFontDescriptor.AttributeName.textStyle) as? UIFont.TextStyle
        let defaultFont = name ?? currentFontName()
        if defaultStyle == nil{
            defaultStyle = UIFont.TextStyle.body
        }
        font = ScaledFont(fontName: defaultFont).font(forTextStyle: defaultStyle!)
        adjustsFontForContentSizeCategory = true
    }
    
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if !adjustsFontForContentSizeCategory{
            updateScaledFont()
        }
    }
    
    //            addFontNameObserver(observer: self, selector: #selector(self.didFontNameChanged))
    //    @objc dynamic func didFontNameChanged(notification: NSNotification) {
    //        if let fontName = notification.userInfo?["FontName"] as? String{
    //            SwiftyPlistManager.shared.getValue(for: "FontName", fromPlistWithName: "Preferences" ){ (result, err) in
    //                if err == nil && fontName == (result as? String){
    //                    let style = font.fontDescriptor.object(forKey: UIFontDescriptor.AttributeName.textStyle) as? UIFont.TextStyle
    //                    updateScaledFont(fontName, style)
    //                }
    //            }
    //        }
    //    }
    
    //    open override func removeFromSuperview() {
    //        super.removeFromSuperview()
    //        removeFontNameObserver(observer: self)
    //    }
}



extension UIButton{
    
    func updateScaledFont(_ name: String? = nil,_ style: UIFont.TextStyle? = nil){
        var defaultStyle = style ??
            titleLabel?.font.fontDescriptor.object(forKey: UIFontDescriptor.AttributeName.textStyle) as? UIFont.TextStyle
        let defaultFont = name ?? currentFontName()
        if defaultStyle == nil{
            defaultStyle = UIFont.TextStyle.body
        }
        titleLabel?.font = ScaledFont(fontName: defaultFont).font(forTextStyle: defaultStyle!)
        titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if !(titleLabel?.adjustsFontForContentSizeCategory ?? false){
            updateScaledFont()
        }
    }
}

extension UITextField{
    
    func updateScaledFont(_ name: String? = nil,_ style: UIFont.TextStyle? = nil){
        var defaultStyle = style ??
            font?.fontDescriptor.object(forKey: UIFontDescriptor.AttributeName.textStyle) as? UIFont.TextStyle
        let defaultFont = name ?? currentFontName()
        if defaultStyle == nil{
            defaultStyle = UIFont.TextStyle.body
        }
        font = ScaledFont(fontName: defaultFont).font(forTextStyle: defaultStyle!)
        adjustsFontForContentSizeCategory = true
    }
    
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if !adjustsFontForContentSizeCategory{
            updateScaledFont()
        }
    }
}
