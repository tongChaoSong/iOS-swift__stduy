//
//  CalendarExtension.swift
//  TestDemo
//
//  Created by 冯汉栩 on 2018/10/22.
//  Copyright © 2018 冯汉栩. All rights reserved.
//

import Foundation

public extension Calendar {
    
    ///得到时间戳，通过日期
    public static func getTimeStampDistanceFromCurrentDay(dayCount : Int) -> CLongLong {
        let nowDate = Date()
        let calendar = Calendar.init(identifier: .gregorian)
        let component:DateComponents = calendar.dateComponents([.year,.month,.day], from: nowDate)
       ///拿到今天凌晨的日期
        let date0 = calendar.date(from: component)
        
        ///如果是比今天晚的某个时候，就要+1
        var mydayCount = dayCount
        if dayCount > 0 {
            mydayCount += 1
        }
        
        return self.getTimeStamp(date: date0!) + (CLongLong)(mydayCount * 24 * 60 * 60 * 1000)
    }
    
    /// 通过时间字符串得到时间戳
    public static func getTimeStampFromTimeShowStr(ShowStr : String,formatter : String = "yyyy-MM-dd HH:mm:ss") -> CLongLong? {
        let date = self.getDate(ShowStr: ShowStr, formatter: formatter)
        guard date != nil else {
            return nil
        }
        return self.getTimeStamp(date: date!)
    }
    
    /// 通过时间戳得到时间字符串
    public static func getTimeShowStrFromTimeStamp(TimeStamp : CLongLong,formatter : String = "yyyy-MM-dd HH:mm:ss") -> String {
        let date = self.getDate(TimeStamp: TimeStamp)
        let dformatter = DateFormatter()
        dformatter.dateFormat = formatter
        return dformatter.string(from: date)
    }
    
    ///得到时间字符串得到日期
    public  static func getDate(ShowStr : String,formatter : String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dformatter = DateFormatter()
        dformatter.dateFormat = formatter
        return dformatter.date(from: ShowStr)
    }
    
    ///通过时间戳得到日期
    public  static func getDate(TimeStamp : CLongLong) -> Date {
        //转换为时间
        let timeInterval:TimeInterval = TimeInterval(TimeStamp / 1000)
        let date = Date(timeIntervalSince1970: timeInterval)
        return date
    }
    
    ///得到时间戳，通过日期
    public static func getTimeStamp(date : Date = Date()) -> CLongLong {
        let timeInterval:TimeInterval = date.timeIntervalSince1970
        let timeStamp = CLongLong(timeInterval * 1000)
        return timeStamp
    }
  
}
