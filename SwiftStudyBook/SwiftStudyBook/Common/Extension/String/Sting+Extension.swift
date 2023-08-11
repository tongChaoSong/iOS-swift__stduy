//
//  Sting+Extension.swift
//  EnvironmentConfiguration
//
//  Created by BigL055 on 16/7/25.
//  Copyright © 2016年 BigL.EnvironmentConfiguration.com. All rights reserved.
//

/*
               正则的东西会在印象笔记里面有使用教程
 下面的文件修改了一下，之前拖进来的时候都没有好好使用一下正则的部分，今天
 2017.9.29使用的时候发现，有写缺点，不能满足现在的要求，因为Extension更新的很
 快，现在的extension已经很久了。所以就拖了一些新的用法进来。下面新拖进来的跟就的已经区分开来了
 */
import UIKit

public let NullString = ""

// MARK: - 转换
extension String {
  //有-------------------------------------
    /*
     let num:String = "12"
     print("\(num.int)")
     */
  /// String: 转化为Int
  var int: Int? {
    get{
      if let num = NumberFormatter().number(from: self) {
        return num.intValue
      } else {
        return nil
      }
    }
  }
    
  //有-------------------------------------
    /*
     let num:String = "12"
     print("\(num.double)")
     */
  /// String: 转化为 Double
  var double: Double? {
    get{
      if let num = NumberFormatter().number(from: self) {
        return num.doubleValue
      } else {
        return nil
      }
    }
  }
  
  //有-------------------------------------
    /*
     let num:String = "12"
     print("\(num.float)")
     */
  /// String: 转化为Float
  var float: Float? {
    get{
      if let num = NumberFormatter().number(from: self) {
        return num.floatValue
      } else {
        return nil
      }
    }
  }
  
  //有-------------------------------------
    /*
     let num:String = "12"
     print("\(num.number)")
     */
  /// String: 转化为 NSNumber
  var number: NSNumber? {
    if let num = NumberFormatter().number(from: self) {
      return num
    } else {
      return nil
    }
  }
    
  //有-------------------------------------
    /*
     let num:String = "12"
     print("\(num.bool)")
     */
  /// String: 转化为 Bool
  var bool: Bool? {
    get{
      if let num = NumberFormatter().number(from: self) {
        return num.boolValue
      }
      switch self {
      case "true","TRUE","yes","YES","1":
        return true
      case "false","FALSE","no","NO","0":
        return false
      default:
        return nil
      }
    }
  }
    
 //有-------------------------------------
    /*
     let num:String = "12"
     print("\(num.date)")
     */
  /// String: 转化为 Date,  格式: "yyyy-MM-dd"
  public var date: Date? {
    let selfLowercased = self.trimmed.lowercased()
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone.current
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.date(from: selfLowercased)
  }
  
  //有-------------------------------------
    /*
     let num:String = "12"
     print("\(num.dateTime)")
     */
  /// String: 转化为 Date, 格式: "yyyy-MM-dd HH:mm:ss"
  public var dateTime: Date? {
    let selfLowercased = self.trimmed.lowercased()
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone.current
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return formatter.date(from: selfLowercased)
  }
}



extension String{
  
    //有-------------------------------------
  /// remove: 首尾空格与换行
  public var trimmed: String {
    return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
  }
  
    //有-------------------------------------
  /// remove: 空格与换行
  public var withoutSpacesAndNewLines: String {
    return replacing(" ", with: NullString).replacing("\n", with: NullString)
  }
  
    //有-------------------------------------
  /// string: 反转 string.
  public var reversed: String { return String(reversed()) }
  
  //有-------------------------------------
  /// string: 反转 string.
  public mutating func reverse() {
    self = String(reversed())
  }
  
  //有-------------------------------------
  /// 替换
  ///
  /// - Parameters:
  ///   - string: 代替换文本
  ///   - newString: 替换文本
  /// - Returns: 新串
  public func replacing(_ string: String, with newString: String) -> String {
    return replacingOccurrences(of: string, with: newString)
  }
}

// MARK: - Emoji
extension String{

  //有-------------------------------------
  /// 提取: Emojis
  public var emojis: [String] {
    let unicodes = emojiFilter(isEmoji: true)
    var emojis = [String]()
    for unicode in unicodes {
      emojis.append(unicode.description)
    }
    return emojis
  }
  //有-------------------------------------
  /// 移除: Emojis
  public var removedEmoji: String{
    let unicodes = emojiFilter(isEmoji: false)
    var s = ""
    for item in unicodes {
      s += item.description
    }
    return s
  }

}



