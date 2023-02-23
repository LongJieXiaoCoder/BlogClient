//
//  UserService.swift
//  BlogClient
//
//  Created by LongMac on 2020/5/16.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

enum RequestStatus: Int {
    case failure = 0
    case success = 1
}

typealias ServiceCompleteBlock = (Any, RequestStatus) -> Void

class UserService {
    static func getUserInfo(callBack: @escaping ServiceCompleteBlock) {
        NetworkTool.request(url: API.url.apiUsers, method: .get, parameter: nil, modelType: User.self) { (response) in
            switch response.result {
            case .success(let model):
                callBack(model, .success)
            case .failure(let error):
                callBack(error, .failure)
            }
        }
    }
}
