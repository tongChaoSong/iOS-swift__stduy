//
//  UIView+ShadowRadiusSide.m
//  1998demo
//
//  Created by TCS on 2022/12/1.
//  Copyright © 2022 TCS. All rights reserved.
//

#import "UIView+ShadowRadiusSide.h"

@implementation UIView (ShadowRadiusSide)
-(void)addShdowColor:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(BNShadowSide)shadowSide{
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowOpacity = shadowOpacity;
    
    // 默认值 0 -3
    // 使用默认值即可，这个各个边都要设置阴影的，自己调反而效果不是很好。
    //    self.layer.shadowOffset = CGSizeMake(0, -3);
    
    CGRect bounds = self.layer.bounds;
    CGFloat maxX = CGRectGetMaxX(bounds);
    CGFloat maxY = CGRectGetMaxY(bounds);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    if (shadowSide & BNShadowSideTop) {
        // 上边
        [path moveToPoint:CGPointZero];
        [path addLineToPoint:CGPointMake(0, -shadowRadius)];
        [path addLineToPoint:CGPointMake(maxX, -shadowRadius)];
        [path addLineToPoint:CGPointMake(maxX, 0)];
    }
    
    if (shadowSide & BNShadowSideRight) {
        // 右边
        [path moveToPoint:CGPointMake(maxX, 0)];
        [path addLineToPoint:CGPointMake(maxX,maxY)];
        [path addLineToPoint:CGPointMake(maxX + shadowRadius, maxY)];
        [path addLineToPoint:CGPointMake(maxX + shadowRadius, 0)];
    }
    
    if (shadowSide & BNShadowSideBottom) {
        // 下边
        [path moveToPoint:CGPointMake(0, maxY)];
        [path addLineToPoint:CGPointMake(maxX,maxY)];
        [path addLineToPoint:CGPointMake(maxX, maxY + shadowRadius)];
        [path addLineToPoint:CGPointMake(0, maxY + shadowRadius)];
    }
    
    if (shadowSide & BNShadowSideLeft) {
        // 左边
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(-shadowRadius,0)];
        [path addLineToPoint:CGPointMake(-shadowRadius, maxY)];
        [path addLineToPoint:CGPointMake(0, maxY)];
    }
    
    self.layer.shadowPath = path.CGPath;
}
@end
