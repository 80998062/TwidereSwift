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
import ReSwiftRouter


var appStore = Store<State>(reducer: appReducer, state: nil)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var router: Router<State>!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        setupPalette()
        setupCustomFont()
        /*
         Set a dummy VC to satisfy UIKit
         Router will set correct VC throug async call which means
         window would not have rootVC at completion of this method
         which causes a crash.
         */
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = UIViewController()
        
        let rootRoutable = RootRoutable(window: window!)
        router = Router(store: appStore, rootRoutable: rootRoutable){ state in
            state.select { $0.navigationState }
        }
        let route = [InAppRoute.Settings.identifier(),
                     InAppRoute.Settings.Tabs.identifier()]
        appStore.dispatch(ReSwiftRouter.SetRouteAction(route))
        window!.makeKeyAndVisible()
        return true
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        SwiftyPlistManager.shared.start(plistNames: ["Prefs"], logging: true)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        //        store.dispatch(handleOpenURL(url: url))
        return false
    }
}


extension AppDelegate{
    private func setupCustomFont(){
        //        guard let customFont = SwiftyPlistManager.shared.fetchValue(for: "FontName", fromPlistWithName: "Info") else {
        //            fatalError("Can't find key: FontName in Info.plist")
        //        }
    }
    
    private func setupPalette() -> Void {
        guard let theme = SwiftyPlistManager.shared.fetchValue(for: "ThemeName", fromPlistWithName: "Prefs") else {
            print("Can't find key: ThemeName in Info.plist")
            return
        }
        
        ThemeManager.setTheme(plistName: theme as! String, path: .mainBundle)
        // status bar
        UIApplication.shared.theme_setStatusBarStyle("UIStatusBarStyle", animated: true)
        // navigation bar
        let navigationBar = UINavigationBar.appearance()
        navigationBar.theme_tintColor = "Theme.colorAccent"
        navigationBar.theme_barTintColor = "Theme.colorLight"
        let barButtonItem = UIBarButtonItem.appearance()
        barButtonItem.theme_tintColor = "Theme.colorAccent"
        navigationBar.theme_titleTextAttributes = ThemeDictionaryPicker(keyPath: "Text.colorPrimary") { value -> [NSAttributedStringKey : AnyObject]? in
            guard let rgba = value as? String else {
                return nil
            }
            
            let color = UIColor(rgba: rgba)
            let shadow = NSShadow(); shadow.shadowOffset = CGSize.zero
            let titleTextAttributes = [
                NSAttributedStringKey.foregroundColor: color,
                NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .subheadline),
                NSAttributedStringKey.shadow: shadow
            ]
            
            return titleTextAttributes
        }
        //
        let label = UILabel.appearance()
        label.theme_highlightedTextColor = "Text.colorLink"
        label.theme_textColor = "Text.colorPrimary"
        label.theme_tintColor = "Text.colorLink"
        /// UILabel 显示中英文的时候存在差别，含有中文的 Label，
        /// 默认会创建一个透明 Content 的 Sublayer，同样会造成图层混合，
        /// 解决方式是设置 label.layer.masksToBounds 为 true。
        label.layer.masksToBounds = true
        /// UILabel 的默认背景是透明的 而透明的视图为发生图层混合
        label.theme_backgroundColor = "Theme.windowBackground"
        
        let text = UITextView.appearance()
        text.theme_textColor = "Text.colorPrimary"
        text.theme_tintColor = "Text.colorLink"
        text.theme_backgroundColor = "Theme.windowBackground"
        text.layer.masksToBounds = true
        
        let field = UITextField.appearance()
        field.theme_textColor = "Text.colorPrimary"
        field.theme_tintColor = "Theme.colorLink"
        field.theme_backgroundColor = "Theme.windowBackground"
        field.layer.masksToBounds = true
        
        let control = SnapchatCheckbox.appearance()
        control.theme_tintColor = "Theme.colorAccent"
        
        let listView = UITableView.appearance()
        listView.theme_separatorColor = "List.colorSeperator"
        listView.theme_backgroundColor = "Theme.windowBackground"
        
        let cell = UITableViewCell.appearance()
        cell.selectionStyle = .none
        cell.theme_backgroundColor = "List.itemBackground"
        cell.textLabel?.theme_textColor = "Text.colorPrimary"
        cell.detailTextLabel?.theme_textColor = "Text.colorSecondary"
        let button = UIButton.appearance()
        button.theme_tintColor = "Theme.colorAccent"
        
        let toggle = UISwitch.appearance()
        toggle.theme_onTintColor = "Theme.colorAccent"
        
    }
}

