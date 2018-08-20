//
//  TabItemsProvider.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/18.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import ColorMatchTabs
import YFIconFont

class TabItemsProvider {
    static let mockImage = UIImage.iconFont(imageSize: .icon_nav, icon: FontAwesome.github)
    static let items = {
        return [
            TabItem(
                title: "Products",
                tintColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),
                normalImage: mockImage,
                highlightedImage: mockImage
            ),
            TabItem(
                title: "Places",
                tintColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),
                normalImage: mockImage,
                highlightedImage: mockImage
            ),
            TabItem(
                title: "Reviews",
                tintColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),
                normalImage: mockImage,
                highlightedImage: mockImage
            ),
            TabItem(
                title: "Friends",
                tintColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),
                normalImage: mockImage,
                highlightedImage: mockImage
            )
        ]
    }()
    
}
