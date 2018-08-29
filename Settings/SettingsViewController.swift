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
import SwiftTheme
import Tabman
import Pageboy
import ReSwift
import ReSwiftRouter

class SettingsViewController: TabmanViewController{
    fileprivate lazy var tabItemProvider: TabItemsProvider =
        TabItemsProvider(context: self)
    
    private let fontName: String? = nil
    
    fileprivate lazy var scaledFont: ScaledFont = {
        return ScaledFont(fontName: fontName)
    }()
    
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
    
    override func pageboyViewController(_ pageboyViewController: PageboyViewController, didReloadWith currentViewController: UIViewController, currentPageIndex: PageboyViewController.PageIndex) {
    }
    
}

fileprivate extension SettingsViewController{
    
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
        appearance?.text.font = scaledFont.font(forTextStyle: .subheadline)
        appearance?.text.selectedFont = scaledFont.font(forTextStyle: .subheadline)
    }
}

extension SettingsViewController: StoreSubscriber{
    typealias StoreSubscriberStateType = Any?
    
    func newState(state: Any?) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appStore.subscribe(self){ state in
            state.select{ $0.navigationState }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        appStore.unsubscribe(self)
    }
    
}

extension SettingsViewController: ThemeObserver{
    @objc dynamic func didThemeSwitched() {
        bar.appearance = TabmanBar.Appearance({ (it) in
            customize(it)
            theming(it)
        })
    }
}

extension SettingsViewController: PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        bar.items = tabItemProvider.items
        let it = tabItemProvider.viewControllers.count
        assert(it == bar.items?.count)
        return it
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return tabItemProvider.viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .first
    }
    
}




