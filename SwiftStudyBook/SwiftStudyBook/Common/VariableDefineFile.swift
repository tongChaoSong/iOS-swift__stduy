//
//  VariableDefineFile.swift
//  一起自驾游
//
//  Created by CXTX-IOS1 on 2019/8/14.
//  Copyright © 2019年 apple. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer


let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let kThemeColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
let kApplicationStatusBarHeight = UIApplication.shared.statusBarFrame.size.height + 44
let STANDARD_USER_DEFAULTS = UserDefaults.standard

let swiftMrg = SCREEN_WIDTH / 750 * 28

let SCALE_W = SCREEN_WIDTH/375
let SCALE_H = SCREEN_HEIGHT/667


enum LsqError: Error {
    case message(String)
    case msg
}
struct LsqDecoder {
    //TODO:转换模型
    static func decode<T>(_ type: T.Type, param: [String:Any]) throws -> T where T: Decodable{
        
        guard let jsonData = self.getJsonData(with: param) else {
            throw LsqError.message("转换data失败")
        }
        guard let model = try? JSONDecoder().decode(type, from: jsonData) else {
            throw LsqError.message("转换模型失败")
        }
        return model
    }
    
    
    static func decode<T>(_ type:T.Type, array:[[String:Any]]) throws ->[T] where T:Decodable {
        guard let jsonData = self.getJsonData(with: array) else {
            throw LsqError.message("转换data失败")
        }
        guard let models = try? JSONDecoder().decode([T].self, from: jsonData) else {
            throw LsqError.message("转换模型失败")
        }
        return models
    }
    
    
    
    static func getJsonData(with param: Any)->Data?{
        if !JSONSerialization.isValidJSONObject(param) {
            return nil
        }
        guard let data = try? JSONSerialization.data(withJSONObject: param, options: []) else {
            return nil
        }
        return data
    }
}


class ConversionExtension: NSObject {
    @objc class func conversionString(_ str:String) -> String {
        var string = str

        
        for char in string {
            if (isPurnInt(string: String(char))){
                let inta = Int(String(char))
                
                string = string.replacingOccurrences(of: String(char), with: inta!.cn)
            }
        }
        
        return string.transformToPinYin()
    }
    
    ///判断字符是否为数字
    class func isPurnInt(string: String) -> Bool {
        
        let scan: Scanner = Scanner(string: string)
        
        var val:Int = 0
        
        return scan.scanInt(&val) && scan.isAtEnd
        
    }
    //判断字符串是否为空
   @objc class func DYStringIsEmpty(value: AnyObject?) -> Bool {
        //首先判断是否为nil
        if (nil == value) {
            //对象是nil，直接认为是空串
            return true
        }else{
            //然后是否可以转化为String
            if let myValue  = value as? String{
                //然后对String做判断
                return myValue == "" || myValue == "(null)" || 0 == myValue.count
            }else{
                //字符串都不是，直接认为是空串
                return true
            }
        }
    }
    
    
    
}

class VolumeAdjustment: NSObject {
    //获取系统音量滑块
    func getSystemVolumSlider() -> UISlider {
        let systemVolumView = MPVolumeView()

        var volumViewSlider = UISlider()
        for subView in systemVolumView.subviews {
            if type(of: subView).description() == "MPVolumeSlider" {
                volumViewSlider = subView as! UISlider
                return volumViewSlider
            }
        }
        return volumViewSlider
    }
    //获取系统音量大小
    @objc func getSystemVolumValue()  -> Float {
        return getSystemVolumSlider().value
    }
    //调节系统音量大小
    @objc func setSysVolumWith(_ value: Float) {
        self.getSystemVolumSlider().value = value
    }
   
}


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
//print("中国".transformToPinYin())


