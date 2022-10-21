//
//  Person.m
//  SwiftStudyBook
//
//  Created by Apple on 2021/9/2.
//  Copyright © 2021 tcs. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

void functionForMethod(id self, SEL _cmd)
{
 NSLog(@"未崩溃调用实例New测试方法");
}
Class functionForClassMethod(id self, SEL _cmd)
{
 NSLog(@"未崩溃调用classNew测试方法");
 return [Person class];
}
@implementation Person

+(void)load{
    NSLog(@"loadloadload");
}
+(void)initialize{
    NSLog(@"initializeinitialize");
}
+(BOOL)resolveInstanceMethod:(SEL)sel{
    NSLog(@"调用了实例方法");
    NSString * selString = NSStringFromSelector(sel);
    if ([selString isEqualToString:@"test"]) {

        class_addMethod(self, @selector(test), (IMP)functionForMethod, "v@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
+(BOOL)resolveClassMethod:(SEL)sel{
    NSLog(@"调用了类方法");
    NSString * selString = NSStringFromSelector(sel);

    if ([selString isEqualToString:@"test"]) {
        Class metaClsaa = objc_getClass("Person");
        class_addMethod(metaClsaa, @selector(newTest), (IMP)functionForClassMethod, "v@:");
        return YES;
    }
    return [super resolveClassMethod:sel];
}
-(id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@"调用了备用接受者");
    return [super forwardingTargetForSelector:aSelector];
}
//-(void)test{
//    NSLog(@"调用测试方法");
//}
//+(Person*)newTest{
//    NSLog(@"调用new测试方法");
//}
-(instancetype)init{
    if ([super init]) {
        //(1)获取类的属性及属性对应的类型
        NSMutableArray * keys = [NSMutableArray array];
        NSMutableArray * attributes = [NSMutableArray array];
        /*
         * 例子
         * name = value3 attribute = T@"NSString",C,N,V_value3
         * name = value4 attribute = T^i,N,V_value4
         */
        unsigned int outCount;
        objc_property_t * properties = class_copyPropertyList([self class], &outCount);
        for (int i = 0; i < outCount; i ++) {
            objc_property_t property = properties[i];
            //通过property_getName函数获得属性的名字
            NSString * propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            NSLog(@"当前属性是==%@",propertyName);
            [keys addObject:propertyName];
            //通过property_getAttributes函数可以获得属性的名字和@encode编码
            NSString * propertyAttribute = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            [attributes addObject:propertyAttribute];
        }
        //立即释放properties指向的内存
        free(properties);
        
//        //(2)根据类型给属性赋值
//        for (NSString * key in keys) {
//            if ([dict valueForKey:key] == nil) continue;
//            [self setValue:[dict valueForKey:key] forKey:key];
//        }
    }
    
    return  self;
}
@end