// MARK: - 文本区域
extension String{
  /**
   获取字符串的Bounds
   - parameter font: 字体大小
   - parameter size: 字符串长宽限制
   - returns: 字符串的Bounds
   */
  //有-------------------------------------
  func bounds(font: UIFont,size : CGSize) -> CGRect {
    let attributes = [NSAttributedString.Key.font: font]
    let option = NSStringDrawingOptions.usesLineFragmentOrigin
    let rect = self.boundingRect(with: size, options: option, attributes: attributes, context: nil)
    return rect
  }
  
  //有-------------------------------------
  /// 获取字符串的Bounds
  ///
  /// - parameter font:    字体大小
  /// - parameter size:    字符串长宽限制
  /// - parameter margins: 头尾间距
  /// - parameter space:   内部间距
  ///
  /// - returns: 字符串的Bounds
  func size(with font: UIFont,
            size: CGSize,
            margins: CGFloat = 0,
            space: CGFloat = 0) -> CGSize {
    var bound = self.bounds(font: font, size: size)
    let rows = self.rows(font: font, width: size.width)
    bound.size.height += margins * 2
    bound.size.height += space * (rows - 1)
    return bound.size
  }
    
  //有-------------------------------------
  /// 文本行数
  ///
  /// - Parameters:
  ///   - font: 字体
  ///   - width: 最大宽度
  /// - Returns: 行数
  func rows(font: UIFont,width: CGFloat) -> CGFloat {
    // 获取单行时候的内容的size
    let singleSize = (self as NSString).size(withAttributes: [NSAttributedString.Key.font:font])
    // 获取多行时候,文字的size
    let textSize = self.bounds(font: font, size: CGSize(width: width, height: CGFloat(MAXFLOAT))).size
    // 返回计算的行数
    return ceil(textSize.height / singleSize.height);
  }
  
}

//有-------------------------------------
// MARK: - 私有方法
extension String {
  /// Emojis 过滤
  ///
  /// - Parameter isEmoji: 是否需要Emoji
  /// - Returns: 数组
  fileprivate func emojiFilter(isEmoji: Bool) -> [String.UnicodeScalarView.Iterator.Element] {
    return unicodeScalars.filter { (scalar) -> Bool in
      switch scalar.value {
      case 0x3030, 0x00AE, 0x00A9,
           0x1D000...0x1F77F,
           0x2100...0x27BF,
           0xFE00...0xFE0F,
           0x1F900...0x1F9FF:
        return isEmoji
      default: break
      }
      return !isEmoji
    }
  }
}

/***********************************************************/

// MARK: - Check
//extension String{
/*
下面注释的部分已经过时了，因为新拖进来的都有这个功能，所以就初始掉它，但是下面有3个是没有注释掉的，没有注释掉的部分会在textField判断非法字符和表情的问题
*/
//    /// Check:
//    public var hasLetters: Bool {
//        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
//    }
//    
//    /// Check: 检查是否含有数字
//    public var hasNumbers: Bool {
//        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
//    }
//    
//    ///  Check: 检查是否为Email
//    public var isEmail: Bool {
//        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
//        let firstMatch = dataDetector?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: length))
//        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
//    }
//    

//
//    /// 是否为手机号码
////    var isPhone: Bool {
////        return self =~ Regex.isPhone
////    }
    
//    /// 验证是否为指定位数数字
//    ///
//    /// - Parameter digit: 位数
//    /// - Returns: 是否
//    func isNumber(digit: Int) -> Bool{
//        return self =~ "^\\d{\(digit)}$"
//    }
//
//    /// 提取: 提取URLs
//    public var extractURLs: [URL] {
//        var urls: [URL] = []
//        let detector: NSDataDetector?
//        do {
//            detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
//        } catch _ as NSError {
//            detector = nil
//        }
//
//        let text = self
//
//        if let detector = detector {
//            detector.enumerateMatches(in: text, options: [], range: NSRange(location: 0, length: text.characters.count), using: {
//                (result: NSTextCheckingResult?, flags: NSRegularExpression.MatchingFlags, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
//                if let result = result, let url = result.url {
//                    urls.append(url)
//                }
//            })
//        }
//        
//        return urls
//    }
    
//    /// Check: 是否为合法字符
//    var isLawful: Bool {
//        let str = self.removeLawful
//        let result = str.length == self.length
//        return result
//    }
//    
//    /// 检查: 是否含有Emoji
//    public var hasEmoji: Bool {
//        get{
//            for scalar in unicodeScalars {
//                switch scalar.value {
//                case 0x3030, 0x00AE, 0x00A9,
//                     0x1D000...0x1F77F,
//                     0x2100...0x27BF,
//                     0xFE00...0xFE0F,
//                     0x1F900...0x1F9FF:
//                    return true
//                default:
//                    continue
//                }
//            }
//            return false
//        }
//    }
//    
//    /// 移除非法字符
//    /// [\"//\\[\\]{}<>＜＞「」：；、•^\\n\\s*\r]
//    /// - returns: 新串
//    public var removeLawful: String {
//        let array = ["/","\\",
//                     "[","]",
//                     "{","}",
//                     "<",">",
//                     "＜","＞",
//                     "「","」",
//                     "：","；",
//                     "、","•",
//                     "^","'","\"",
//                     "\r","\r\n","\\n","\n"]
//        var str = self
//        for char in array {
//            str = str.replacingOccurrences(of: char, with: NullString)
//        }
//        return str
//    }

