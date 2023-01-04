//
//  UIView+ShadowRadiusSide.h
//  1998demo
//
//  Created by TCS on 2022/12/1.
//  Copyright © 2022 TCS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_OPTIONS(NSUInteger, BNShadowSide) {
    BNShadowSideNone   = 0,
    BNShadowSideTop    = 1 << 0,
    BNShadowSideLeft   = 1 << 1,
    BNShadowSideBottom = 1 << 2,
    BNShadowSideRight  = 1 << 3,
    BNShadowSideAll    = BNShadowSideTop | BNShadowSideLeft | BNShadowSideBottom | BNShadowSideRight
};
@interface UIView (ShadowRadiusSide)
/// 使用位枚举指定圆角位置
/// 通过在各个边画矩形来实现shadowpath，真正实现指那儿打那儿
/// @param shadowColor 阴影颜色
/// @param shadowOpacity 阴影透明度
/// @param shadowRadius 阴影半径
/// @param shadowSide 阴影位置
-(void)addShdowColor:(UIColor *)shadowColor
       shadowOpacity:(CGFloat)shadowOpacity
        shadowRadius:(CGFloat)shadowRadius
          shadowSide:(BNShadowSide)shadowSide;
@end

NS_ASSUME_NONNULL_END
