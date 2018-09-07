//
//  FontNameCell.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/9/5.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit

class SelectedFontCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.value1, reuseIdentifier: reuseIdentifier)
        selectedBackgroundView = UIView(frame: CGRect.zero)
        accessoryType = .disclosureIndicator
        textLabel?.text = "FontName"
        detailTextLabel?.theme_textColor = "Text.colorSecondary"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var fontName: String?{
        didSet{
            detailTextLabel?.text = fontName
        }
    }

}
