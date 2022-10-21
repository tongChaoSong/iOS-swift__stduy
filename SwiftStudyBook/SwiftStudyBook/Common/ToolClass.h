//
//  ToolClass.h
//  SwiftStudyBook
//
//  Created by TCS on 2022/9/15.
//  Copyright © 2022 tcs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToolClass : NSObject
///自动生成属性
+(void)createPropetyCode:(NSDictionary*)dict;

//自动解归档 登录信息
+ (void)saveUserInfo: (LoginInfo *)userInfo ;
+ (void)removeUserInfo:(LoginInfo *)userInfo ;
+ (LoginInfo *)readUserInfo ;
//获取当前控制器
+ (UIViewController *)getCurrentRootVC;

@end

NS_ASSUME_NONNULL_END
