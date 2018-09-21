//
//  SettingsViewController.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/16.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import SnapKit
import IconFont
import SwiftTheme
import ReSwift



class SettingsTabViewController: UIPageViewController, UIPageViewControllerDelegate{
    
    fileprivate let tabItemProvider = TabItemsProvider(context: self)

    private var primaryIndex:Int = 0
    
    convenience init(forPrimaryItem index: Int?){
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        if index != nil{
            primaryIndex = index!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButtons()
        dataSource = self
        delegate = self
        setViewControllers([tabItemProvider.viewControllers[primaryIndex]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }
    
}


extension SettingsTabViewController: StoreSubscriber{
    typealias StoreSubscriberStateType = Any?
    
    func newState(state: Any?) {
        
    }
    
}

extension SettingsTabViewController{
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func setupBarButtons(){
        self.navigationItem.title = "Settings"
        let icon = UIImage.iconFont(imageSize: .icon_nav, icon: FontAwesome.close)
        let close = UIBarButtonItem(image: icon, style: .done, target: self, action: #selector(SettingsTabViewController.onBackPress))
//        self.navigationItem.leftBarButtonItem = close
    }
    
    @objc dynamic func onBackPress(){
        
    }
}



extension SettingsTabViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = tabItemProvider.viewControllers.firstIndex(of: viewController), index < tabItemProvider.viewControllers.endIndex {
            return tabItemProvider.viewControllers[index + 1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = tabItemProvider.viewControllers.firstIndex(of: viewController), index > 0 {
            return tabItemProvider.viewControllers[index - 1]
        }
        return nil
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return primaryIndex
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return tabItemProvider.viewControllers.count
    }
    
}






