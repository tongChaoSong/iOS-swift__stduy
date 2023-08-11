//
//  UIImageLayout.swift
//  sharesChonse
//
//  Created by 冯汉栩 on 2017/11/20.
//  Copyright © 2017年 fenghanxuCompany. All rights reserved.
//

/*
 let imageView = UIImageView().hxAddSubView(toSuperView: view).hxLayout { (make) in
 make.centerX.equalToSuperview()
 make.centerY.equalToSuperview().offset(-100)
 make.width.height.equalTo(100)
 }.hxConfig { (imageView) in
 imageView.hx
 .ImageViewName(name: "SuchAs")
 .ImageViewContentMode()
 }
 */

import UIKit

extension NameSpace where Base == UIImageView {
    
    /*设置文字内容*/
    @discardableResult
    func ImageViewName(name:String) -> Self {
        base.image = UIImage(named:name) ?? UIImage()
        return self
    }
    
    /*保持图片比例*/
    @discardableResult
    func ImageViewContentMode() -> Self {
        base.contentMode = .scaleAspectFit
        return self
    }
    
}
