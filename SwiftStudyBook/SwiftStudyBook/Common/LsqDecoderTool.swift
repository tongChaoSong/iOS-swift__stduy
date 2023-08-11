//
//  LsqDecoderTool.swift
//  SwiftStudyBook
//
//  Created by 1998xxsq on 2023/8/11.
//  Copyright © 2023 tcs. All rights reserved.
//

import Foundation
enum LsqError: Error {
    case message(String)
    case msg
    
}
struct LsqDecoder {
    //TODO:转换模型
    static func decode<T>(_ type: T.Type, param: [String:Any]) throws -> T where T: Decodable{
        
        guard let jsonData = self.getJsonData(with: param) else {
            throw LsqError.message("转换data失败")
        }
        guard let model = try? JSONDecoder().decode(type, from: jsonData) else {
            throw LsqError.message("转换模型失败")
        }
        return model
    }
    
    
    static func decode<T>(_ type:T.Type, array:[[String:Any]]) throws ->[T] where T:Decodable {
        guard let jsonData = self.getJsonData(with: array) else {
            throw LsqError.message("转换data失败")
        }
        guard let models = try? JSONDecoder().decode([T].self, from: jsonData) else {
            throw LsqError.message("转换模型失败")
        }
        return models
    }
    
    
    
    static func getJsonData(with param: Any)->Data?{
        if !JSONSerialization.isValidJSONObject(param) {
            return nil
        }
        guard let data = try? JSONSerialization.data(withJSONObject: param, options: []) else {
            return nil
        }
        return data
    }
}
