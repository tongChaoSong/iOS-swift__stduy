//
//  PersonOne.swift
//  折上折
//
//  Created by apple on 2019/9/26.
//  Copyright © 2019 tcs.Orz.com. All rights reserved.
//

import UIKit

/// Department模型，也遵循 Codable 协议
class Department: Codable {
    var name: String
    var id: Int
//    var tableHg: Int

    var members: [PersonOne] = []
    var manager: PersonOne?
}

class PersonOne: Codable {

    var name: String?
    var age: Int?
    var address: String?
    var aDog:Dog?
    private enum CodingKeys: String, CodingKey {
        case name = "NAME"
        case age = "AGE"
        case address = "ADDRESS"
        case aDog = "dog"
    }
}

// Dog模型
class Dog: Codable {
    var name: String?
}
//let jsonString =
//"""
//{
//"name":"技术部",
//"id":123,
//"members":[
//{
//"NAME":"xiaoming",
//"AGE":24,
//"ADDRESS":"nanjing",
//"dog":{
//"name":"Tom"
//}
//},
//{
//"NAME":"LOLITA0164",
//"AGE":26,
//"ADDRESS":"nanjing",
//"dog":{
//"name":"Tonny"
//}
//},
//],
//"manager":{
//"NAME":"ZHANG",
//"AGE":33,
//"ADDRESS":"nanjing",
//}
//}
//"""
