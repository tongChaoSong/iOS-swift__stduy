//
//  ScrollerLabel.h
//  SwiftStudyBook
//
//  Created by TCS on 2023/2/23.
//  Copyright © 2023 tcs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SHRollingDirectionUp,
    SHRollingDirectionDown,
} SHRollingDirection;

@interface ScrollerLabel : UIScrollView

/**
 设置图片和间隔时间
 @param dataArray 文字数组
 @param time 间隔时间,0代表不启动定时器(自动创建和销毁定时器)
 @param direction 滚动方向
 */
- (void)setTextArray:(NSArray <NSString *>*)dataArray InteralTime:(NSTimeInterval)time Direction:(SHRollingDirection)direction;
/*!
 *点击回调
 */
@property (nonatomic , copy) DidSlectIndex didSelect;


- (void)pauseTimer ;
-(void)removGcdTimer;
@end

