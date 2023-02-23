//
//  FileHandler.swift
//  BlogClient
//
//  Created by Long on 2020/5/11.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

class FileHandler {
    static let shareInstance: FileHandler = FileHandler.init()
    private init() {
        
    }
    
    func storeData(_ object: Any, to filePath : String) -> Bool {
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: true) else { return false }
        guard let _ = try? data.write(to: URL(fileURLWithPath: filePath), options: .atomicWrite) else { return false }
        return true
    }
    
    func readData(from filePath: String) -> Data? {
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else { return nil }
        return data
    }
}
