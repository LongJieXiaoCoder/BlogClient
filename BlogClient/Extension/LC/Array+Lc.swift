//
//  Array+Lc.swift
//  BlogClient
//
//  Created by Long on 2020/5/9.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

extension Array: ArrayType, LCCompatible {}
extension NSArray: ArrayType {}

extension LC where Base: ArrayType {
    func objectAtIndex(_ index: Int) -> Any? {
        let arr = base as! [Any]
        if (arr.startIndex..<arr.endIndex).contains(index) {
            return arr[index]
        }
        return nil
    }
    
    func isValidIndex(_ index: Int) -> Bool {
        let arr = base as! [Any]
        if index > arr.count - 1 || index < 0 { return false }
        return true
    }
}

