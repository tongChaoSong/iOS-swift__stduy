//
//  ScrollerTwoLabe.h
//  SwiftStudyBook
//
//  Created by TCS on 2023/2/23.
//  Copyright © 2023 tcs. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScrollerTwoLabe : BaseView
@property (nonatomic, strong) NSMutableArray *dataSource;
- (void)showNext;
- (void)removeTimer;
- (void)addTimer;
@end

NS_ASSUME_NONNULL_END
