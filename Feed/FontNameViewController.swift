//
//  FontNameViewController.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/27.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit
import YFIconFont
import SwiftTheme

extension FontNameViewController: Routable{
    static var URL: String {
        return appRoute(path: "/settings/fontName")
    }
}

fileprivate class FontNameCell: UITableViewCell{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .default
        selectedBackgroundView = UIView(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(forFontName name: String, isSelected checked: Bool){
        textLabel?.text = name
        accessoryType = checked ? .checkmark : .none
        textLabel?.updateScaledFont(forFontName: name, forFontStyle: .body)
    }
}

class FontNameViewController: UITableViewController {
    
    public static let ARGS_COMPLETION = "completion"
    public static let ARGS_FONT_NAME = "font_name"
    
    fileprivate var completion: ((_:String?) -> Void)? = nil
    
    fileprivate var sourceFontName:String?
    
    convenience init(fontName: String?, completion: ((_:String?) -> Void)?){
        self.init(nibName: nil, bundle: nil)
        self.sourceFontName  = fontName
        self.selectedFontName  = fontName
        self.completion = completion
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavgationBar()
        
        clearsSelectionOnViewWillAppear = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        register(tableView, cell: FontNameCell.self)
        
    }
    
    fileprivate let fontNames = ["System", "Noteworthy"]
    
    fileprivate var selectedFontName: String? = nil
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontNames.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeue(tableView, cell: FontNameCell.self, indexPath: indexPath)
        let fontName = fontNames[indexPath.row]
        let selected = fontName == selectedFontName
        cell.bind(forFontName: fontName, isSelected: selected)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if fontNames[indexPath.row] != selectedFontName{
            selectedFontName = fontNames[indexPath.row]
            tableView.reloadData()
        }
    }
}

extension FontNameViewController{
    fileprivate func setupNavgationBar() -> Void{
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        let done = UIBarButtonItem(barButtonSystemItem: .done,target: self, action: #selector(FontNameViewController.onDone))
        navigationItem.leftBarButtonItem = done
        navigationItem.title = "FontName"
    }
    
    @objc dynamic func onDone(){
        if selectedFontName != sourceFontName{
            completion?(selectedFontName)
        }
       navigationController?.popViewController(animated: true)
    }
}





