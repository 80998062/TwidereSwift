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
import Localize_Swift
import RxSwift

fileprivate enum Tabs : String, CaseIterable{
    typealias RawValue = String
    case login
    case theme
    case display
    case subscriptions
    case navigationBar
    case extensions
    case refresh
    case streaming
    case notifications
    case network
    case compose
    case content
    case storage
    case others
    case about
    case license
    
    func localized() -> String {
        return self.rawValue.localized()
    }
}

class TabItemsProvider {
    
    public let viewControllers: [UIViewController]
    
    typealias Item = TabmanBar.Item
    
    public let items: [Item]
    
    private let context: Any?
    
    init(context: Any?) {
        self.context = context
        self.items = Tabs.allValues.map{ route in
            Item(title: route.localized(),
                 image: UIImage.iconFont(imageSize: .icon_nav, icon: FontAwesome.github), context: context)
        }
        
        self.viewControllers = Tabs.allValues.map{ route in
            switch route{
            case .theme:
                return ThemeViewController()
            case .display:
                return DisplayViewController()
            case .subscriptions:
                return SourceViewController()
            default:
                return RoutableViewController()
            }
        }
    }
}

class RoutableViewController: UIViewController{
    
}
