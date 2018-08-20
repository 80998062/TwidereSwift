//
//  SettingsViewController.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/16.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import SnapKit
import YFIconFont
import ColorMatchTabs


class SettingsViewController: ColorMatchTabsViewController{
    
    override func viewDidLoad() {
        colorMatchTabDataSource = self
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        popoverViewController = RouterViewController()
        popoverViewController?.delegate = self
        reloadData()
    }
}


extension SettingsViewController: ColorMatchTabsViewControllerDataSource {
    
    func numberOfItems(inController controller: ColorMatchTabsViewController) -> Int {
        return TabItemsProvider.items.count
    }
    
    func tabsViewController(_ controller: ColorMatchTabsViewController, viewControllerAt index: Int) -> UIViewController {
        return OptionViewControllersProvider.viewControllers[index]
    }
    
    func tabsViewController(_ controller: ColorMatchTabsViewController, titleAt index: Int) -> String {
        return TabItemsProvider.items[index].title
    }
    
    func tabsViewController(_ controller: ColorMatchTabsViewController, iconAt index: Int) -> UIImage {
        return TabItemsProvider.items[index].normalImage
    }
    
    func tabsViewController(_ controller: ColorMatchTabsViewController, hightlightedIconAt index: Int) -> UIImage {
        return TabItemsProvider.items[index].highlightedImage
    }
    
    func tabsViewController(_ controller: ColorMatchTabsViewController, tintColorAt index: Int) -> UIColor {
        return TabItemsProvider.items[index].tintColor
    }
}

extension SettingsViewController: PopoverViewControllerDelegate {
    
    func popoverViewController(_ popoverViewController: PopoverViewController, didSelectItemAt index: Int) {
        print("didSelectItemAt \(index)")
        selectItem(at: index)
    }
}
