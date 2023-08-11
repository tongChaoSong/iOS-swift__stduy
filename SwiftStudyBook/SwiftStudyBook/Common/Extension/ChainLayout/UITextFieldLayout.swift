//
//  UITextFieldLayout.swift
//  sharesChonse
//
//  Created by 冯汉栩 on 2017/11/20.
//  Copyright © 2017年 fenghanxuCompany. All rights reserved.
//

/*
 let myTextField = TextField().hxAddSubView(toSuperView: view).hxLayout { (make) in
 make.centerX.equalToSuperview()
 make.centerY.equalToSuperview().offset(150)
 make.width.equalTo(150)
 make.height.equalTo(35)
 }.hxConfig { (textField) in
 textField.hx
 .TextFieldPlaceholder(content: "请输入档口名称", color: Color.theme, font: Font.font20)
 .TextFieldTextColor(color: Color.price)
 .TextFieldFont(fonts: Font.font18)
 .TextFieldKeyBoardType()
 .TextFieldChangeVolues(actions: #selector(textFieldChange(textField:)))
 
 textField.delegate = self
 }
 
 func textFieldChange(textField:TextField){
     SPLogs("内容 = \(textField.text)")
 }
 
 extension ViewController:UITextFieldDelegate {
 
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     guard let text = textField.text else{
     return true
     }
 
     let textLength = text.characters.count + string.characters.count - range.length
 
     return textLength <= 8
     }
 
 }
 
 */

import UIKit
import ObjectiveC
/*
 使用上有一点特别注重的地方:必须先设置提示语内容,颜色,大小,在设置文本的颜色,大小,不然提示语没有效果的。
 textField的常用设置
 提示语内容
 提示语颜色
 提示语大小
 文本颜色
 文本大小
 键盘类型
 字数限制
 正则(只适用于价格的设置)
 清楚按键
 最后一个是方法,一般都用拿到把的值处理事情的,这个是自定义的监听方法
 另外一个是遵守代理的方法,可以拿到当前多小位数，原始的限制位数在这里设置。
 */

extension NameSpace where Base == TextField {
    
    /*提示语*/
    @discardableResult
    func TextFieldPlaceholder(content:String,color:UIColor,font:UIFont) -> Self {
        base.placeholder = content
        base.attributedPlaceholder = NSAttributedString(string: content, attributes: [NSAttributedString.Key.font: font,NSAttributedString.Key.foregroundColor: color])
        
//        base.placeholderLabel.textColor = color
//        base.placeholderLabel.text = content
//        base.placeholderLabel.font = font
        
        let ivar = class_getInstanceVariable(UITextField.self, "_placeholderLabel")
        var placeholderLabel: UILabel? = nil
        if let ivar = ivar {
            placeholderLabel = object_getIvar(base, ivar) as? UILabel
        }
        placeholderLabel?.textColor = color
        placeholderLabel?.text = content
        placeholderLabel?.font = font
        return self
    }
    
    /*设置字体颜色*/
    @discardableResult
    func TextFieldTextColor(color:UIColor) -> Self {
        base.textColor = color
        return self
    }
    
    /*设置字体大小*/
    @discardableResult
    func TextFieldFont(fonts:UIFont) -> Self {
        base.font = fonts
        return self
    }
    
    /*字数限制*/
    @discardableResult
    func TextFieldWordLimit(count:Int) -> Self {
        base.wordLimit = count
        return self
    }
    
    /*正则*/ // 这个只是用于输入限制小数点有用 double(prefix: Int,suffix: Int)
    @discardableResult
    func TextFieldRegexs(regexs:RegexPattern) -> Self {
        base.regexs = [regexs]
        return self
    }
    
    /*这是数字键盘*/
    @discardableResult
    func TextFieldKeyBoardType() -> Self {
        base.keyboardType = .numberPad
        return self
    }
    
    /*清楚按键*/
    @discardableResult
    func TextFieldClearButtonMode() -> Self {
        base.clearButtonMode = .whileEditing
        return self
    }
    
    /*监听值的变化的方法*/
    @discardableResult
    func TextFieldChangeVolues(actions:Selector) -> Self{
        base.addTarget(self, action: actions, for: .editingChanged)
        return self
    }
    
    /*获取焦点*/
    @discardableResult
    func TextFieldBecomeFirstResponder() -> Self {
        base.becomeFirstResponder()
        return self
    }
    
    /*失去焦点*/
    @discardableResult
    func TextFieldResignFirstResponder() -> Self {
        base.resignFirstResponder()
        return self
    }
    
    /*设置光标颜色*/
    @discardableResult
    func tintColor(color:UIColor) -> Self{
        base.tintColor = color
        return self
    }
    
    /*水平对齐*/
    @discardableResult
    func TextFieldTextAlignment(value:NSTextAlignment) -> Self {
        base.textAlignment = value
        return self
    }
    
    /*设置边框样式为圆角矩形*/
    @discardableResult
    func TextFieldBorderStyleYJ() -> Self {
        base.borderStyle = UITextField.BorderStyle.roundedRect
        return self
    }
    
    /*修改圆角半径,边框粗细,颜色*/
    @discardableResult
    func TextFieldBorderRadiusWidthColor(radius:CGFloat,width:CGFloat,color:UIColor) -> Self {
        base.layer.masksToBounds = true
        base.layer.cornerRadius = radius  //圆角半径
        base.layer.borderWidth = width  //边框粗细
        base.layer.borderColor = color.cgColor //边框颜色
        return self
    }
    
    /*文字大小超过文本框长度时自动缩小字号，而不是隐藏显示省略号*/
    @discardableResult
    func TextFieldFontToFitWidth(min:CGFloat) -> Self {
        base.adjustsFontSizeToFitWidth = true  //当文字超出文本框宽度时，自动调整文字大小
        base.minimumFontSize = min  //最小可缩小的字号
        return self
    }
    
    /*设置背景图片*/
    @discardableResult
    func TextFieldBackgroundImage(name:String) -> Self {
        base.borderStyle = .none //先要去除边框样式
        base.background = UIImage(named:name)
        return self
    }
    
    /*键盘返回样式*/
    @discardableResult
    func TextFieldReturnKeyType(value:UIReturnKeyType) -> Self {
        /*
         .done //表示完成输入
         .go //表示完成输入，同时会跳到另一页
         .search //表示搜索
         .join //表示注册用户或添加数据
         .next //表示继续下一步
         .send //表示发送
         */
        base.returnKeyType = value
        return self
    }
 
}


