//
//  MockOptionViewController.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/18.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import SnapKit

class MockOptionViewController: UITableViewController, OptionViewProtocol {
    var type: Type!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let size = UIScreen.main.bounds.width / 2
        let it = UILabel(frame: CGRect(x: 0, y: 0, width: size, height: size))
        it.backgroundColor = UIColor.random()
        it.textColor = UIColor.random()
        it.font = UIFont.boldSystemFont(ofSize: 36)
        it.text = self.type.rawValue
        it.sizeToFit()
        it.textAlignment = .center
        view.addSubview(it)
        it.snp.makeConstraints{(make) -> Void in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
