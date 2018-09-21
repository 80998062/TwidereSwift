//
//  String+Ext.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/9/7.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

public extension String {
    /*
     Truncates the string to the specified length number of characters and appends an optional trailing string if longer.
     - Parameter length: Desired maximum lengths of a string
     - Parameter trailing: A 'String' that will be appended after the truncation.
     
     - Returns: 'String' object.
     */
    public func trunc(length: Int, trailing: String = "…") -> String {
        return (self.count > length) ? self.prefix(length) + trailing : self
    }
}
