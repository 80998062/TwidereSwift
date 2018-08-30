//
//  Routes.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/28.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import ReSwiftRouter


enum InAppRoute: RouteElementIdentifier, CaseIterable{
    typealias RawValue = RouteElementIdentifier
    enum Settings: RouteElementIdentifier, CaseIterable {
        enum Tabs : RouteElementIdentifier, CaseIterable{
            case Login
            case Theme
            case Cards
            case Sources
            case NavigationBar
            case Extensions
            case Refresh
            case Streaming
            case Notifications
            case Network
            case Compose
            case Content
            case Storage
            case Others
            case About
            case License
            public static func identifier() -> RouteElementIdentifier{
                return RouteElementIdentifier.init("Tabs")
            }
        }
        case Palette
        case EditSource
        case FontName
        public static func identifier() -> RouteElementIdentifier{
            return RouteElementIdentifier.init("Settings")
        }
    }
 
    case Login
}

class RootRoutable: Routable{
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func changeRouteSegment(_ from: RouteElementIdentifier, to: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        print("changeRouteSegment from \(from) to \(to)")
        fatalError("XXXX????")
    }
    
    func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
        // TODO: this should technically never be called -> bug in router
        completionHandler()
    }
    
    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        if InAppRoute.Settings.identifier() == routeElementIdentifier {
            completionHandler()
            let it = SettingsNavViewController()
            window.rootViewController = it
            return it as Routable
        }else{
            fatalError("Route \(routeElementIdentifier.description) not supported!")
        }
    }
}
