//
//  NSArray+Safe.m
//  NSArrayTest
//
//  Created by tcs on 2017/11/28.
//  Copyright © 2017年 tcs. All rights reserved.
//

#import "NSArray+Safe.h"
#import "Swzzling.h"

@implementation NSArray (Safe)


+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzling_exchangeMethod(objc_getClass("__NSArray0"), @selector(objectAtIndex:), @selector(emptyArray_objectAtIndex:));
        swizzling_exchangeMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:), @selector(arrayI_objectAtIndex:));
        swizzling_exchangeMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:), @selector(arrayM_objectAtIndex:));
        swizzling_exchangeMethod(objc_getClass("__NSSingleObjectArrayI"), @selector(objectAtIndex:), @selector(singleObjectArrayI_objectAtIndex:));
        
        swizzling_exchangeMethod(objc_getClass("__NSArray0"), @selector(objectAtIndexedSubscript:), @selector(emptyArray_objectAtIndexedSubscript:));
        swizzling_exchangeMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndexedSubscript:), @selector(arrayI_objectAtIndexedSubscript:));
        swizzling_exchangeMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndexedSubscript:), @selector(arrayM_objectAtIndexedSubscript:));
        swizzling_exchangeMethod(objc_getClass("__NSSingleObjectArrayI"), @selector(objectAtIndex:), @selector(singleObjectArrayI_objectAtIndexedSubscript:));
        
        /** 可变数组 */
        swizzling_exchangeMethod(objc_getClass("__NSArrayM"), @selector(insertObject:atIndex:), @selector(mutableInsertObject:atIndex:));
        
        
    });
    
    
}

/**
 插入
 */
- (void)mutableInsertObject:(id)object atIndex:(NSUInteger)index{
    if (object) {
        [self mutableInsertObject:object atIndex:index];
    }else{
        NSLog(@"插入值时: 元素类型为 nil, %s",__FUNCTION__);
        // [self mutableInsertObject:[NSNull null] atIndex:index];
    }
}

#pragma MARK -  - (id)objectAtIndex:
- (id)emptyArray_objectAtIndex:(NSUInteger)index{
    NSLog(@"数组越界值时: 元素类型为 nil, %s",__FUNCTION__);
    return nil;
    
}

- (id)arrayI_objectAtIndex:(NSUInteger)index{
    if(index < self.count){
        return [self arrayI_objectAtIndex:index];
    }
    NSLog(@"数组越界值时: 元素类型为 nil, %s",__FUNCTION__);

    return nil;
}

- (id)arrayM_objectAtIndex:(NSUInteger)index{
    if(index < self.count){
        return [self arrayM_objectAtIndex:index];
    }
    NSLog(@"数组越界值时: 元素类型为 nil, %s",__FUNCTION__);

    return nil;
}

- (id)singleObjectArrayI_objectAtIndex:(NSUInteger)index{
    if(index < self.count){
        return [self singleObjectArrayI_objectAtIndex:index];
    }
    NSLog(@"数组越界值时: 元素类型为 nil, %s",__FUNCTION__);

    return nil;
}

#pragma MARK -  - (id)objectAtIndexedSubscript:
- (id)emptyArray_objectAtIndexedSubscript:(NSUInteger)index{
    NSLog(@"数组越界值时: 元素类型为 nil, %s",__FUNCTION__);

    return nil;
}

- (id)arrayI_objectAtIndexedSubscript:(NSUInteger)index{
    if(index < self.count){
        return [self arrayI_objectAtIndex:index];
    }
    NSLog(@"数组越界值时: 元素类型为 nil, %s",__FUNCTION__);

    return nil;
}

- (id)arrayM_objectAtIndexedSubscript:(NSUInteger)index{
    if(index < self.count){
        return [self arrayM_objectAtIndex:index];
    }
    NSLog(@"数组越界值时: 元素类型为 nil, %s",__FUNCTION__);

    return nil;
}

- (id)singleObjectArrayI_objectAtIndexedSubscript:(NSUInteger)index{
    if(index < self.count){
        return [self singleObjectArrayI_objectAtIndexedSubscript:index];
    }
    NSLog(@"数组越界值时: 元素类型为 nil, %s",__FUNCTION__);

    return nil;
}

@end
