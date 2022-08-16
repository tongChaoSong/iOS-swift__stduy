//
//  NSTimer+timerBlock.m
//  ZZCircleViewDemo
//
//  Created by iMac on 2016/12/22.
//  Copyright © 2016年 zhouxing. All rights reserved.
//

#import "NSTimer+timerBlock.h"

// 中间类
@interface TimerWeakObject : NSObject
@property (nonatomic, weak) id target;//弱引用target
@property (nonatomic, assign) SEL selector;//声明timer回调
@property (nonatomic, weak) NSTimer *timer;//弱引用timer定时器
// 用于timer定时器的注销
- (void)fire:(NSTimer *)timer;
@end
 
@implementation TimerWeakObject
 
- (void)fire:(NSTimer *)timer
{
        
    // 若timer的引用者存在，就回调selector；
    if (self.target) {
        if ([self.target respondsToSelector:self.selector]) {
            [self.target performSelector:self.selector withObject:timer.userInfo];
        }
    }
    // 若timer的引用者不存在，就销毁timer
    else{
        [self.timer invalidate];
    }
}
 
@end
 
 



@implementation NSTimer (timerBlock)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)())block repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(blockInvoke:) userInfo:[block copy] repeats:repeats];
}


+ (void)blockInvoke:(NSTimer *)timer {
    void (^ block)() = timer.userInfo;
    if (block) {
        block();
    }
}


//自定义初始化方法，参数跟系统方法scheduledTimerWithTimeInterval一致
+ (NSTimer *)scheduledWeakTimerWithTimeInterval:(NSTimeInterval)interval
                                         target:(id)aTarget
                                       selector:(SEL)aSelector
                                       userInfo:(id)userInfo
                                        repeats:(BOOL)repeats
{
    // 实现中间类对象
    TimerWeakObject *object = [[TimerWeakObject alloc] init];
    object.target = aTarget;
    object.selector = aSelector;
    //初始化弱引用对象timer，并将selector方法指向中间对象的-(void)fire:方法
    object.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:object selector:@selector(fire:) userInfo:userInfo repeats:repeats];
    
    return object.timer;
}

@end
