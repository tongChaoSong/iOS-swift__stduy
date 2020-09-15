//
//  UIColor+extend.h
//  InitSetting
//
//  Created by zengchao on 12-5-10.
//  Copyright 2011年 archermind. All rights reserved.
//


#import <Foundation/Foundation.h>

// 扩展UIColor类
@interface UIColor(extend)

// 将十六进制的颜色值转为objective-c的颜色
+ (instancetype)getColor:(NSString *) hexColor;

@end
