//
//  SourceEdit+Ext.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/24.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import PopMenu
import SwiftTheme
import IconFont

class TextFieldCell: UITableViewCell{
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public lazy var textField: KaedeTextField = {
        let it = KaedeTextField()
        it.placeholderColor = ThemeManager.color(for: "Text.colorSecondary")
        it.foregroundColor = ThemeManager.color(for: "List.itemBackground")
        it.backgroundColor = ThemeManager.color(for: "List.colorSeperator")
        it.clearButtonMode = .never
        return it
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectedBackgroundView = UIView(frame: .zero)
        contentView.addSubview(textField)
        textField.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(44)
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
}

/// UITableViewCell which show a popup menu when being clicked
class PopMenuCell: UITableViewCell{
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var icon: UIImage = UIImage.iconFont(imageSize: .icon_menu, icon: FontAwesome.edit)
    
    public lazy var indicator: UIImageView = {
        let it = UIImageView(image: icon)
        it.translatesAutoresizingMaskIntoConstraints = false
        return it
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectedBackgroundView = UIView(frame: CGRect.zero)
        accessoryView = indicator
    }
    
}
