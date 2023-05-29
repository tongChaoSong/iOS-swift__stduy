//
//  BaseOCVC.h
//  SwiftStudyBook
//
//  Created by Apple on 2020/8/19.
//  Copyright © 2020 tcs. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BlockHeader.h"
typedef void(^TCSRouterBlock) (id backData);

@interface BaseOCVC : UIViewController
//@property (nonatomic,copy)VoidBlock tcs_RouterBlock;

@property (nonatomic,strong)TCSRouterBlock tcs_RouterBlock;
@end

