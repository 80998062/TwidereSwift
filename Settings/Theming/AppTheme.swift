//
//  AppTheme.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/9/19.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import SwiftTheme

protocol ThemeObserver {
    func didThemeSwitched()
}

enum AppTheme: String {
    
    case Classic, Dark, LadiesNight, PinkPower, YourName
    
    public func allValues() -> [AppTheme]{
        return [AppTheme.Classic,
                AppTheme.Dark,
                AppTheme.LadiesNight,
                AppTheme.PinkPower,
                AppTheme.YourName]
    }
    
    public func colors() -> [UIColor]{
        return provideThemeColors(self)
    }
    
    
    /// get theme palette
    ///
    /// - Parameter theme: theme
    /// - Returns: theme color palette
    private func provideThemeColors(_ theme: AppTheme) -> [UIColor]{
        var colors = [UIColor]()
        if let path = Bundle.main.path(forResource: theme.rawValue, ofType: "plist"){
            if let plist = NSDictionary(contentsOfFile: path){
                if let dict = plist["Theme"] as! NSDictionary?{
                    colors = dict.allValues.compactMap{ rgba  -> UIColor? in
                        guard let color = try? UIColor(rgba_throws: rgba as! String) else { print("SwiftTheme WARNING: Can't convert rgba \(rgba)")
                            return nil
                        }
                        return color
                    }
                }
            }
        }
        return colors
    }
}