//}

/***********************************************************/
/*
 下面的东西是新拖进来的，在判断正则的时候更加全面比较好用
 */
// MARK: - Check
public extension String{
    
    enum HasState {
        case letters
        case numbers
        case email
        case phones
        case emojis
        case urls
        case unLawful
        case password
    }
    
    enum IsState {
        case phone
        case lawful
        case unLawful
        case number(digit: Int)
        case none
        case ipv4
        case double(prefix: Int,suffix: Int)
        case custom(str: String)
        case password
    }
    
    enum EventState {
        case urls
        case emojis
        case unLawful
    }
    
    /// 校验字符
    ///
    /// - Parameter state: 校验类型
    /// - Returns: 是否
    func has(_ state: HasState) -> Bool {
        switch state {
        case .unLawful:
            return self =~ RegexPattern.unLawful.pattern
        case .letters:
            return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        case .numbers:
            return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        case .email:
            return self =~ RegexPattern.email.pattern
        case .phones:
            return self =~ RegexPattern.phone.pattern
        case .urls:
            return self =~ RegexPattern.url.pattern
        case .emojis:
            for scalar in unicodeScalars {
                switch scalar.value {
                case 0x3030, 0x00AE, 0x00A9,
                     0x1D000...0x1F77F,
                     0x2100...0x278A,
                     0x2793...0x27BF,
                     0xFE00...0xFE0F,
                     0x1F900...0x1F9FF:
                    return true
                default:
                    continue
                }
            }
            return false
        case .password:
            return self =~ RegexPattern.password.pattern
            
        }

    }
    
    /// 判断字符串中特定字符
    ///
    /// - Parameter state: 类型
    /// - Returns: true/false
    func `is`(_ state: IsState) -> Bool {
        switch state {
        case .phone: return self =~ .phone
        case .unLawful:
            if self =~ .unLawful { return true }
            return self.contains("\\")
        case .lawful: return !(self =~ .unLawful)
        case .number(let digit): return self =~ .number(equal: digit)
        case .none:
            return self =~ .none
        case .ipv4:
            return self =~ .ipv4
        case .double(let prefix,let suffix):
            return self =~ .double(prefix: prefix, suffix: suffix)
        case .custom(let str):
            return self =~ .custom(str: str)
        case .password:
            return self =~ RegexPattern.password.pattern
        }
    }
    
    /// 移除字符串中特定字符
    ///
    /// - Parameter state: 类型
    /// - Returns: 新串
    func removed(_ state: EventState...) -> String {
        var str = self
        state.forEach { (item) in
            switch item {
            case .emojis: str = str.removedEmoji
            case .unLawful:
                str = Regex(.unLawful).replace(input: str, with: NullString)
                str = str.replacing("\\", with: NullString)
            case .urls: str = Regex(.url).replace(input: str, with: NullString)
            }
        }
        return str
    }
    
    /// 提取字符串中特定字符
    ///
    /// - Parameter state: 类型
    /// - Returns: 新串列表
    func extract(_ state: EventState) -> [String] {
        switch state {
        case .emojis: return emojis
        case .unLawful: return Regex(.unLawful).stringList(input: self)
        case .urls: return Regex(.url).stringList(input: self)
        }
    }
    
    /// 提取字符串中特定字符
    ///
    /// - Parameter state: 匹配规则
    /// - Returns: 新串列表
    func extract(_ pattern: String) -> [String] {
        return Regex(pattern).stringList(input: self)
    }
    
}

// MARK: - 操作符(注释没有报错)
extension String{
    
    static public func*(str: String, num: Int) -> String {
        var stringBuilder = [String]()
        num.times { _ in stringBuilder.append(str) }
        return stringBuilder.joined(separator: "")
    }
    
    static public func*(num: Int,str: String) -> String {
        var stringBuilder = [String]()
        num.times { _ in stringBuilder.append(str) }
        return stringBuilder.joined(separator: "")
    }
    
}
//转换string 拼音
extension String{
    func transformToPinYin()->String{
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        
        let array = string.components(separatedBy: " ")
        
        let mutableStr:NSMutableString = NSMutableString.init()
        
        for nStr in array {
            
            mutableStr.append(String(nStr.prefix(1)))
        }
        return mutableStr as String
        
    }
}
