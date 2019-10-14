//
//  Routes.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/9/14.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import ReSwiftRouter

func RouteNotFound(identifierFor route: RouteElementIdentifier? = nil) -> Never{
    fatalError("Route not found: \(String(describing: route))")
}

class RootRoutable: Routable {
    
    let window: UIWindow
    
    init(_ window: UIWindow) {
        self.window = window
    }
    
    func settings() -> Routable {
        let it = SettingsNavViewController()
        self.window.rootViewController = it
        return it
    }
    
    func login() ->  Routable{
        let it = SettingsNavViewController()
        self.window.rootViewController = it
        return it
    }
    
    func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
        // TODO: this should technically never be called -> bug in router
        completionHandler()
    }
    
    func changeRouteSegment(_ from: RouteElementIdentifier, to: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        switch to {
        case SettingsNavViewController.route():
            completionHandler()
            return settings()
        default:
            RouteNotFound(identifierFor: to)
        }
    }
    
    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        switch routeElementIdentifier {
        case SettingsNavViewController.route():
            completionHandler()
            return settings()
        default:
            RouteNotFound(identifierFor: routeElementIdentifier)
        }
    }
}


extension SettingsNavViewController: Routable{
    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        switch routeElementIdentifier {
        case SettingsTabViewController.route():
            let it = SettingsTabViewController(forPrimaryItem: 1)
            self.viewControllers = [it]
            completionHandler()
            return it
        case SignInViewController.route():
            let it = SignInViewController()
            self.viewControllers = [it]
            completionHandler()
            return it
        default:
            RouteNotFound(identifierFor: routeElementIdentifier)
        }
    }
    
}


extension SettingsTabViewController: Routable{
    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        switch routeElementIdentifier {
        case FontNameViewController.route():
            let it = FontNameViewController()
            self.navigationController?.pushViewController(it, animated: animated, completion: completionHandler)
            return it
        case EditSourceController.route():
            let it = EditSourceController()
            self.navigationController?.pushViewController(it, animated: animated, completion: completionHandler)
            return it
        default:
            RouteNotFound(identifierFor: routeElementIdentifier)
        }
    }
    
    func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
        switch routeElementIdentifier {
        case FontNameViewController.route(), EditSourceController.route():
            self.navigationController?.popViewController(true, completion: completionHandler)
        default:
            RouteNotFound(identifierFor: routeElementIdentifier)
        }
        
    }
}

extension FontNameViewController: Routable{}

extension EditSourceController: Routable{}

extension SignInViewController: Routable{}
