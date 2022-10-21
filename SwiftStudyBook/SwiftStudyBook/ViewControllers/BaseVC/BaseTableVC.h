//
//  BaseTableVC.h
//  SwiftStudyBook
//
//  Created by Apple on 2020/8/19.
//  Copyright © 2020 tcs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseOCVC.h"
#import "UITableView+ReloadDataSwizzling.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableVC : BaseOCVC

@property(nonatomic,strong)NSArray * mainTitleArr;
@property(nonatomic,strong)UITableView * mainTable;

@end

NS_ASSUME_NONNULL_END
