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



// MARK: - 其他 -
/**
 *  1、颜色
 */
// rgb颜色转换（16进制->10进制）
func RGBA(R:CGFloat,G:CGFloat,B:CGFloat,A:CGFloat) ->UIColor {
    return UIColor(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: A)
    //    return UIColor.init(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: A)
}

//弱引用
//let weakSelf  __weak __typeof(&*self)weakSelf = self;

// MARK: - 尺寸信息： -
/* 状态栏高度  20 或 44 */
// 然而从iOS 14开始，全面屏iPhone的状态栏高度不一定是 44 或 20 了，比如下面就是这些设备在iOS 14.1上的状态栏高度。（还可能时47、48）
/// ①、顶部状态栏高度（包括安全区）
func k_Height_statusBar() -> CGFloat {
    var statusBarHeight: CGFloat = 0;
    if #available(iOS 13.0, *) {
        let scene = UIApplication.shared.connectedScenes.first;
        guard let windowScene = scene as? UIWindowScene else {return 0};
        guard let statusBarManager = windowScene.statusBarManager else {return 0};
        statusBarHeight = statusBarManager.statusBarFrame.height;
    } else {
        statusBarHeight = UIApplication.shared.statusBarFrame.height;
    }
    return statusBarHeight;
}
/// ②、顶部安全区高度 k_Height_safeAreaInsetsTop
func k_Height_safeAreaInsetsTop() -> CGFloat {
    if #available(iOS 13.0, *) {
        let scene = UIApplication.shared.connectedScenes.first;
        guard let windowScene = scene as? UIWindowScene else {return 0}; // guard：如果 expression 值计算为false，则执行代码块内的 guard 语句。(必须包含一个控制语句: return、 break、 continue 或 throw。)。as?：类型转换，(还有这两种：as、as!)
        guard let window = windowScene.windows.first else {return 0};
        return window.safeAreaInsets.top;
    } else if #available(iOS 11.0, *) {
        guard let window = UIApplication.shared.windows.first else {return 0};
        return window.safeAreaInsets.top;
    }
    return 0;
}

/// ③、底部安全区高度
func k_Height_safeAreaInsetsBottom() -> CGFloat {
    if #available(iOS 13.0, *) {
        let scene = UIApplication.shared.connectedScenes.first;
        guard let windowScene = scene as? UIWindowScene else {return 0};
        guard let window = windowScene.windows.first else {return 0};
        return window.safeAreaInsets.bottom;
    } else if #available(iOS 11.0, *) {
        guard let window = UIApplication.shared.windows.first else {return 0};
        return window.safeAreaInsets.bottom;
    }
    return 0;
}


/* 导航栏高度 固定高度 = 44.0f */
//let k_Height_NavContentBar :CGFloat  = UINavigationBar.appearance().frame.size.height
let k_Height_NavContentBar :CGFloat = 44.0
/** 状态栏高度 */
let k_Height_StatusBar :CGFloat = k_Height_statusBar()
/** 状态栏+导航栏的高度 */
let k_Height_NavigationtBarAndStatuBar: CGFloat = k_Height_NavContentBar + k_Height_StatusBar
/** 底部tabBar栏高度（不包含安全区，即：在 iphoneX 之前的手机） */
let k_TabBar_Height :CGFloat = 49.0
/** 底部导航栏高度（包括安全区），一般使用这个值 */
let k_Height_TabBar :CGFloat = k_Height_safeAreaInsetsBottom() + k_TabBar_Height



// MARK: - 检查系统版本 -
/* 检查系统版本 */
/// 版本号相同：
func systemVersionEqual(version:String) -> Bool {
    return UIDevice.current.systemVersion == version
}

/// 系统版本高于等于该version  测试发现只能传入带一位小数点的版本号  不然会报错    具体原因待探究
func systemVersionGreaterThan(version:String) -> Bool {
    return UIDevice.current.systemVersion.compare(version, options: .numeric, range: version.startIndex..<version.endIndex, locale: Locale(identifier:version)) != ComparisonResult.orderedAscending
}

//判断是否是 x、及x以上 系列
func isIphoneX() -> Bool {
    return k_Height_safeAreaInsetsBottom() > 0.0; // 底部安全区 > 0 时，
    
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





//print("中国".transformToPinYin())


