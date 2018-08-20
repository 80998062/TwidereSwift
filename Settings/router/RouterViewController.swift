//
//  RouterViewController.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/19.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import ColorMatchTabs

class RouterViewController: PopoverViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setContentView()
    }
    
    private func setContentView(){
        let it = UIImageView()
        it.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        view.addSubview(it)
        it.snp.makeConstraints{(make) -> Void in
            make.edges.equalToSuperview().inset(15)
        }
    }
}
