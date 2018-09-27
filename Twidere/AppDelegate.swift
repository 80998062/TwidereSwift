//
//  AppDelegate.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/16.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import SwiftTheme
import ReSwift
import Swinject
import PopMenu
import RxSwift
import ReSwiftRouter
import CC

/// global module
let container: Container = Container(){ it in
    
    it.register(PopMenuManager.self){ _ in
        let manager = PopMenuManager()
        manager.registerThemeManager()
        return manager
    }
}

let mainStore = Store<AppState>(reducer: appReducer,state: nil)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var router: Router<AppState>!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        setupPalette()
        window = UIWindow(frame: UIScreen.main.bounds)
        /*
         Set a dummy VC to satisfy UIKit
         Router will set correct VC throug async call which means
         window would not have rootVC at completion of this method
         which causes a crash.
         */
        window?.rootViewController = UIViewController()
        
        let rootRoutable = RootRoutable(window!)
        
        router = Router(store: mainStore, rootRoutable: rootRoutable) { state in
            state.select{ $0.navigationState }
        }
        
        mainStore.dispatch(ReSwiftRouter.SetRouteAction([SettingsNavViewController.route()]))
        
        window?.makeKeyAndVisible()
        return true
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        SwiftyPlistManager.shared.start(plistNames: ["Preferences"], logging: true)
    }
   
}


// MARK: - apply themes
extension AppDelegate{
   
    private func setupPalette() -> Void {
        let savedFontName = currentFontName()
        let savedThemeName = currentThemeName() ?? "Classic"
        ThemeManager.setTheme(plistName: savedThemeName, path: .mainBundle)
        
        // status bar
        UIApplication.shared.theme_setStatusBarStyle("UIStatusBarStyle", animated: true)
        // navigation bar
        let navigationBar = UINavigationBar.appearance()
        navigationBar.theme_tintColor = "Theme.colorAccent"
        navigationBar.theme_barTintColor = "Theme.colorLight"
        let barButtonItem = UIBarButtonItem.appearance()
        barButtonItem.theme_tintColor = "Theme.colorAccent"
        navigationBar.theme_titleTextAttributes = ThemeDictionaryPicker(keyPath: "Text.colorPrimary") { value -> [NSAttributedString.Key : AnyObject]? in
            guard let rgba = value as? String else {
                return nil
            }
            
            let color = UIColor(rgba: rgba)
            let shadow = NSShadow(); shadow.shadowOffset = CGSize.zero
            let titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: color,
                NSAttributedString.Key.font: ScaledFont.init(fontName: savedFontName).font(forTextStyle: .subheadline),
                NSAttributedString.Key.shadow: shadow
            ]
            
            return titleTextAttributes
        }
        
        let label = UILabel.appearance()
        label.theme_highlightedTextColor = "Text.colorLink"
        label.theme_textColor = "Text.colorPrimary"
        label.theme_tintColor = "Text.colorLink"
        /// UILabel 显示中英文的时候存在差别，含有中文的 Label，
        /// 默认会创建一个透明 Content 的 Sublayer，同样会造成图层混合，
        /// 解决方式是设置 label.layer.masksToBounds 为 true。
        label.layer.masksToBounds = true
        /// UILabel 的默认背景是透明的 而透明的视图为发生图层混合
        label.backgroundColor =  UIColor.clear
        
        let text = UITextView.appearance()
        text.theme_textColor = "Text.colorPrimary"
        text.theme_tintColor = "Text.colorLink"
        text.backgroundColor =  UIColor.clear
        text.layer.masksToBounds = true
       
        
        let field = UITextField.appearance()
        field.theme_textColor = "Text.colorPrimary"
        field.theme_tintColor = "Text.colorLink"
        field.backgroundColor = UIColor.clear
        field.layer.masksToBounds = true
     
    
        let listView = UITableView.appearance()
        listView.theme_separatorColor = "List.colorSeperator"
        listView.theme_backgroundColor = "Theme.windowBackground"
        
        let cell = UITableViewCell.appearance()
        cell.selectionStyle = .none
        cell.theme_backgroundColor = "List.itemBackground"
        let button = UIButton.appearance()
        button.theme_tintColor = "Theme.colorAccent"
      
        
        let toggle = UISwitch.appearance()
        toggle.theme_onTintColor = "Theme.colorAccent"
        
    }
}


