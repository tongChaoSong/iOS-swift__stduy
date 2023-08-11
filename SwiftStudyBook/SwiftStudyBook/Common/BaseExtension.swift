//
//  BaseExtension.swift
//  SwiftStudyMeans
//
//  Created by apple on 2020/7/27.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
extension UIColor{
    
    class func getColorAplpha(hexColor:String,alpha: CGFloat) -> UIColor{
        //        var resultHexString = hexColor
        //        if resultHexString.hasPrefix("#") {
        //            resultHexString.remove(at: resultHexString.startIndex)
        //        }
        //        let resultHexInt:Int = Int(resultHexString)!
        //        let red = (CGFloat((resultHexInt & 0xFF0000) >> 16)) / 255
        //        let green = (CGFloat((resultHexInt & 0xFF00) >> 8)) / 255
        //        let blue = (CGFloat(resultHexInt & 0xFF)) / 255
        //        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        var cstr:NSString = hexColor as NSString
        
        if(cstr.length < 6){
            return UIColor.clear;
        }
        if(cstr.hasPrefix("0X")){
            cstr = cstr.substring(from: 2) as NSString
        }
        if(cstr.hasPrefix("#")){
            cstr = cstr.substring(from: 1) as NSString
        }
        if(cstr.length != 6){
            return UIColor.clear;
        }
        var range = NSRange.init()
        range.location = 0
        range.length = 2
        //r
        let rStr = cstr.substring(with: range);
        //g
        range.location = 2;
        let gStr = cstr.substring(with: range)
        //b
        range.location = 4;
        let bStr = cstr.substring(with: range)
//        var r :UInt32 = 0x0;
//        var g :UInt32 = 0x0;
//        var b :UInt32 = 0x0;
//                Scanner.init(string: rStr).scanHexInt32(&r);
//                Scanner.init(string: gStr).scanHexInt32(&g);
//                Scanner.init(string: bStr).scanHexInt32(&b);
        //
        var r :UInt64 = 0x0;
        var g :UInt64 = 0x0;
        var b :UInt64 = 0x0;
        Scanner.init(string: rStr).scanHexInt64(&r);
        Scanner.init(string: gStr).scanHexInt64(&g);
        Scanner.init(string: bStr).scanHexInt64(&b);
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1);
    }
    
    class func getColor(hexColor:String) -> UIColor{
//        var resultHexString = hexColor
//        if resultHexString.hasPrefix("#") {
//            resultHexString.remove(at: resultHexString.startIndex)
//        }
//        let resultHexInt:Int = Int(resultHexString)!
//        let red = (CGFloat((resultHexInt & 0xFF0000) >> 16)) / 255
//        let green = (CGFloat((resultHexInt & 0xFF00) >> 8)) / 255
//        let blue = (CGFloat(resultHexInt & 0xFF)) / 255
//        return UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        return self.getColorAplpha(hexColor: hexColor, alpha: 1)
    

    }
}

extension Int {
    var cn: String {
        get {
            if self == 0 {
                return "零"
            }
            var zhNumbers = ["零", "一", "二", "三", "四", "五", "六", "七", "八", "九"]
            var units = ["", "十", "百", "千", "万", "十", "百", "千", "亿", "十","百","千"]
            var cn = ""
            var currentNum = 0
            var beforeNum = 0
            let intLength = Int(floor(log10(Double(self))))
            for index in 0...intLength {
                currentNum = self/Int(pow(10.0,Double(index)))%10
                if index == 0{
                    if currentNum != 0 {
                        cn = zhNumbers[currentNum]
                        continue
                    }
                } else {
                    beforeNum = self/Int(pow(10.0,Double(index-1)))%10
                }
                if [1,2,3,5,6,7,9,10,11].contains(index) {
                    if currentNum == 1 && [1,5,9].contains(index) && index == intLength { // 处理一开头的含十单位
                        cn = units[index] + cn
                    } else if currentNum != 0 {
                        cn = zhNumbers[currentNum] + units[index] + cn
                    } else if beforeNum != 0 {
                        cn = zhNumbers[currentNum] + cn
                    }
                    continue
                }
                if [4,8,12].contains(index) {
                    cn = units[index] + cn
                    if (beforeNum != 0 && currentNum == 0) || currentNum != 0 {
                        cn = zhNumbers[currentNum] + cn
                    }
                }
            }
            return cn
        }
    }
    

}


