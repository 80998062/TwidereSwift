//
//  SettingsViewController+Ext.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/23.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import ReSwiftRouter
import ReSwift

class SettingsNavViewController: UINavigationController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.prefersLargeTitles = false
        self.navigationBar.isTranslucent = false
        self.setToolbarHidden(true, animated: false)
    }
}


extension SettingsNavViewController: Routable{
    func changeRouteSegment(_ from: RouteElementIdentifier, to: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        print("changeRouteSegment from \(from) to \(to)")
        switch to {
        case InAppRoute.Settings.FontName.rawValue:
            let it = FontNameViewController()
            pushViewController(it, animated: true, completion: completionHandler)
            return it as Routable
            //        case InAppRoute.Settings.EditSource.rawValue:
        //        case InAppRoute.Settings.Palette.rawValue:
        default:
            fatalError("Route \(from.description) to \(to.description) not supported!")
        }
    }
    
    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        print("pushRouteSegment  \(routeElementIdentifier) ")
        switch routeElementIdentifier {
        case InAppRoute.Settings.FontName.rawValue:
            let it = FontNameViewController()
            pushViewController(it, animated: true, completion: completionHandler)
            return it as Routable
            //        case InAppRoute.Settings.EditSource.rawValue:
        //        case InAppRoute.Settings.Palette.rawValue:
        case InAppRoute.Settings.Tabs.identifier():
            let it = SettingsTabViewController()
            pushViewController(it, animated: false, completion: completionHandler)
            return it as Routable
        default:
            fatalError("Route \(routeElementIdentifier.description) not supported!")
        }
    }
    
    func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
        popViewController(true, completion: completionHandler)
    }
}
