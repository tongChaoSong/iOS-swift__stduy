//
//  ChainLayout.swift
//  sharesChonse
//
//  Created by 冯汉栩 on 2017/11/13.
//  Copyright © 2017年 fenghanxuCompany. All rights reserved.
//

import UIKit
import SnapKit
protocol ChainLayout {}
extension ChainLayout where Self: UIView {
    
    @discardableResult
    func hxConfig(_ config: (Self) -> Void) -> Self {
        config(self)
        return self
    }
    
}

extension UIView: ChainLayout {
    
    func hxAddSubView(toSuperView: UIView) -> Self {
        toSuperView.addSubview(self)
        
        return self
    }
    
    @discardableResult
    func hxLayout(snapKitMaker: (ConstraintMaker) -> Void) -> Self {
        self.snp.makeConstraints { (make) in
            snapKitMaker(make)
        }
        return self
    }
}
