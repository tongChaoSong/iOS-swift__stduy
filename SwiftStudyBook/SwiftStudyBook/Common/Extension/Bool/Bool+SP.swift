//
//  NormalCell.swift
//  B7iOSBuyer
//
//  Created by 冯汉栩 on 2017/2/8.
//  Copyright © 2016年 com.spzjs.b7iosbuy. All rights reserved.
//

import UIKit

extension Bool {

  /// Bool转Int  value: 1 : 0
  var int: Int { return self ? 1 : 0 }
  /// Bool转String   value: "1" : "0"
  var string: String { return description }
  /// 取反
  public var toggled: Bool { return !self }
  /// 转换: CGFloat.
  public var cgFloat: CGFloat { return CGFloat(self.int) }
  
}

extension Bool{
  /// 取反
  @discardableResult public mutating func toggle() -> Bool {
    self = !self
    return self
  }
}
