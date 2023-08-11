//
//  StringCustom.swift
//  sharesChonse
//
//  Created by 冯汉栩 on 2017/11/14.
//  Copyright © 2017年 fenghanxuCompany. All rights reserved.
//

/*
 _ = UILabel()
 .hxAddSubView(toSuperView: view)
 .hxLayout { (make) in
 make.center.equalToSuperview()
 make.width.equalTo(100)
 }
 .hxConfig { (label) in
 label.hx
 .LabelBackgroungColor(color: Color.nonActivated)
 .LabelColor(color: Color.blue)
 .LabelTextAlignment(textAlignment: .center)
 .LabelTitle(title: "successqwe")
 }
 */

import UIKit

extension NameSpace where Base == UILabel {
    
    /**标题颜色**/
    @discardableResult
    func LabelColor(color: UIColor) -> Self {
        base.tintColor = color
        return self
    }
    /**背景颜色**/
    @discardableResult
    func LabelBackgroungColor(color: UIColor) -> Self {
        base.backgroundColor = color
        return self
    }
    /**文字大小**/
    @discardableResult
    func LabelFont(font: UIFont) -> Self{
        base.font = font
        return self
    }
    /**标题内容**/
    @discardableResult
    func LabelTitle(title: String) -> Self {
        base.text = title
        return self
    }
    /**对齐方法**/
    @discardableResult
    func LabelTextAlignment(textAlignment: NSTextAlignment) -> Self {
        base.textAlignment = textAlignment
        return self
    }
    
    /**对文字过长时的省略方式**/
    @discardableResult
    func LabelLineBreakMode(mode: NSLineBreakMode) -> Self {
        /*
         .byTruncatingTail  //隐藏尾部并显示省略号
         .byTruncatingMiddle  //隐藏中间部分并显示省略号
         .byTruncatingHead  //隐藏头部并显示省略号
         .byClipping  //截去多余部分也不显示省略号
         */
        base.lineBreakMode = mode
        return self
    }
    
    /**限制Label的行数**/
    @discardableResult
    func LabelNumberOfLines(count: Int) -> Self {
        base.numberOfLines = count
        return self
    }
    
    /**文字大小自适应标签宽度**/
    @discardableResult
    func LabelAdjustsFontSizeToFitWidth(state: Bool) -> Self {
        base.adjustsFontSizeToFitWidth = state
        return self
    }
    
    
}


