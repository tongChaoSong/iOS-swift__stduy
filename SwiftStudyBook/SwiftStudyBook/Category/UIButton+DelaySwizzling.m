//
//  UIButton+DelaySwizzling.m
//  SwiftStudyBook
//
//  Created by TCS on 2022/8/31.
//  Copyright © 2022 tcs. All rights reserved.
//

#import "UIButton+DelaySwizzling.h"
#import <objc/runtime.h>
#import "Swzzling.h"

@interface UIButton()

// 重复点击间隔
@property (nonatomic, assign) NSTimeInterval tcs_acceptEventInterval;

@end
@implementation UIButton (DelaySwizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
//        - (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

        SEL originalSelector = @selector(sendAction:to:forEvent:);
//        SEL originalSelector = @selector(addTarget:action:forControlEvents:);
        SEL swizzledSelector = @selector(tcs_sendAction:to:forEvent:);

        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        BOOL didAddMethod = class_addMethod(class,
                                            originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));

        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
        
//        swizzling_exchangeMethod(class, originalSelector, swizzledSelector);
    });
}

- (void)tcs_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    NSLog(@"多次点击间隔设置");
    // 如果想要设置统一的间隔时间，可以在此处加上以下几句
    if (self.tcs_acceptEventInterval <= 0) {
        // 如果没有自定义时间间隔，则默认为 0.4 秒
        self.tcs_acceptEventInterval = 0.4;
    }
    
    // 是否小于设定的时间间隔
    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.tcs_acceptEventTime >= self.tcs_acceptEventInterval);
    
    // 更新上一次点击时间戳
    if (self.tcs_acceptEventInterval > 0) {
        self.tcs_acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    
    // 两次点击的时间间隔小于设定的时间间隔时，才执行响应事件
    if (needSendAction) {
        [self tcs_sendAction:action to:target forEvent:event];
    }
}

- (NSTimeInterval )tcs_acceptEventInterval{
    return [objc_getAssociatedObject(self, "UIControl_acceptEventInterval") doubleValue];
}

- (void)setTcs_acceptEventInterval:(NSTimeInterval)tcs_acceptEventInterval{
    objc_setAssociatedObject(self, "UIControl_acceptEventInterval", @(tcs_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval )tcs_acceptEventTime{
    return [objc_getAssociatedObject(self, "UIControl_acceptEventTime") doubleValue];
}

- (void)setTcs_acceptEventTime:(NSTimeInterval)tcs_acceptEventTime{
    objc_setAssociatedObject(self, "UIControl_acceptEventTime", @(tcs_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
