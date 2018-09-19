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
import Tabman
import Pageboy
import ReSwift



class SettingsTabViewController: TabmanViewController{
    
    fileprivate lazy var tabItemProvider: TabItemsProvider =
        TabItemsProvider(context: self)
    
    public var primaryIndex:Int = 0
    
    convenience init(forPrimaryItem index: Int?){
        self.init(nibName: nil, bundle: nil)
        if index != nil{
            primaryIndex = index!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isInfiniteScrollEnabled = false
        isScrollEnabled = false
        setupBarButtons()
        bar.appearance = TabmanBar.Appearance({ (it) in
            customize(it)
            theming(it)
        })
        NotificationCenter.default.addObserver(self, selector: #selector(self.didThemeSwitched), name:  NSNotification.Name(rawValue: ThemeUpdateNotification), object: nil)
        dataSource = self
    }
    
}

extension SettingsTabViewController: ThemeObserver{
    @objc dynamic func didThemeSwitched() {
        bar.appearance = TabmanBar.Appearance({ (it) in
            customize(it)
            theming(it)
        })
    }
    
    func customize(_ appearance: TabmanBar.Appearance?) -> Void {
        appearance?.indicator.isProgressive = true
        appearance?.indicator.bounces  = true
        appearance?.indicator.lineWeight = .thick
        appearance?.interaction.isScrollEnabled = true
        appearance?.layout.itemVerticalPadding = 15.0
        appearance?.layout.interItemSpacing = 20.0
        appearance?.layout.edgeInset = 15.0
        appearance?.style.showEdgeFade = true
    }
    
    func theming(_ appearance: TabmanBar.Appearance?) -> Void {
        appearance?.indicator.color = ThemeManager.color(for: "Theme.colorAccent")
        appearance?.state.selectedColor = ThemeManager.color(for: "Control.colorNormal")
        appearance?.state.color = ThemeManager.color(for: "Control.colorDisable")
        appearance?.style.background = .solid(color: ThemeManager.color(for: "Theme.colorLight")!)
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



extension SettingsTabViewController: PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        bar.items = tabItemProvider.items
        let it = tabItemProvider.viewControllers.count
        return it
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return tabItemProvider.viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .at(index: primaryIndex)
    }
    
}






