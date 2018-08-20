//
//  LayoutInflator.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/17.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit

public extension UILabel{
    
    public static func inflate(text: String?,font: UIFont?) -> UILabel{
        let it = UILabel()
        it.font = font == nil ? UIFont.systemFont(ofSize: 14)  : font
        it.translatesAutoresizingMaskIntoConstraints = false
        it.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        /// UILabel 的默认背景是透明的
        /// 而透明的视图为发生图层混合
        it.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        /// UILabel 显示中英文的时候存在差别，含有中文的 Label，
        /// 默认会创建一个透明 Content 的 Sublayer，同样会造成图层混合，
        /// 解决方式是设置 label.layer.masksToBounds 为 true。
        it.layer.masksToBounds = true
        if text != nil && text!.count > 0{
            it.text = text
            it.sizeToFit()
        }
        return it
    }
}
