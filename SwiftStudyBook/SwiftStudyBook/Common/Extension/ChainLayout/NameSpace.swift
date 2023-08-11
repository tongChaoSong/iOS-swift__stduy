//
//  Namespace.swift
//  sharesChonse
//
//  Created by 冯汉栩 on 2017/11/14.
//  Copyright © 2017年 fenghanxuCompany. All rights reserved.
//

import UIKit

// 定义泛型类
public final class NameSpace<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

// 定义泛型协议
public protocol NameSpaceCompatible {
    associatedtype CompatibleType
    var hx: CompatibleType { get }
}

// 协议的扩展
public extension NameSpaceCompatible {

    public var hx: NameSpace<Self>{
        get { return NameSpace(self) }
    }
    
}

extension UILabel: NameSpaceCompatible {}
//
extension UIView: NameSpaceCompatible {}
//写UIButton继承这个协议要先写继承UIView先
extension UIButton: NameSpaceCompatible {}

//
//extension UIViewController: NameSpaceCompatible {}
//
extension UIImageView: NameSpaceCompatible {}
//
extension UITextField: NameSpaceCompatible {}
//
//extension UITextView: NameSpaceCompatible {}


