//
//  FontSizeCell.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/21.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import SwiftTheme
import CC

fileprivate extension GMStepper{
    fileprivate func updateDecorations(){
        labelTextColor = ThemeManager.color(for: "Text.colorPrimary")!
        buttonsTextColor = ThemeManager.color(for: "Theme.colorLight")!
        buttonsBackgroundColor = ThemeManager.color(for: "Control.colorNormal")!
        labelBackgroundColor = ThemeManager.color(for: "Control.colorDisable")!
        limitHitAnimationColor = ThemeManager.color(for: "Control.colorHighlight")!
    }
}

class FontSizeCell: UITableViewCell,ThemeObserver{
    
    @objc dynamic func didThemeSwitched() {
        stepper.updateDecorations()
    }
    
    public lazy var stepper: GMStepper = {
        let it = GMStepper(frame: .zero)
        it.stepValue = 1
        it.value = 14
        it.minimumValue = 14
        it.maximumValue = 17
        it.leftButtonText = "aA"
        it.rightButtonText = "Aa"
        it.updateDecorations()
        return it
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectedBackgroundView = UIView(frame: CGRect.zero)
        contentView.addSubview(stepper)


        stepper.snp.makeConstraints{(maker) -> Void in
            maker.height.equalTo(24)
            maker.bottom.top.equalToSuperview().inset(20)
            maker.left.right.equalToSuperview().inset(20)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didThemeSwitched), name:  NSNotification.Name(rawValue: ThemeUpdateNotification), object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}