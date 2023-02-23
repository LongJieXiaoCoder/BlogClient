//
//  API.swift
//  BlogClient
//
//  Created by Long on 2020/5/11.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

enum API {
    enum url {
        static let baseApiUrl = "https://api.cnblogs.com/api/"
        static let baseOauthUrl = "https://oauth.cnblogs.com/"
        
        // MARK: - 客户端授权
        static let connectToken = Self.oauthUrl("connect/token")
        static let connectAuthorize =  Self.oauthUrl("connect/authorize")
        
        // MARK: - 博客
        // 首页博文列表
        static let blogpostsSitehome = Self.url("blogposts/@sitehome")
        // 首页精华列表
        static let blogpostsPicked = Self.url("blogposts/@picked")
        
        // 根据博文id获取博文内容
        static func blogpostsBody(blogId: String) -> String {
            return Self.url("blogposts/\(blogId)/body")
        }
        
        // MARK: - 用户信息
        static let apiUsers = Self.url("users")

        
        // API
        static func url(_ path: String) -> String {
            baseApiUrl + path
        }
        
        // 认证授权
        static func oauthUrl(_ path: String) -> String {
            baseOauthUrl + path
        }
    }
    
    // 请求参数的Key  request parameter key
    enum rpk {
        static let grant_type = "grant_type"
        
        static let client_id = "client_id"
        static let client_secret = "client_secret"
        static let scope = "scope"
        static let response_type = "response_type"
        static let redirect_uri = "redirect_uri"
        static let state = "state"
        static let nonce = "nonce"
        
        static let code = "code"
        static let pageIndex = "pageIndex"
        static let pageSize = "pageSize"
    }

    // 请求参数的Value  request parameter value
    enum rpv {
        // client_id
        static let client_id = "f12f7276-f09d-4979-9288-6ba71b303fb6"
        // client_secret
        static let client_secret = "bN1ZviZgoC-IyYix-DlSuCjZ3KdixeJEkMdTVazfJA5D07R-nCxlGTFsEA4FLkq9o0C9_9k5D5Ea-qbv"
        static let client_credentials = "client_credentials"
        
        
        static let scope = "openid profile CnBlogsApi"
        static let response_type = "code id_token"
        static let redirect_uri = "https://oauth.cnblogs.com/auth/callback"
        static let state = "cnblogs.com"
        static let nonce = "cnblogs.com"
        
        static let grant_type_password = "password"
        static let grant_type_authorization_code = "authorization_code"
    
    }
}

// FilePath
enum FilePath {
    // Document 目录
    static var documentPath = NSHomeDirectory() + "/Documents"
    // 认证文件
    static let oauthFilePath = documentPath + "/client_credentials_oauth.json"
    static let userPath = documentPath + "/user.json"
    
}

//UniversalString
enum US {
    enum keyPath {
        static let estimatedProgress = "estimatedProgress"
        static let title = "title"
        static let contentOffset = "contentOffset"
    }
    
    enum key {
        static let code = "code"
    }
    
}

