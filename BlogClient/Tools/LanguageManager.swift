//
//  LanguageManager.swift
//  BlogClient
//
//  Created by LongMac on 2023/2/18.
//  Copyright © 2023 LongMac. All rights reserved.
//

import Foundation
class LanguageManager {
    var appLanguage: Array = ["zh-Hans"]
    
    public static let share = LanguageManager.init()

    private init() {}
}
