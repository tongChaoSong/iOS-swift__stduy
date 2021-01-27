//
//  FNPSDWebImageImageIOCoder.h
//  SwiftStudyBook
//
//  Created by Apple on 2021/1/27.
//  Copyright © 2021 tcs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNPSDWebImageCoder.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNPSDWebImageImageIOCoder : NSObject<FNPSDWebImageProgressiveCoder>
+ (nonnull instancetype)sharedCoder;

@end

NS_ASSUME_NONNULL_END
