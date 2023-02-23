//
//  extension.swift
//  BlogClient
//
//  Created by Long on 2020/4/29.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

class LC<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

protocol LCCompatible {}
extension LCCompatible {
    var lc: LC<Self> {
        set {}
        get { LC(self) }
    }
    static var lc: LC<Self>.Type {
        set {}
        get { LC<Self>.self }
    }
}




