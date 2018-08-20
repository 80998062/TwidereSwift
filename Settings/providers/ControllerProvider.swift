//
//  ControllerProvider.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/18.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import ColorMatchTabs

class OptionViewControllersProvider {
    
    static let viewControllers: [UIViewController] = {
        let productsViewController = ThemeViewController()
        productsViewController.type = .Products
        
        let venuesViewController = MockOptionViewController()
        venuesViewController.type = .Venues
        
        let reviewsViewController = MockOptionViewController()
        reviewsViewController.type = .Reviews
        
        let usersViewController = MockOptionViewController()
        usersViewController.type = .Users
        
        return [productsViewController, venuesViewController, reviewsViewController, usersViewController]
    
    }()
    
}
