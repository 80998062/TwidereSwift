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

enum `Type`: String{
    typealias RawValue = String
    case Products, Venues, Reviews, Users
    static let allValues = [Products, Venues, Reviews, Users]
}


fileprivate let iconMap: [Type:IconFontType] = [
    Type.Products: FontAwesome.github,
    Type.Venues: FontAwesome.github,
    Type.Users: FontAwesome.github,
    Type.Reviews: FontAwesome.github,]

class TabItemsProvider {
    
    public let viewControllers: [UIViewController]
    
    typealias Item = TabmanBar.Item
    public let items: [Item]
    
    private let context: Any?
    
    init(context: Any?) {
        self.context = context
        self.viewControllers = {
            let productsViewController = ThemeViewController()
            let venuesViewController = FeedDisplayViewController()
            let reviewsViewController = SourceViewController()
            let usersViewController = MockOptionViewController()
            
            return [productsViewController, venuesViewController, reviewsViewController, usersViewController]
        }()
        
        
        self.items = Type.allValues.map{ type in
            Item(title: type.rawValue,
                 image: UIImage.iconFont(imageSize: .icon_nav, icon: FontAwesome.github), context: context)
        }
    }
    

}
