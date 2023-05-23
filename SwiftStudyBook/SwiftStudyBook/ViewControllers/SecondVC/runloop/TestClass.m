//
//  TestClass.m
//  SwiftStudyBook
//
//  Created by 1998xxsq on 2023/5/23.
//  Copyright © 2023 tcs. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass

//+(void)classtest{
//    NSLog(@"类方法调用");
//    
//}
//-(void)classtest{
//    NSLog(@"实例方法调用");
//
//}
//void EatFunction( id self, SEL _cmd, NSString *food) {
//    NSLog(@"-----动态拦截----%@",food);
//}
void EatFunction( id self, SEL _cmd) {
    NSLog(@"-----动态拦截成功----");
}
+(BOOL)resolveInstanceMethod:(SEL)sel{
    if(sel == @selector(classtest)){
        NSLog(@"resolveInstanceMethod");
        BOOL isAdd = class_addMethod(TestClass.class, @selector(classtest), (IMP)EatFunction, "v@:@");

        return isAdd;
    }else{
        return [super resolveInstanceMethod:sel];

    }
}
+(BOOL)resolveClassMethod:(SEL)sel{
    if(sel == @selector(classtest)){
        NSLog(@"resolveClassMethod");
        return NO;
    }else{
        return [super resolveClassMethod:sel];

    }
}
-(id)forwardingTargetForSelector:(SEL)aSelector{
    
    return [super forwardingTargetForSelector:aSelector];
    
}
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    
}

@end
