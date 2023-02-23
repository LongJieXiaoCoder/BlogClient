//
//  HomeService.swift
//  BlogClient
//
//  Created by Long on 2020/5/19.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

class HomeService {
    // 首页博文列表
    static func getHomeBlogListInfo(with pageType: HomePageType, pageSize: Int, pageIndex: Int, callBack: @escaping ServiceCompleteBlock) {
        let parameter = [API.rpk.pageIndex : pageIndex, API.rpk.pageSize : pageSize]
        var url = API.url.blogpostsSitehome
        if pageType == .essence {
            url = API.url.blogpostsPicked
        }
        NetworkTool.request(url: url, parameter: parameter, modelType: [BlogItem].self) { response in
            guard let blogItems = response.value else {
                log(response.error)
                callBack(response.error as Any, .failure)
                return;
            }
            callBack(blogItems, .success)
        }
    }
    
    // 首页博文内容
    static func getHomeBlogInfo(url: String, callBack: @escaping ServiceCompleteBlock) {
        NetworkTool.request(url: url, parameter: nil, modelType: String.self) { (response) in
            switch response.result {
            case .success(let result):
                callBack(result, .success)
            case .failure(let error):
                callBack(error, .failure)
            }
        }
    }
}
