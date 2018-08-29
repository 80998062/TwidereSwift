//
//  SourceEdit+Ext.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/24.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit

class UrlInputCell: UITableViewCell{
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var textField: UILabel = {
        let it = UILabel(frame: CGRect.zero)
//        it.placeholder = "https://[DOMAIN].twitter.com"
        it.theme_textColor = "Text.colorPrimary"
        return it
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(textField)
        textField.snp.makeConstraints{(make) -> Void in
            make.edges.equalToSuperview().inset(20)
        }
    }
}



/// <#Description#>
class AccountTypeCell: UITableViewCell{
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    public func bind(nameFor accountType: String){
        textLabel?.text = accountType
    }
}
