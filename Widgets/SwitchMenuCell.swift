//
//  SwitchMenuCell.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/17.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit

public class SwitchMenuCell: UITableViewCell {

    private var toggle: UISwitch = {
        let it = UISwitch(frame: CGRect.zero)
        it.isOn = false
        return it
    }()
    
    private let maxWidth = UIScreen.main.bounds.width * 0.75
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectedBackgroundView = UIView(frame: CGRect.zero)
        accessoryView = toggle
        textLabel?.numberOfLines = 1
        textLabel?.lineBreakMode = .byTruncatingMiddle
        detailTextLabel?.numberOfLines = 1
        detailTextLabel?.lineBreakMode = .byTruncatingMiddle
        textLabel?.snp.makeConstraints{(make) -> Void in
            make.width.lessThanOrEqualTo(maxWidth)
        }
        detailTextLabel?.snp.makeConstraints{(make) -> Void in
            make.width.lessThanOrEqualTo(maxWidth)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(title: String, subTitle: String?, isOn: Bool){
        textLabel?.text = title
        if let it = subTitle{
            detailTextLabel?.text = it
        }else{
            detailTextLabel?.text  = nil
        }
        
        toggle.isOn = isOn
    }
}
