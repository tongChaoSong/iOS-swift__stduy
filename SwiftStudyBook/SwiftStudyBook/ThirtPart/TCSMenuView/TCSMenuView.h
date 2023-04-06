//
//  TCSMenuView.h
//  1998demo
//
//  Created by TCS on 2023/3/7.
//  Copyright © 2023 TCS. All rights reserved.
//

#import "BaseView.h"
@class TCSMenuView;
#import "TCSMenuItem.h"

typedef NS_ENUM(NSUInteger, TCSMenuViewStyle) {
    TCSMenuViewStyleDefault,      // 默认
    TCSMenuViewStyleLine,         // 带下划线 (若要选中字体大小不变，设置选中和非选中大小一样即可)
    TCSMenuViewStyleTriangle,     // 三角形 (progressHeight 为三角形的高, progressWidths 为底边长)
    TCSMenuViewStyleCircle,       // 圆形
    TCSMenuViewStyleFlood,        // 涌入效果 (填充)
    TCSMenuViewStyleFloodHollow,  // 涌入效果 (空心的)
    TCSMenuViewStyleSegmented,    // 涌入带边框,即网易新闻选项卡
};
// 原先基础上添加了几个方便布局的枚举，更多布局格式可以通过设置 `itemsMargins` 属性来自定义
// 以下布局均只在 item 个数较少的情况下生效，即无法滚动 MenuView 时.
typedef NS_ENUM(NSUInteger, TCSMenuViewLayoutMode) {
    TCSMenuViewLayoutModeScatter, // 默认的布局模式, item 会均匀分布在屏幕上，呈分散状
    TCSMenuViewLayoutModeLeft,    // Item 紧靠屏幕左侧
    TCSMenuViewLayoutModeRight,   // Item 紧靠屏幕右侧
    TCSMenuViewLayoutModeCenter,  // Item 紧挨且居中分布
};
@protocol TCSMenuViewDelegate <NSObject>
@optional
- (BOOL)menuView:(TCSMenuView *)menu shouldSelesctedIndex:(NSInteger)index;
- (void)menuView:(TCSMenuView *)menu didSelectedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex;
- (CGFloat)menuView:(TCSMenuView *)menu widthForItemAtIndex:(NSInteger)index;
- (CGFloat)menuView:(TCSMenuView *)menu itemMarginAtIndex:(NSInteger)index;
- (UIFont *)menuView:(TCSMenuView *)menu titleFontForState:(TCSMenuItemState)state atIndex:(NSInteger)index;
- (UIColor *)menuView:(TCSMenuView *)menu titleColorForState:(TCSMenuItemState)state atIndex:(NSInteger)index;
- (void)menuView:(TCSMenuView *)menu didLayoutItemFrame:(TCSMenuItem *)menuItem atIndex:(NSInteger)index;

//点击第一次后不在进去
- (void)menuViewFisrtView:(TCSMenuView *)menu atIndex:(NSInteger)index;


@end

@protocol TCSMenuViewDataSource <NSObject>
@required
- (NSInteger)numbersOfTitlesInMenuView:(TCSMenuView *)menu;
- (NSString *)menuView:(TCSMenuView *)menu titleAtIndex:(NSInteger)index;

@optional
/**
 *  角标 (例如消息提醒的小红点) 的数据源方法，在 TCSPageController 中实现这个方法来为 menuView 提供一个 badgeView
    需要在返回的时候同时设置角标的 frame 属性，该 frame 为相对于 menuItem 的位置
 *
 *  @param index 角标的序号
 *
 *  @return 返回一个设置好 frame 的角标视图
 */
- (UIView *)menuView:(TCSMenuView *)menu badgeViewAtIndex:(NSInteger)index;

/**
 *  用于定制 TCSMenuItem，可以对传出的 initialMenuItem 进行修改定制，也可以返回自己创建的子类，需要注意的是，此时的 item 的 frame 是不确定的，所以请勿根据此时的 frame 做计算！
    如需根据 frame 修改，请使用代理
 *
 *  @param menu            当前的 menuView，frame 也是不确定的
 *  @param initialMenuItem 初始化完成的 menuItem
 *  @param index           Item 所属的位置;
 *
 *  @return 定制完成的 MenuItem
 */
- (TCSMenuItem *)menuView:(TCSMenuView *)menu initialMenuItem:(TCSMenuItem *)initialMenuItem atIndex:(NSInteger)index;


//设置自定义view
- (UIView*)menuView:(TCSMenuView *)menu item:(UIView *)bgView cellForRowAtIndexPath:(NSInteger)index;

- (CALayer *)corlay:(CALayer *)layer;

@end
@interface TCSMenuView : BaseView
@property (nonatomic, assign) TCSMenuViewStyle style;
@property (nonatomic, assign) TCSMenuViewLayoutMode layoutMode;

@property (nonatomic, weak) id<TCSMenuViewDelegate> delegate;
@property (nonatomic, weak) id<TCSMenuViewDataSource> dataSource;

//1 == 上边左右
@property (nonatomic, assign) NSInteger ratype;

@property (nonatomic, assign) CGFloat titleHg;
@property (nonatomic, assign) CGFloat titleScrollerWid;

@property (nonatomic, assign) CGFloat contentMargin;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat progressViewBottomSpace;
/** 进度条的速度因数，默认为 15，越小越快， 大于 0 */
@property (nonatomic, assign) CGFloat speedFactor;

-(void)reloadData;

- (void)selectItemAtIndex:(NSInteger)index withAnimation:(BOOL)animation;

@end

