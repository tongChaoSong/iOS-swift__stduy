//
//  MYCustumText.m
//  SwiftStudyBook
//
//  Created by Apple on 2021/11/10.
//  Copyright © 2021 tcs. All rights reserved.
//

#import "MYCustumText.h"

@implementation MYCustumText

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UIColor *color = [UIColor redColor];
    [color set];

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 200)];
    [path addQuadCurveToPoint:CGPointMake(250, 200) controlPoint:CGPointMake(50, 40)];

    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;

    [path stroke];
    
//    UIColor *color = [UIColor redColor];
//    [color set]; //设置线条颜色
//
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(30, 30)];
//    [path addLineToPoint:CGPointMake(200, 80)];
//    [path addLineToPoint:CGPointMake(150, 150)];
//
//    path.lineWidth = 5.0;
//    path.lineCapStyle = kCGLineCapRound; //终点处理
//    path.lineJoinStyle = kCGLineJoinRound; //线条拐角
//
//    [path stroke];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawText:context];
//
//    /*画贝塞尔曲线*/
//    //二次曲线
//    CGContextMoveToPoint(context, 120, 300);//设置Path的起点
//    CGContextAddQuadCurveToPoint(context,190, 310, 120, 390);//设置贝塞尔曲线的控制点坐标和终点坐标
//    CGContextStrokePath(context);
//    //三次曲线函数
//    CGContextMoveToPoint(context, 200, 300);//设置Path的起点
//    CGContextAddCurveToPoint(context,250, 280, 250, 400, 280, 300);//设置贝塞尔曲线的控制点坐标和控制点坐标终点坐标
//    CGContextStrokePath(context);

}
#pragma mark 绘制文字
- (void)drawText:(CGContextRef)context
{
    //英文中通常按照单词换行
    NSString *string = @"hello world! hello world! hello world! hello world! hello world! hello world! hello world! hello world! hello world! hello world!";
    //查看所有字体
    NSLog(@"%@",[UIFont familyNames]);
    UIFont *fount = [UIFont fontWithName:@"Mishafi" size:20];
    NSDictionary *dict  =@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor redColor]};
//    [string drawInRect:CGRectMake(10, 10, 400, 100)withFont:fount lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    [string drawInRect:CGRectMake(10, 10, SCREEN_WIDTH - 20, 100) withAttributes:dict];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
