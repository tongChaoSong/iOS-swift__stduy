//
//  Dynamic.swift
//  sharesChonse
//
//  Created by 冯汉栩 on 2017/9/29.
//  Copyright © 2017年 fenghanxuCompany. All rights reserved.
//

import UIKit

public struct Dynamic<T> {
    public typealias Listener = (T) -> Void
    public var listener: Listener?
    
    public mutating func bind(listener: Listener?) {
        self.listener = listener
    }
    
    public mutating func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    public var value: T {
        didSet {
            listener?(value)
        }
    }
    
    public init(_ v: T) {
        value = v
    }
}
