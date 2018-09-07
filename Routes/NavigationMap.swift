//
//  NavigationMap.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/31.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import SafariServices
import UIKit
import URLNavigator

public let APP_SCHEME = "navigator"
public let APP_HOST = "twidere"

public func appRoute(path: String?) -> String{
    var it = URLComponents()
    it.host = APP_HOST
    it.scheme = APP_SCHEME
    if  path == nil {
        it.path = "/"
    }else{
        it.path = path!
    }
    return it.string!
}

protocol Routable {
    static var URL: String { get }
}

enum NavigationMap {
    
    /// initialize
    ///
    /// - Parameter navigator: NavigatorType
    public static func initialize(navigator: NavigatorType) {

        navigator.register(SettingsNavViewController.URL, { _,_,_  in
            return SettingsNavViewController()
        })
        
        navigator.register(SettingsTabViewController.URL, { _,_, context in
            let primaryIndex = context as? Int
            return SettingsTabViewController(forPrimaryItem: primaryIndex)
        })
        
        navigator.register(FontNameViewController.URL, { _,_, context in
            guard let args = context as? [String : Any?] else {
                fatalError()
            }
            let a = args[FontNameViewController.ARGS_FONT_NAME] as? String
            let b = args[FontNameViewController.ARGS_COMPLETION] as? ((_:String?) -> Void)
            return FontNameViewController(fontName: a, completion: b)
       
        })
        
        navigator.register(EditSourceController.URL, { _,_,_  in
            return EditSourceController(source: nil)
        })
        
        
        navigator.handle("navigator://<path:_>") { (url, values, context) -> Bool in
            // No navigator match, do analytics or fallback function here
            print("[Navigator] NavigationMap.\(#function):\(#line) - global fallback function is called")
            return true
        }
        
        navigator.register("http://<path:_>", self.webViewControllerFactory)
        navigator.register("https://<path:_>", self.webViewControllerFactory)
        
    }
    
    private static func webViewControllerFactory(
        url: URLConvertible,
        values: [String: Any],
        context: Any?
        ) -> UIViewController? {
        guard let url = url.urlValue else { return nil }
        return SFSafariViewController(url: url)
    }
    
    private static func alert(navigator: NavigatorType) -> URLOpenHandlerFactory {
        return { url, values, context in
            guard let title = url.queryParameters["title"] else { return false }
            let message = url.queryParameters["message"]
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            navigator.present(alertController)
            return true
        }
    }
}
