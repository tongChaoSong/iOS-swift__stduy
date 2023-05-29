//
//  RouteToolClass.h
//  SwiftStudyBook
//
//  Created by 1998xxsq on 2023/5/26.
//  Copyright © 2023 tcs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    TCSRouterTypePush,
    TCSRouterTypePresent
} TCSRouterType;
@interface RouteToolClass : NSObject
/*
 params 格式
 NSDictionary *userInfo = @{
    @"class": @"BaseWkWebvc",
    @"property": @{
        @"url": @"https://www.jianshu.com/p/86ef3ca9810d",
    }
};
 */
+ (void)push:(NSDictionary *)params;


+(void)pushViewControllerName:(NSString *)vcName;

+(void)pushViewControllerName:(NSString *)vcName
                     animated:(BOOL)animated;

+(void)pushViewControllerName:(NSString *)vcName
                        param:(NSDictionary *)aParam;

+(void)pushViewControllerName:(NSString *)vcName
                        param:(NSDictionary *)aParam
                  routerBlock:(TCSRouterBlock)routerBlock;

+(void)pushViewControllerName:(NSString *)vcName
                        param:(NSDictionary *)aParam
                     animated:(BOOL)animated
                  routerBlock:(TCSRouterBlock)routerBlock;



@end

NS_ASSUME_NONNULL_END
