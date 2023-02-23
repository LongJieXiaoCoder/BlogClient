//
//  User.swift
//  BlogClient
//
//  Created by LongMac on 2020/5/16.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

struct User: Codable {
    var userId: String = ""             // 用户id
    var spaceUserId: Double = 0         // 用户显示名称id
    var blodId: Double = 0              // 博客id
    var displayName: String = ""        // 显示名称
    var faceUrl: String = ""            // 头像url
    var avatarUrl: String = ""          // 头像url
    var seniority: String = ""          // 园龄
    var blogName: String = ""           // 博客名称
    
    
    enum CodingKeys: String, CodingKey {
        case userId = "UserId"
        case spaceUserId = "SpaceUserId"
        case blodId = "BlodId"
        case displayName = "DisplayName"
        case faceUrl = "Face"
        case avatarUrl = "Avatar"
        case seniority = "Seniority"
        case blogName = "BlogApp"
    }
    
    
//    func kj_modelKey(from property: Property) -> ModelPropertyKey {
//        switch property.name {
//        case "userId":
//            return "UserId"
//        case "spaceUserId":
//            return "SpaceUserId"
//        case "blodId":
//            return "BlodId"
//        case "displayName":
//            return "DisplayName"
//        case "faceUrl":
//            return "Face"
//        case "avatarUrl":
//            return "Avatar"
//        case "seniority":
//            return "Seniority"
//        case "blogName":
//            return "BlogApp"
//        default:
//            return ""
//        }
//    }
    
    static func exist() -> Bool {
        guard let _ = StoreHelper.read(User.self, from: FilePath.userPath) else { return false }
        return true
    }
}

//{
//"UserId": "4566ea6b-f2b3",用户id <string>
//"SpaceUserId": 2,用户显示名称id <number>
//"BlogId": 3,博客id <number>
//"DisplayName": "sample string 4",显示名称 <string>
//"Face": "sample string 5",头像url <string>
//"Avatar": "sample string 6",头像url <string>
//"Seniority": "sample string 7",园龄 <string>
//"BlogApp": "sample string 8"博客名 <string>
//}
