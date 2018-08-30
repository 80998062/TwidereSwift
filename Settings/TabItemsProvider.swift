//
//  TabItemsProvider.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/18.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import YFIconFont
import Tabman
import ReSwiftRouter

class TabItemsProvider {
    
    public let viewControllers: [UIViewController]
    
    typealias Item = TabmanBar.Item
    public let items: [Item]
    
    private let context: Any?
    
    init(context: Any?) {
        self.context = context
      
        self.items = InAppRoute.Settings.Tabs.allValues.map{ route in
            Item(title: route.rawValue,
                 image: UIImage.iconFont(imageSize: .icon_nav, icon: FontAwesome.github), context: context)
        }
        
        self.viewControllers = InAppRoute.Settings.Tabs.allValues.map{ route in
            switch route{
            case InAppRoute.Settings.Tabs.Theme:
                return ThemeViewController()
            case InAppRoute.Settings.Tabs.Cards:
                return CardsViewController()
            case InAppRoute.Settings.Tabs.Sources:
                return SourceViewController()
            default:
                return RoutableViewController()
            }
        }
    }
}

class RoutableViewController: UIViewController,Routable{
    
}
