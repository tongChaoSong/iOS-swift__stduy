//
//  ToolClass.h
//  SwiftStudyBook
//
//  Created by TCS on 2022/9/15.
//  Copyright © 2022 tcs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToolClass : NSObject
///自动生成属性
+(void)createPropetyCode:(NSDictionary*)dict;
@end

NS_ASSUME_NONNULL_END
