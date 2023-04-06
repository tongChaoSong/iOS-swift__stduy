//
//  TCSTagViews.h
//  1998demo
//
//  Created by TCS on 2023/3/10.
//  Copyright © 2023 TCS. All rights reserved.
//

#import "BaseView.h"


@interface TCSTagViews : BaseView
typedef void(^itemClickBlock) (NSInteger index);

@property(nonatomic,strong)UIFont *btnFont;//先赋值；
@property(nonatomic,strong)UIColor *btnColor;//先赋值；

@property(nonatomic,assign)CGFloat tagInsetSpace;//标签内间距 (左右各间距)
@property(nonatomic,assign)CGFloat tagsLineSpace;//标签行间距
@property(nonatomic,assign)CGFloat tagsMargin;//标签之间的间距
@property(nonatomic,assign)CGFloat tagSpace;// 整体左右边距

@property(nonatomic,strong)NSArray *tagsArray; // 文字标签数组

@property(nonatomic,assign)CGFloat totalH; //返回总高度

-(instancetype)initWithFrame:(CGRect)frame ItemClick:(itemClickBlock)click;

@end

