//
//  StaticFeedCell.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/21.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import YFIconFont
import SwiftTheme

class StaticFeedCell: UITableViewCell, ThemeObserver{
    
    @objc dynamic func didThemeSwitched() {
        avatar.image = UIImage.iconFont(imageSize: .icon_avatar, icon: FontAwesome.usercircle, color: ThemeManager.color(for: "Control.colorDisable"))
    }
    
    private lazy var avatar: AvatarImageView = {
        let it = AvatarImageView(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
        it.theme_backgroundColor = "Control.colorHighlight"
        it.image = UIImage.iconFont(imageSize: .icon_avatar, icon: FontAwesome.usercircle, color: ThemeManager.color(for: "Control.colorDisable"))
        return it
    }()
    
    private lazy var screenName: ScreenNameLabel = {
        let it = ScreenNameLabel(frame: CGRect.zero)
        it.text = "Sinyuk"
        it.theme_textColor = "Text.colorPrimary"
        it.theme_backgroundColor = "List.itemBackground"
        it.sizeToFit()
        return it
    }()
    
    private lazy var idLabel: IdLabel = {
        let it = IdLabel(frame: CGRect.zero)
        it.theme_textColor = "Text.colorSecondary"
        it.theme_backgroundColor = "List.itemBackground"
        it.text = "@Sinyuk7 · 11m"
        it.sizeToFit()
        return it
    }()
    
    private lazy var dropdown: IdLabel = {
        let it = IdLabel(frame: CGRect.zero)
        it.iconFont(size: screenName.font.pointSize, icon: FontAwesome.chevrondown,color: ThemeManager.color(for: "Control.colorNormal"))
        return it
    }()
    
    private lazy var contentTextView: ContentTextView = {
        let it = ContentTextView(frame: CGRect.zero)
        it.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed at metus in mauris fermentum laoreet ac a mi. Pellentesque commodo efficitur lacus, vitae interdum nunc tempus sed. "
         it.theme_textColor = "Text.colorPrimary"
         it.theme_backgroundColor = "List.itemBackground"
         it.lineBreakMode = .byWordWrapping
         it.numberOfLines = 0
        it.sizeToFit()
        return it
    }()
    
    private lazy var head: UIStackView = {
        let it = UIStackView(frame: CGRect.zero)
        it.alignment = .bottom
        it.axis = .horizontal
        it.distribution = .fill
        it.spacing = 8
        return it
    }()
    
    
    private lazy var rightStack: UIStackView = {
        let it = UIStackView(frame: CGRect.zero)
        it.alignment = .fill
        it.distribution = .fill
        it.axis = .vertical
        it.spacing = 8
        return it
    }()
    
    private let padding: CGFloat = CGFloat(20)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectedBackgroundView = UIView(frame: CGRect.zero)
        contentView.addSubview(avatar)
        avatar.snp.makeConstraints{(maker) -> Void in
            maker.width.height.equalTo(48)
            maker.top.equalToSuperview().inset(padding)
            maker.left.equalToSuperview().inset(padding)
        }
        head.addArrangedSubview(screenName)
        head.addArrangedSubview(idLabel)
        head.addArrangedSubview(dropdown)
        
        rightStack.addArrangedSubview(head)
        head.snp.makeConstraints{(maker) -> Void in
            maker.width.equalToSuperview()
        }
        
        rightStack.addArrangedSubview(contentTextView)
        contentTextView.snp.updateConstraints{(maker) -> Void in
            maker.width.equalToSuperview()
        }
        
        contentView.addSubview(rightStack)
        rightStack.snp.updateConstraints{(maker) -> Void in
            maker.left.equalTo(avatar.snp.right).offset(15)
            maker.right.top.bottom.equalToSuperview().inset(padding)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didThemeSwitched), name:  NSNotification.Name(rawValue: ThemeUpdateNotification), object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
