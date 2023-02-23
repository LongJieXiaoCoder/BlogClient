//
//  OAuth.swift
//  BlogClient
//
//  Created by Long on 2020/5/11.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

class OAuth: Codable{
    var accessToken: String = ""    // access_token 存储OAuth登录所需的access_token
    var expiresIn: Double = 0.0     // expires_in OAuth登录后，access_token过期时间，时间戳
    var expiresDate: Date = Date()  // 失效的日期，date类型
    var tokenType: String = ""      // token的类型
    var refreshToken: String = ""   // refresh_token access_token过期后，不需要让用户重新登录，直接使用refresh_token重新登录
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
//        case expiresDate = "expires_date"
        case tokenType = "token_type"
//        case refreshToken = "refresh_token"
    }
    
    // 本地是否存在授权信息
    static func isLocalExistOauthData() -> Bool {
        guard let _ = StoreHelper.read(OAuth.self, from: FilePath.oauthFilePath) else { return true }
        return true
    }
    
    // token是否已失效
    static func isAccessTokenExpired() -> Bool {
        guard let model: OAuth = StoreHelper.read(OAuth.self, from: FilePath.oauthFilePath) else { return true }
        if model.expiresDate.compare(Date()) == .orderedDescending {
            return false
        }
        return true
    }
}
