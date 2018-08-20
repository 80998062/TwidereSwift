//
//  OptionMenuProtocol.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/8/18.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

enum `Type`: String{
    typealias RawValue = String
    case Products, Venues, Reviews, Users
}

protocol OptionViewProtocol {
    var type: Type! { get }
}
