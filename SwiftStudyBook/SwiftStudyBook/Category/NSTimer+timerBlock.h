//
//  NSTimer+timerBlock.h
//  ZZCircleViewDemo
//
//  Created by iMac on 2016/12/22.
//  Copyright © 2016年 zhouxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (timerBlock)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)())block
                                       repeats:(BOOL)repeats;

+ (NSTimer *)scheduledWeakTimerWithTimeInterval:(NSTimeInterval)interval
                                         target:(id)aTarget
                                       selector:(SEL)aSelector
                                       userInfo:(id)userInfo
                                        repeats:(BOOL)repeats;

@end
