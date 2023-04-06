//
//  TCSMenuItem.h
//  1998demo
//
//  Created by TCS on 2023/3/7.
//  Copyright © 2023 TCS. All rights reserved.
//

#import "BaseView.h"

@class TCSMenuItem;

typedef NS_ENUM(NSUInteger, TCSMenuItemState) {
    TCSMenuItemStateSelected,
    TCSMenuItemStateNormal,
};

@protocol TCSMenuItemDelegate <NSObject>
@optional
- (void)didPressedMenuItem:(TCSMenuItem *)menuItem;
@end

@interface TCSMenuItem : UILabel


@property (nonatomic, assign) CGFloat rate;           ///> 设置 rate, 并刷新标题状态 (0~1)
@property (nonatomic, assign) CGFloat normalSize;     ///> Normal状态的字体大小，默认大小为15
@property (nonatomic, assign) CGFloat selectedSize;   ///> Selected状态的字体大小，默认大小为18
@property (nonatomic, strong) UIFont *normalFont;     ///> Normal状态的字体大小，默认大小为15
@property (nonatomic, strong) UIFont *selectedFont;   ///> Selected状态的字体大小，默认大小为18
@property (nonatomic, strong) UIColor *normalColor;   ///> Normal状态的字体颜色，默认为黑色 (可动画)
@property (nonatomic, strong) UIColor *selectedColor; ///> Selected状态的字体颜色，默认为红色 (可动画)
@property (nonatomic, assign) CGFloat speedFactor;    ///> 进度条的速度因数，默认 15，越小越快, 必须大于0
@property (nonatomic, nullable, weak) id<TCSMenuItemDelegate> delegate;
@property (nonatomic, assign, readonly) BOOL selected;

@property (nonatomic, assign) BOOL alerdySlelected;
@property (nonatomic, assign) NSInteger ratype;

- (void)setSelected:(BOOL)selected withAnimation:(BOOL)animation;
@end

