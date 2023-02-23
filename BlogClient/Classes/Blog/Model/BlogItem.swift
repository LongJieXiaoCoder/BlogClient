//
//  BlogItem.swift
//  BlogClient
//
//  Created by Long on 2020/5/19.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

struct BlogItemList: Codable {
    var blogList: [BlogItem]
}

struct BlogItem: Codable {
    var id: Int = 0
    var title: String = ""          // 博文编号
    var url: String = ""            // 标题
    var description: String = ""    // 博文的html链接
    var author: String = ""         // 作者
    var blogName: String = ""       // 博客名称
    var avatar: String = ""         // 头像url
    var postDate: Date = Date()     // 方便
    var viewCount: Int = 0          // 浏览数
    var commentCount: Int = 0       // 评论次数
    var diggCount: Int = 0          // 点击次数
    
    // 键值对应
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case title = "Title"
        case url = "Url"
        case description = "Description"
        case author = "Author"
        case blogName = "BlogApp"
        case avatar = "Avatar"
        case postDate = "PostDate"
        case viewCount = "ViewCount"
        case commentCount = "CommentCount"
        case diggCount = "DiggCount"
    }
}

//struct BlogItem: Convertible {
//    let id: Int = 0
//    let title: String = ""          // 博文编号
//    let url: String = ""            // 标题
//    let description: String = ""    // 博文的html链接
//    let author: String = ""         // 作者
//    let blogName: String = ""       // 博客名称
//    let avatar: String = ""         // 头像url
//    let postDate: Date = Date()     // 方便
//    let viewCount: Int = 0          // 浏览数
//    let commentCount: Int = 0       // 评论次数
//    let diggCount: Int = 0          // 点击次数
//
//    func kj_modelKey(from property: Property) -> ModelPropertyKey {
//        switch property.name {
//        case "id":
//            return "Id"
//        case "title":
//            return "Title"
//        case "url":
//            return "Url"
//        case "description":
//            return "Description"
//        case "author":
//            return "Author"
//        case "blogName":
//            return "BlogApp"
//        case "avatar":
//            return "Avatar"
//        case "postDate":
//            return "PostDate"
//        case "viewCount":
//            return "ViewCount"
//        case "commentCount":
//            return "CommentCount"
//        case "diggCount":
//            return "DiggCount"
//        default:
//            return ""
//        }
//    }
//
//    // "yyyy-MM-dd'T'HH:mm:ss.SSS Z"
//    func kj_modelValue(from jsonValue: Any?,
//                       _ property: Property) -> Any? {
//        if property.name == "postDate" {
//            if case .some(let value) = jsonValue {
//                if let date = "\(value)".lc.stringToDate(withFormat: "yyyy-MM-dd'T'HH:mm:SS") {
//                    return ConvertibleConfig.modelValue(from: date, property, Self.self)
//                }
//            }
//        }
//        return ConvertibleConfig.modelValue(from: jsonValue, property, Self.self)
//    }
//}


//    [
//    -{
//    "Id": 1,编号 <number>
//    "Title": "sample string 2",标题 <string>
//    "Url": "sample string 3",链接 <string>
//    "Description": "sample string 4",说明 <string>
//    "Author": "sample string 5",作者 <string>
//    "BlogApp": "sample string 6",博客名 <string>
//    "Avatar": "sample string 7",头像链接 <string>
//    "PostDate": "2017-06-25T20:11:47.0952592+08:00",发布时间 <string>
//    "ViewCount": 9,浏览次数 <number>
//    "CommentCount": 10,评论次数 <number>
//    "DiggCount": 11点击次数 <number>
//    }
//    ]

//{
//    "Id": 12812411,
//    "Title": "Kubernetes实战 - 从零开始搭建微服务 1 - 使用kind构建一个单层架构Node/Express网络应用程序",
//    "Url": "http://www.cnblogs.com/tim-unity/p/k8s-kind-get-started-to-deploy-an-express-app.html",
//    "Description": "使用kind构建一个单层架构Node/Express网络应用程序 Kubernetes实战 从零开始搭建微服务 1 前言 准备写一个Kubernetes实战系列教程，毕竟cnblogs作为国内最早的技术博客现在都已经开始迁移到Kubernetes了， 。系列会更加偏向于实战，对于理论只在需要时讲解。",
//    "Author": "Tim-",
//    "BlogApp": "tim-unity",
//    "Avatar": "https://pic.cnblogs.com/face/795737/20150808061942.png",
//    "PostDate": "2020-05-19T16:23:00",
//    "ViewCount": 50,
//    "CommentCount": 1,
//    "DiggCount": 1
//}
