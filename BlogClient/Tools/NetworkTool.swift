//
//  NetworkTool.swift
//  BlogClient
//
//  Created by Long on 2020/5/11.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

class NetworkTool {
    public static func request<T: Decodable>(url: URLConvertible, method: HTTPMethod = .get, parameter: Parameters?, modelType:T.Type, callBack: @escaping (DataResponse<T, AFError>) -> Void) {
        // 每次请求都需要判断当前是否存在token，并判断有效期
        if (OAuth.isLocalExistOauthData() && !OAuth.isAccessTokenExpired()) {
            guard let model: OAuth = StoreHelper.read(OAuth.self, from: FilePath.oauthFilePath) else { return }
            let header = HTTPHeader.authorization(bearerToken: model.accessToken)
            log(model.accessToken) // modify by longchi
            
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.lc.formatString("yyyy-MM-dd'T'HH:mm:SS"))
            AF.request(url, method: method, parameters: parameter, headers: HTTPHeaders([header])).responseDecodable(of:modelType, decoder: decoder) { response in
                callBack(response)
            }
        } else {
            let authHeader = HTTPHeader.authorization(username: API.rpv.client_id, password: API.rpv.client_secret)
            AF.request(API.url.connectToken, method: .post, parameters: [API.rpk.grant_type : API.rpv.client_credentials], headers: HTTPHeaders([authHeader])).responseDecodable(of: OAuth.self) { response in
                switch response.result {
                case .success(let model):
                    print("oauthModel: \(model)")
                    model.expiresDate = Date().addingTimeInterval(model.expiresIn)
                    StoreHelper.write(model, to: FilePath.oauthFilePath)
                    
                    log(model.accessToken)   // modify by longchi
                    
                    // 先获取授权数据， 然后才能正常请求数据
                    let requestHeader = HTTPHeader.authorization(bearerToken: model.accessToken)
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.lc.formatString("yyyy-MM-dd'T'HH:mm:SS"))
                    AF.request(url, method: method, parameters: parameter, headers: HTTPHeaders([requestHeader])).responseDecodable(of:modelType, decoder: decoder) { response in
                        callBack(response)
                    }
                case .failure(let error):
                    print(error) // TODO::
                }
            }
        }
    }
}

