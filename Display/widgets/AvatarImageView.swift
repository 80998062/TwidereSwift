//
//  AvatarImageView.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/21.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit

class AvatarImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        layer.cornerRadius = frame.width / 2
        contentMode = .scaleAspectFit
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
