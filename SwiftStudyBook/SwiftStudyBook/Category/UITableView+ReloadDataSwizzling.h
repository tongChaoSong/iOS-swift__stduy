//
//  UITableView+ReloadDataSwizzling.h
//  SwiftStudyBook
//
//  Created by TCS on 2022/8/31.
//  Copyright © 2022 tcs. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef void(^RefreshHintLabelBlock)(NSString *hintString);


@interface UITableView (ReloadDataSwizzling)
@property (nonatomic, assign) BOOL firstReload;
@property (nonatomic, strong) UIView *placeholderView;
@property (nonatomic,   copy) void(^reloadBlock)(void);
//@property (nonatomic,   copy) RefreshHintLabelBlock reloadBlock;

@end

