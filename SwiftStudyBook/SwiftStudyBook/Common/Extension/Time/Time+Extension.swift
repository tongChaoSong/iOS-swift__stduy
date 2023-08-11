//
//  Time+Extension.swift
//  sharesChonse
//
//  Created by 冯汉栩 on 2018/8/2.
//  Copyright © 2018年 fenghanxuCompany. All rights reserved.
//

import UIKit

class Time: NSObject {
  
  enum CurrentTime:String {
    /**
     yyy-MM-dd
     */
    case time_0 = "yyyy-MM-dd"
    /**
     yyyy-MM-dd HH:mm
     */
    case time_1 = "yyyy-MM-dd HH:mm"
    /**
     yyyy-MM-dd HH:mm:ss
     */
    case time_2 = "yyyy-MM-dd HH:mm:ss"
    /**
     yyyyMMdd
     */
    case time_3 = "yyyyMMdd"
    /**
     yyyyMMdd HH:mm
     */
    case time_4 = "yyyyMMdd HH:mm"
    /**
     yyyyMMdd HH:mm:ss
     */
    case time_5 = "yyyyMMdd HH:mm:ss"
  }
  
  /**
   获取当前时间
   */
  class func getCurrentTime(CurrentTime type:CurrentTime) -> String {
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = type.rawValue
    let date = timeFormatter.string(from: Date()) as String
    return date
  }
  
  enum AfterTime:String {
    /**
     MMdd
     */
    case time_0 = "MMdd"
    /**
     yyyyMMdd
     */
    case time_1 = "yyyyMMdd"
    /**
     MM-dd
     */
    case time_2 = "MM-dd"
    /**
     yyyy-MM-dd
     */
    case time_3 = "yyyy-MM-dd"
  }
  
  /**
   计算现在到N天后的日期
   */
  class func getDistanceTimeBehind(day:Int, AfterTime type:AfterTime) -> String{
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = type.rawValue
    let lastDay = Date(timeInterval: TimeInterval(24*day*60*60), since: Date())
    let yerDay = timeFormatter.string(from: lastDay) as String
    return yerDay
  }
  
  /**
   计算现在到N天前的日期
   */
  class func getDistanceTimeFront(day:Int, AfterTime type:AfterTime) -> String{
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = type.rawValue
    let lastDay = Date(timeInterval: TimeInterval(-(24*day*60*60)), since: Date())
    let yerDay = timeFormatter.string(from: lastDay) as String
    return yerDay
  }
  
  /**
   把时间转换成时间戳
   */
  class func stringToTimeStamp(stringTime:String, CurrentTime type:CurrentTime)->String {
    let dfmatter = DateFormatter()
    dfmatter.dateFormat=type.rawValue
    let date = dfmatter.date(from: stringTime)
    let dateStamp:TimeInterval = date!.timeIntervalSince1970
    let dateSt:Int = Int(dateStamp)
    return String(dateSt)
  }
  
  /**
   把时间戳转换成时间
   */
  class func timeStampToString(timeStamp:String, CurrentTime type:CurrentTime)->String {
    let string = NSString(string: timeStamp)
    let timeSta:TimeInterval = string.doubleValue
    let dfmatter = DateFormatter()
    dfmatter.dateFormat=type.rawValue
    let date = NSDate(timeIntervalSince1970: timeSta)
    return dfmatter.string(from: date as Date)
  }
  
  /**
   获取今天运行了几秒
   */
  class func todayRuningHowmuchTime() ->Int {
    //获取当前时间精确到秒
    let currentSecondTime = Time.getCurrentTime(CurrentTime: .time_2)
    //把当前时间转换成戳
    let currentSecondTimeStamp = Time.stringToTimeStamp(stringTime: currentSecondTime, CurrentTime: .time_2)
    //获取当前的凌晨时间
    let currentDayBeginTime = getCurrentTime(CurrentTime: .time_0)
    let currentSecondBeginTime = currentDayBeginTime + " 00:00:00"
    //把凌晨时间转换成时间戳
    let currentSecondBeginTimeStamp = Time.stringToTimeStamp(stringTime: currentSecondBeginTime, CurrentTime: .time_2)
    //计算今天运行了多小秒
    let currentRunTime = Int(currentSecondTimeStamp)! - Int(currentSecondBeginTimeStamp)!
    return currentRunTime
  }
  
  /**
   获取当前凌晨到N点的秒数
   HH:mm:ss
   */
  class func NTimeRunningSecond(hourMinSecond:String) ->Int {
    let currentDayBeginTime = getCurrentTime(CurrentTime: .time_0)
    let currentSecondTime = currentDayBeginTime + " " + hourMinSecond
    //把当前时间转换成戳
    let currentSecondTimeStamp = Time.stringToTimeStamp(stringTime: currentSecondTime, CurrentTime: .time_2)
    let currentSecondBeginTime = currentDayBeginTime + " 00:00:00"
    //把凌晨时间转换成时间戳
    let currentSecondBeginTimeStamp = Time.stringToTimeStamp(stringTime: currentSecondBeginTime, CurrentTime: .time_2)
    let runningTime = Int(currentSecondTimeStamp)! - Int(currentSecondBeginTimeStamp)!
    return runningTime
  }
  
  /**
   获取某一个具体时间之前N天的时间
   */
  class func getStartTimeIntervalDayBetween(startTime:String, intputType inType:Time.CurrentTime, intervalDay:Int, outputType outType:AfterTime) -> String{
    //UTC国际标准  中国时间相差8小时28800
    let stamp = Time.stringToTimeStamp(stringTime: startTime, CurrentTime: inType)
    let beijingTime = String(Int(stamp)! + 28800)
    let dateLast = Date(timeIntervalSince1970: TimeInterval(beijingTime)!)
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = outType.rawValue
    let lastDay = Date(timeInterval: TimeInterval(-(24*intervalDay*60*60)), since: dateLast)
    let yerDay = timeFormatter.string(from: lastDay) as String
    return yerDay
  }
  
  /**
   获取某一个具体时间之后N天的时间
   */
  class func getStartTimeIntervalDayAfter(startTime:String, intputType inType:Time.CurrentTime, intervalDay:Int, outputType outType:AfterTime) -> String{
    //UTC国际标准  中国时间相差8小时28800
    let stamp = Time.stringToTimeStamp(stringTime: startTime, CurrentTime: inType)
    let beijingTime = String(Int(stamp)! + 28800)
    let dateLast = Date(timeIntervalSince1970: TimeInterval(beijingTime)!)
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = outType.rawValue
    let lastDay = Date(timeInterval: TimeInterval(24*intervalDay*60*60), since: dateLast)
    let yerDay = timeFormatter.string(from: lastDay) as String
    return yerDay
  }
  
  
}
