//
//  AccountCell.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/23.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import IconFont
import SwiftTheme
import SnapKit

class SourceCell: UITableViewCell {
    
    private lazy var avatarImageView: AvatarImageView = {
        let it = AvatarImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        return it
    }()
    
    private lazy var screenNameLabel: UILabel = {
        let it = UILabel(frame: CGRect.zero)
        it.theme_textColor = "Text.colorPrimary"
        it.updateScaledFont(nil, .footnote)
        it.theme_backgroundColor = "List.itemBackground"
        it.sizeToFit()
        return it
    }()
    
    private lazy var idLabel: UILabel = {
        let it = UILabel(frame: CGRect.zero)
        it.theme_textColor = "Text.colorSecondary"
        it.updateScaledFont(nil, .caption1)
        it.theme_backgroundColor = "List.itemBackground"
        it.sizeToFit()
        return it
    }()
    
    private let verticalPadding = CGFloat(12)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectedBackgroundView = UIView(frame: CGRect.zero)        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(screenNameLabel)
        contentView.addSubview(idLabel)
        
        avatarImageView.snp.makeConstraints{(make) -> Void in
            make.width.height.equalTo(24)
            make.left.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        screenNameLabel.snp.makeConstraints{(make) -> Void in
            make.top.equalToSuperview().inset(verticalPadding)
            make.left.equalTo(avatarImageView.snp.right).offset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        idLabel.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(screenNameLabel.snp.bottom).offset(2)
            make.bottom.equalToSuperview().inset(verticalPadding)
            make.left.equalTo(screenNameLabel.snp.left)
            make.right.equalTo(screenNameLabel.snp.right)
        }
    }
    
    fileprivate lazy var placeholder: UIImage = {
         return UIImage.iconFont(imageSize: .icon_avatar_small, icon: FontAwesome.usercircle, color: ThemeManager.color(for: "Control.colorNormal"))
    }()
    
    
    func bind(screenName: String, id: String,urlFor avatar: String?){
        screenNameLabel.text = screenName
        idLabel.text = id
        if avatar == nil {
            avatarImageView.image = placeholder
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
