//
//  Routes.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/28.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import ReSwiftRouter

let settingsRoute: RouteElementIdentifier = "Settings"
let fontNameRoute: RouteElementIdentifier = "FontName"

class RootRoutable: Routable{
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    private func setToSettings() -> Routable{
        let it = SettingsViewController.newInstance()
        self.window.rootViewController = it
        return SettingsRoutable(forViewController: it)
    }
    
    func changeRouteSegment(_ from: RouteElementIdentifier, to: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        switch to {
        case settingsRoute:
            completionHandler()
            return setToSettings()
        default:
            fatalError("Route \(to.description) not supported!")
        }
    }
    
    func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
        // TODO: this should technically never be called -> bug in router
        completionHandler()
    }
    
    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        switch routeElementIdentifier {
        case settingsRoute:
            completionHandler()
            return setToSettings()
        default:
            fatalError("Route \(routeElementIdentifier.description) not supported!")
        }
    }
}

class SettingsRoutable: Routable{
    let viewController: UINavigationController
    
    init(forViewController vc: UINavigationController) {
        self.viewController = vc
    }
    
    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        switch routeElementIdentifier {
        case fontNameRoute:
            let it = FontNameViewController()
            self.viewController.pushViewController(it, animated: true, completion: completionHandler)
            return FontNameRoutable(forViewController: it)
        default:
            fatalError("Route \(routeElementIdentifier.description) not supported!")
        }
    }
    
    func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
        viewController.navigationController?.popViewController(true, completion: completionHandler)
    }
}


class FontNameRoutable: Routable{
    let viewController: UIViewController
    
    init(forViewController vc: UIViewController) {
        self.viewController = vc
    }
}
