//
//  ThemeCell.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/9/19.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import IconFont
import CC
import Localize

class ThemeCell: UITableViewCell {
    private lazy var palette: UIStackView = {
        let it = UIStackView(frame: CGRect.zero)
        it.alignment = .fill
        it.distribution = .fillEqually
        it.spacing = 0
        it.axis = .horizontal
        return it
    }()
    
    private lazy var themeLabel: UILabel = {
        let it = UILabel(frame: CGRect.zero)
        it.numberOfLines = 1
        it.textAlignment = .left
        it.lineBreakMode = .byTruncatingTail
        it.updateScaledFont(nil, .subheadline)
        it.sizeToFit()
        return it
    }()
    
    private let cellHeight = CGFloat(20)
    private let cellWidth = CGFloat(32)
    
    private lazy var clipView: UIView = {
        let it = UIView(frame: CGRect.zero)
        it.backgroundColor = UIColor.clear
        it.layer.cornerRadius = 4
        it.layer.borderWidth = 0.5
        it.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        it.layer.masksToBounds = true // it.clipsToBounds = true
        return it
    }()
    
    private lazy var paletteIcon: UIImageView = {
        let it = UIImageView(frame: CGRect.zero)
        it.contentMode = .scaleAspectFit
        it.translatesAutoresizingMaskIntoConstraints = false
        let size = CGSize(width: 18, height: 18)
        it.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        it.image = UIImage.iconFont(imageSize: size, icon: FontAwesome.eyedropper)
        return it
    }()
    
    public lazy var checkbox: SnapchatCheckbox = {
        let it = SnapchatCheckbox(frame: CGRect.init(x: 0, y: 0, width: 24, height: 24))
//
        it.frame(forAlignmentRect: CGRect.init(x: 0, y: 0, width: 24, height: 24))
        return it
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // common setup
        selectedBackgroundView = UIView(frame: CGRect.zero)
        selectionStyle = .none
        // end
        contentView.addSubview(themeLabel)
        contentView.addSubview(clipView)
        contentView.addSubview(paletteIcon)
        clipView.addSubview(palette)
        
        themeLabel.snp.makeConstraints{(make) -> Void in
            make.left.right.top.equalToSuperview().inset(15)
        }
        
        paletteIcon.snp.makeConstraints{(make) -> Void in
            make.height.width.equalTo(18)
            make.top.equalTo(themeLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(15)
        }
        
        clipView.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(0)
            make.height.equalTo(cellHeight)
            make.top.equalTo(themeLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(15)
            make.left.equalTo(paletteIcon.snp.right).offset(12)
        }
        
        palette.snp.makeConstraints{(make) -> Void in
            make.edges.equalTo(clipView)
        }
        
        checkbox.addTarget(self, action: #selector(self.onChecked(_:)), for: .valueChanged)
        accessoryView = checkbox
    }
    
    @objc dynamic private func onChecked(_ sender: SnapchatCheckbox){
        checkbox.isEnabled = !sender.isChecked // to simulate radio button
        checkboxListener?(sender)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// bind
    ///
    /// - Parameters:
    ///   - theme: theme
    ///   - colors: palette colors
    ///   - selector: checkbox listener
    public func bind(_ theme: AppTheme,_ colors: [UIColor],_ selected: Bool) -> Void{
        themeLabel.text = theme.rawValue.localized()
        notidyPaletteCellCountChanged(colors.count)
        assert(colors.count == palette.subviews.count,
               "Palette has \(palette.subviews.count) subviews while \(colors.count) colors")
        for e in palette.subviews.enumerated(){
            e.element.backgroundColor = colors[e.offset]
        }
        
        if selected != checkbox.isChecked{
            checkbox.setChecked(selected, animated: true)
            checkbox.isEnabled = !selected // to simulate radio button
        }
    }
    
    private func notidyPaletteCellCountChanged(_ count: Int){
        if palette.subviews.count == count{
            return
        }else {
            clipView.snp.updateConstraints{(make) -> Void in
                let width = CGFloat(count) * cellWidth
                make.width.equalTo(width)
            }
            
            palette.snp.updateConstraints{(make) -> Void in
                make.edges.equalTo(clipView)
            }
            
            if(palette.subviews.count > count){
                let start = count - 1
                for i in start..<palette.subviews.count{
                    palette.subviews[i].removeFromSuperview()
                }
            }else{
                let increasement =  count - palette.subviews.count
                for _ in 0..<increasement{
                    appendNewColor()
                }
            }
        }
    }
    
    /// create new palette cell
    ///
    /// - Returns: cell
    private func appendNewColor() -> Void{
        let it = UIView(frame: CGRect.zero)
        it.backgroundColor = UIColor.clear
        it.translatesAutoresizingMaskIntoConstraints = false
        palette.addArrangedSubview(it)
    }
    
    public var checkboxListener: ((SnapchatCheckbox) -> ())?
}
