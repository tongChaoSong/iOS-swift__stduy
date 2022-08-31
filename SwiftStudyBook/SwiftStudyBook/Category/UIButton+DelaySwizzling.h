//
//  UIButton+DelaySwizzling.h
//  SwiftStudyBook
//
//  Created by TCS on 2022/8/31.
//  Copyright © 2022 tcs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (DelaySwizzling)

@property (nonatomic, assign) NSTimeInterval tcs_acceptEventTime;

@end

NS_ASSUME_NONNULL_END
