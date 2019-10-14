//
//  FontNameCell.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/9/5.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit

class SelectedFontCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: reuseIdentifier)
        selectedBackgroundView = UIView(frame: CGRect.zero)
        accessoryType = .disclosureIndicator
        detailTextLabel?.theme_textColor = "Text.colorSecondary"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(fontName aName: String?){
        textLabel?.text = "FontName".localized()
        detailTextLabel?.text = aName
    }
}