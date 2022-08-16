//
//  NSArray+TCSSafe.m
//  SwiftStudyBook
//
//  Created by TCS on 2022/8/16.
//  Copyright © 2022 tcs. All rights reserved.
//

#import "NSArray+TCSSafe.h"
#import <objc/runtime.h>
@implementation NSArray (TCSSafe)

+ (void)initialize {
    [super initialize];
    
    printf("class name is:%s \n", class_getName(self.class));
}
@end
