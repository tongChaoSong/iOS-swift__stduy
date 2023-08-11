//
//  Regex+Extension.swift
//  正则表达式扩展
//  Created by BigL055 on 16/7/25.
//  Copyright © 2016年 BigL.EnvironmentConfiguration.com. All rights reserved.
//

import UIKit

infix operator =~: ATPrecedence
precedencegroup ATPrecedence {
    associativity: left
    higherThan: AdditionPrecedence
    lowerThan: MultiplicationPrecedence
}

// MARK: - 操作符
extension String{
    
    static func =~(lhs: String, rhs: String) -> Bool {
        return !Regex(rhs).matches(input: lhs).isEmpty
    }
    
    static func =~(lhs: String, rhs: RegexPattern) -> Bool {
        return !Regex(rhs).matches(input: lhs).isEmpty
    }
    
}

enum RegexPattern {
    case unLawful//是否是非法字符
    case url//是否是网络地址 http://www.baidu.com
    case phone//是否是 合法的手机号码
    case email//是否是 合法的邮件
    case number(equal: Int)//是否是 最低N位数
    case numbers(low: Int,upper: Int)//是否是  最低N位到最高N位
    case isPositiveInteger//是否是 是否是正整数(限制4位就能测出验证码)
    case isPrice//是否是 价格 如(1.0)浮点数
    case none//是否是 为空判断
    case ipv4//是否是 196.168.1.1
    case double(prefix: Int,suffix: Int)//是否是 正整数N位,小数N位
    case custom(str: String)//是否是 自定义
    case password
}

extension RegexPattern{
    var pattern: String{
        switch self {
        case .unLawful:
            return "[\"//\\[\\]{}<>＜＞「」：；、•^\\n\\s*\r]"
        case .url:
            return "(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]"
        case .phone:
            return "^((13[0-9])|(14[0-9])|(15[^4,\\D])|(17[0-1,6-8])|(18[0-9]))\\d{8}$"
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        case .number(equal: let digit):
            return "^\\d{" + String(digit) + "}$"
        case .numbers(let low, let upper):
            return "^\\d{" + String(low) + "," + String(upper) + "}$"
        case .isPositiveInteger: return "^\\d+$"
        case .isPrice: return "[1-9]\\d*.\\d*[1-9]\\d*"
        case .none: return ""
        case .ipv4: return "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
        case .double(let prefix, let suffix):
            return "^\\d{0,\(prefix)}$|^(\\d{0,\(prefix)}[.][0-9]{0,\(suffix)})$"
        case .custom(let str):
            return str
        case .password:
            return "^[A-Za-z0-9]+$"
        }
    }
    static func ==(lsh: RegexPattern,rsh: RegexPattern) -> Bool {
        return lsh.pattern == rsh.pattern
    }
}

func ==(lsh: [RegexPattern],rsh: [RegexPattern]) -> Bool {
    let l = lsh.map({ (item) -> String in return item.pattern })
    let r = rsh.map({ (item) -> String in return item.pattern })
    return l == r
}


/*
 正则匹配库
 */
struct Regex {
    //有---------------
    let regex: NSRegularExpression
    
    let pattern: String
    //有---------------
    init(_ pattern: String,ignoreCase: Bool = true) {
        self.pattern = pattern
        do {
            try regex = NSRegularExpression(pattern: pattern,
                                            options: ignoreCase ? .caseInsensitive : [])
        } catch  {
            regex = NSRegularExpression()
            print(error.localizedDescription)
        }
        
    }
    
    init(_ regexPattern: RegexPattern,ignoreCase: Bool = true) {
        self.pattern = regexPattern.pattern
        do {
            try regex = NSRegularExpression(pattern: regexPattern.pattern,
                                            options: ignoreCase ? .caseInsensitive : [])
        } catch {
            regex = NSRegularExpression()
            print(error.localizedDescription)
        }
    }
    
    /// 替换匹配文本
    ///
    /// - Parameters:
    ///   - pattern: 匹配规则
    ///   - input: 输入字符串
    ///   - with: 替换文本
    /// - Returns: 替换后文本
    func replace(input: String, with: String) -> String{
        let strList = stringList(input: input)
        var output = input
        strList.forEach { (item) in
            output = output.replacingOccurrences(of: item, with: with)
        }
        return output
    }
    
    /// 匹配
    ///
    /// - Parameters:
    ///   - input: 输入文本
    /// - Returns: 匹配结果
    func matches(input: String) -> [NSTextCheckingResult] {
        return regex.matches(in: input, options: [], range: NSMakeRange(0, input.utf16.count))
    }
    
    func stringList( input: String) -> [String] {
        let res = matches(input: input)
        if res.isEmpty { return [String]() }
        var strList = [String]()
        res.forEach { (result) in
            let str = (input as NSString).substring(with: result.range)
            strList.append(str)
        }
        return strList
    }
    
    //有-----------------------------------
    /// 返回一个字典  key: 匹配到的字串, Value: 匹配到的字串的Range数组
    ///
    /// - Parameters:
    ///   - input: 输入字符串
    /// - Returns: 返回一个字典  key: 匹配到的字串, Value: 匹配到的字串的Range数组
    func stringWithRanges(input: String) -> [String: [NSRange]] {
        let res = matches(input: input)
        if res.isEmpty { return [String: [NSRange]]() }
        var dict = [String: [NSRange]]()
        res.forEach { (result) in
            let key = (input as NSString).substring(with: result.range)
            if dict[key] == nil { dict[key] = [NSRange]() }
            dict[key]?.append(result.range)
        }
        return dict
    }
    
    /// 匹配到的字串的Range数组
    ///
    /// - Parameters:
    ///   - input: 输入字符串
    /// - Returns: Range数组
    func ranges(input: String) -> [NSRange] {
        let res = matches(input: input)
        if res.isEmpty { return [NSRange]() }
        var ranges = [NSRange]()
        res.forEach { (result) in ranges.append(result.range) }
        return ranges
    }
    
    /// 返回一个数组 Value : 匹配到的字串的Range数组
    func rangeList(subStr : String, inputStr : String) -> [NSRange]? {
        guard inputStr =~ subStr else{
            return [NSMakeRange(0, 0)]
        }
        //设置Range数组
        var rangeArray = [NSRange]()
        //设置母串
        var bigString = inputStr
        // - 1、创建规则
        let pattern = subStr
        var count : Int = 0
        do{
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            //获取子串个数
            count = regex.numberOfMatches(in: bigString, options: .reportProgress, range: NSMakeRange(0, bigString.count))
        }catch{
            print(error)
        }
        for i in 0..<count {
            var subRange = (bigString as NSString).range(of: pattern)
            let cutLoc = subRange.location + subRange.length
            let cutLen = bigString.count - cutLoc
            bigString = (bigString as NSString).substring(with: NSMakeRange(cutLoc, cutLen))
            if i > 0 {
                let preSubRange = rangeArray[i - 1]
                subRange.location = preSubRange.location + preSubRange.length
            }
            rangeArray.append(subRange)
        }
        
        return rangeArray
    }
    
}






