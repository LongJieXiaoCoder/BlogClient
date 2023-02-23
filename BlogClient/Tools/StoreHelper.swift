//
//  StoreHandler.swift
//  BlogClient
//
//  Created by Long on 2020/5/14.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

// MARK: - UserDefault存储和读取
struct StoreHelper {
    // 保存数据到UserDefault、重置数据
    static func storeValue(_ value: Any?, forKey: String) -> Void {
        let key = "\(kAppBundleIdentifier)+.\(forKey)"
        if value == nil {
            UserDefaults.standard.removeObject(forKey: key)
        } else {
            UserDefaults.standard.set(value, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    // 读取UserDefault数据
    static func valueForKey(_ key: String) -> Any? {
        let realKey = "\(kAppBundleIdentifier)+.\(key)"
        return UserDefaults.standard.value(forKey: realKey)
    }
}

// MARK: - model的存储和读取
extension StoreHelper {
    @discardableResult
    static func write<T: Codable>(_ value: T,
                                  to file: String,
                                  atomically: Bool = true,
                                  encoding: String.Encoding = .utf8) -> Bool {
        return write(value, to: URL(fileURLWithPath: file), encoding: encoding)
    }

    @discardableResult
    public static func write<T: Codable>(_ value: T,
                                          to URL: URL,
                                          atomically: Bool = true,
                                          encoding: String.Encoding = .utf8) -> Bool  {
        if URL.isFileURL {
            let dir = (URL.path as NSString).deletingLastPathComponent
            let mgr = FileManager.default
            if !mgr.fileExists(atPath: dir) {
                guard let _ = try? mgr.createDirectory(atPath: dir,
                                                            withIntermediateDirectories: true,
                                                            attributes: nil) else {
                    return false
                }
            }
        }
        
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(value) else {
            return false
        }
        
        do {
            try data.write(to: URL)
        } catch {
            return false
        }
        
        return true
    }

    public static func read<T: Codable>(_ type: T.Type,
                        from file: String,
                        encoding: String.Encoding = .utf8) -> T? {
        return read(type,
                    from: URL(fileURLWithPath: file),
                    encoding: encoding)
    }

    public static func read<T: Codable>(_ type: T.Type,
                        from URL: URL,
                        encoding: String.Encoding = .utf8) -> T? {
        guard let data = try? Data(contentsOf: URL) else { return nil }
        
        let decoder = JSONDecoder()
        guard let model = try? decoder.decode(type, from: data) else { return nil }
        return model
    }
}
