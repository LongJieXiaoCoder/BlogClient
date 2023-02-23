//
//  Date+Lc.swift
//  BlogClient
//
//  Created by Long on 2020/5/20.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

extension Date: LCCompatible {}

extension LC where Base == Date {
    static var D_MINUTE: Double { 60 }   // 每分钟60秒
    static var D_HOUR:   Double { 3600 }
    static var D_DAY:    Double { 86400 }
    static var D_WEEK:   Double { 604800 }
    static var D_YEAR:   Double { 31556926 }
    
    var isToday: Bool {
        isEqualToDateIgnoringTime(date: Date())
    }
    
    var isYesterday: Bool {
        let yesterday = Self.dayBySubtractingDay(1)
        return isEqualToDateIgnoringTime(date: yesterday)
    }
    
    var isTomorrow: Bool {
        let tomorrow = Self.dayByAddingDay(1)
        return isEqualToDateIgnoringTime(date: tomorrow)
    }
    
    // MARK: - Static Method
    
    // 在当前时间基础上增加几天
    static func dayByAddingDay(_ days: Int) -> Date {
        let interval: TimeInterval = Date.timeIntervalSinceReferenceDate + D_DAY * Double(days)
        let date = Date.init(timeIntervalSinceReferenceDate: interval)
        return date;
    }
    
    // 在当前时间基础上减几天
    static func dayBySubtractingDay(_ days: Int) -> Date {
        Self.dayByAddingDay(days * -1)
    }
    
    // 在当前时间基础上增加几小时
    static func dayByAddingHours(_ hours: Int) -> Date {
        let interval = Date.timeIntervalSinceReferenceDate + D_HOUR * Double(hours)
        let date = Date.init(timeIntervalSinceReferenceDate: interval)
        return date
    }
    
    // 在当前时间基础上减几小时
    static func dayBySubtractingHours(_ hours: Int) -> Date {
        Self.dayByAddingHours(hours * -1)
    }
    
    // 在当前时间基础上增加几分钟
    static func dayByAddingMinutes(_ minutes: Int) -> Date {
        let interval = Date.timeIntervalSinceReferenceDate + D_MINUTE * Double(minutes)
        let date = Date.init(timeIntervalSinceReferenceDate: interval)
        return date
    }
    
    // 在当前时间基础上减几分钟
    static func dayBySubtractingMinutes(_ minutes: Int) -> Date {
        Self.dayByAddingMinutes(minutes * -1)
    }
    
    static func formatDateToString(_ date: Date, format: String) -> String {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        let formatStr = dateFormatter.string(from: date)
        return formatStr
    }
    
    
    
    static func timeAgoWithDate(_ date: Date) -> String {
        let deltaSeconds: TimeInterval = fabs(date.timeIntervalSinceNow)
        let deltaMinutes: TimeInterval = deltaSeconds / 60.0;
        
        var timeInfo = ""
        if deltaSeconds < 5 {
            timeInfo = R.string.localizable.justNow(preferredLanguages: kAppLanguage)
        } else if deltaSeconds < 60 {
            timeInfo = R.string.localizable.secondBefore(Int(ceil(deltaSeconds)), preferredLanguages: kAppLanguage)
        } else if deltaSeconds < 120 {
            timeInfo = R.string.localizable.minuteBefore(1, preferredLanguages: kAppLanguage)
        } else if deltaMinutes < 60 {
            timeInfo = R.string.localizable.minuteBefore(Int(ceil(deltaMinutes)), preferredLanguages: kAppLanguage)
        } else if deltaMinutes < 120 {
            timeInfo = R.string.localizable.hoursBefore(1, preferredLanguages: kAppLanguage)
        } else if deltaMinutes < (24 * 60) {
            timeInfo = R.string.localizable.hoursBefore(Int(floor(deltaMinutes/60)), preferredLanguages: kAppLanguage)
        } else if deltaMinutes < 2 * 24 * 60 {
            timeInfo = R.string.localizable.yesterdayTime(Self.formatDateToString(date, format: "HH:mm"), preferredLanguages: kAppLanguage)
        } else {
            timeInfo = Self.formatDateToString(date, format: "yyyy-MM-dd HH:mm")
        }
        
        return timeInfo
    }
    
    // MARK: - Instance Method
    
    // 判断时间是否相同，只精确到天
    func isEqualToDateIgnoringTime(date: Date) -> Bool {
        let calendar = Calendar.init(identifier: .gregorian)
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: base)
        let nowDateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        
        if dateComponents.year == nowDateComponents.year &&
            dateComponents.month == nowDateComponents.month &&
            dateComponents.day == nowDateComponents.day
        {
            return true
        }
        return false
    }
    
}
