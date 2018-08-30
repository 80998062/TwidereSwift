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

class SettingsTabViewController: TabmanViewController{
    fileprivate let tabRoutes = InAppRoute.Settings.Tabs.allValues.map{ $0.rawValue }
    fileprivate lazy var tabItemProvider: TabItemsProvider =
        TabItemsProvider(context: self)
    
    //    fileprivate var primaryItem: InAppRoute.Settings? = nil
    //
    //    init(primaryItem routeElementIdentifier: RouteElementIdentifier?) {
    //        super.init(nibName: nil, bundle: nil)
    //        if let it = routeElementIdentifier{
    //            primaryItem = InAppRoute.Settings(rawValue: it)
    //        }
    //    }
    
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

extension SettingsTabViewController{
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func setupBarButtons(){
        self.navigationItem.title = "Settings"
        let icon = UIImage.iconFont(imageSize: .icon_nav, icon: FontAwesome.close)
        let close = UIBarButtonItem(image: icon, style: .done, target: self, action: #selector(SettingsTabViewController.onBackPress))
        self.navigationItem.leftBarButtonItem = close
    }
    
    @objc dynamic func onBackPress(){
        print("嘤嘤嘤")
        let route = [InAppRoute.Settings.identifier(),
                     InAppRoute.Settings.Tabs.identifier(),
                     InAppRoute.Settings.Tabs.Cards.rawValue]
        appStore.dispatch(ReSwiftRouter.SetRouteAction(route))
    }
}



extension SettingsTabViewController: PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        bar.items = tabItemProvider.items
        let it = tabItemProvider.viewControllers.count
        return it
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        let route = [InAppRoute.Settings.identifier(),
                     InAppRoute.Settings.Tabs.identifier(),
                     tabRoutes[index]]
        appStore.dispatch(ReSwiftRouter.SetRouteAction(route))
        return tabItemProvider.viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        //        if primaryItem == nil {
        //            return .first
        //        }else{
        //            if let it = InAppRoute.Settings.allValues.index(of: primaryItem!){
        //                return PageboyViewController.Page.at(index: it)
        //            }else{
        //                return .first
        //            }
        //        }
        return .first
    }
    
}

extension SettingsTabViewController: Routable{
    
    func changeRouteSegment(_ from: RouteElementIdentifier, to: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        print("changeRouteSegment from \(from) to \(to)")
        guard let index = tabRoutes.index(of: to) else {
            fatalError("Route \(to.description) not supported!")
        }
        completionHandler()
        return tabItemProvider.viewControllers[index] as! Routable
        
    }
    
    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        print("pushRouteSegment  \(routeElementIdentifier) ")
        guard let index = tabRoutes.index(of: routeElementIdentifier)else {
            fatalError("Route \(routeElementIdentifier.description) not supported!")
        }
        completionHandler()
        return tabItemProvider.viewControllers[index] as! Routable
        
    }
    
    
    func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
        completionHandler()
    }
}




