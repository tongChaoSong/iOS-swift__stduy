//
//  NormalCell.swift
//  B7iOSBuyer
//
//  Created by 冯汉栩 on 2017/2/8.
//  Copyright © 2016年 com.spzjs.b7iosbuy. All rights reserved.
//

import UIKit

extension Array {
    
    //筛选数组中重复的元素
   func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
    
}
