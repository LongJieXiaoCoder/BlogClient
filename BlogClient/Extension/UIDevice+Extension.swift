//
//  UIDevice+Extension.swift
//  BlogClient
//
//  Created by Long on 2023/2/17.
//  Copyright © 2023 LongMac. All rights reserved.
//

import Foundation

extension UIDevice {
    static func deviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String.init(validatingUTF8: ptr)
            }
        }
        print("deviceModel = \(modelCode!)")
        return modelCode ?? ""
    }
}
