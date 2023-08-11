//
//  StringAsNSString.swift
//  B7iOS
//
//  Created by 膳品科技 on 16/8/10.
//  Copyright © 2016年 Buy.Spzjs.iPhone. All rights reserved.
//

import UIKit

// MARK: - 类似NSString处理方法
extension String {

    /*  检测字符串所在位置
     let num:String = "15989954385"
     print("\(num.getIndexOf("3"))")
     */
  /// 获取指定字符所在索引
  public func getIndexOf(_ char: Character) -> Int? {
    for (index, c) in enumerated() {
      if c == char {
        return index
      }
    }
    return nil
  }

    /*
     let num:String = "15989954385"
     print("\(num.length)")
     */
  /// 字符长度
  public var length: Int{
    get{
      return self.count
    }
  }

    /*
     let num:String = "15989954385"
     print("\(num.append("ok"))")
     */
  /// 字符串拼接字符串
  ///
  /// - Parameter string: 子串
  /// - Returns: 新串
  public func append(_ string: String) -> String {
    return self + string
  }

  /// 截取: 区间内的子串
  ///
  /// - Parameter closedRange: 区间
  public subscript(range: Range<Int>) -> String {
    let start = index(startIndex, offsetBy: range.lowerBound)
    let end = index(startIndex, offsetBy: range.upperBound)
    return String(self[start..<end])
  }
  
  /// 截取: 区间内的子串
  ///
  /// - Parameter closedRange: 区间
  public subscript(closedRange: ClosedRange<Int>) -> String {
    return self[closedRange.lowerBound..<(closedRange.upperBound + 1)]
  }
  
  /// 返回限定范围内子串
  ///
  /// - Parameters:
  ///   - loc: 起始位置
  ///   - len: 结束位置
  /// - Returns: 新串
  public func substring(from: Int,to: Int) -> String {
    guard from >= 0 else{ return self }
    guard to >= 0 else{ return self }
    guard self.count - 1 > from else{ return self }
    guard self.count - 1 > to else{ return self }
    return (self as NSString).substring(with: NSMakeRange(from, to - 1))
  }

    
    /// 返回限定截止位置前内子串
    ///
    /// - Parameter to: 截止位置
    /// - Returns: 新串
    /******包括 前面 ******/
    public func substringInclude(front: Int) -> String {
        guard front >= 0 else{ return self }
        guard self.count > front + 1 else{ return self }
        return (self as NSString).substring(to: front + 1)
    }
    
  /// 返回限定起始位置后子串
  ///
  /// - Parameter from: 起始位置
  /// - Returns: 新串
  /******包括 后面 ******/
  public func substringInclude(behind: Int) -> String {
    guard behind >= 0 else{ return self }
    guard self.count > behind else{ return self }
    return (self as NSString).substring(from: behind)
  }

    /// 返回限定截止位置前内子串
    ///
    /// - Parameter to: 截止位置
    /// - Returns: 新串
    /******不包括 前面 ******/
    public func substringNoInclude(front: Int) -> String {
        guard front >= 0 else{ return self }
        guard self.count > front else{ return self }
        return (self as NSString).substring(to: front)
    }
    
    /// 返回限定起始位置后子串
    ///
    /// - Parameter from: 起始位置
    /// - Returns: 新串
    /******不包括 后面 ******/
    public func substringNoInclude(behind: Int) -> String {
        guard behind >= 0 else{ return self }
        guard self.count > behind + 1 else{ return self }
        return (self as NSString).substring(from: behind + 1)
    }

  /// 返回指定字符串前的子串
  ///
  /// - Parameter to: 指定字符串
  /// - Returns: 新串
  public func substringInclude(front: String) -> String {
    guard let range: Range = self.range(of: front) else { return self }
    return self.substring(to: range.lowerBound)
  }

  /// 返回指定字符串后的子串
  ///
  /// - Parameter from: 指定字符串
  /// - Returns: 新串
  public func substringInclude(behind: String) -> String {
    guard let range: Range = self.range(of: behind) else { return self }
    return self.substring(from: range.upperBound)
  }
    
    //将原始的url编码为合法的url
   public func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //将编码后的url转换回原始的url
   public func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
  
    //字符串转换数组
    public func stringForList(values:String, splitSymbol symbol:String) -> [String]{
      var list = [String]()
      list = values.components(separatedBy: symbol)
      return list
    }
  
}

