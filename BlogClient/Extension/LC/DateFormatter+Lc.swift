//
//  DateFormatter+Lc.swift
//  BlogClient
//
//  Created by Long on 2023/2/22.
//  Copyright © 2023 LongMac. All rights reserved.
//

import Foundation

extension DateFormatter: LCCompatible {}

extension LC where Base: DateFormatter {
    static func formatString(_ format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(secondsFromGMT: 8*3600)
        formatter.locale = Locale(identifier: "zh_CN")
        return formatter
    }
}
