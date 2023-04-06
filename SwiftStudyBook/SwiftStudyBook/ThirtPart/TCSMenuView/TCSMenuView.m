//
//  TCSMenuView.m
//  1998demo
//
//  Created by TCS on 2023/3/7.
//  Copyright © 2023 TCS. All rights reserved.
//
#define TCSMENUITEM_TAG_OFFSET 6250
#define TCSBADGEVIEW_TAG_OFFSET 1212
#define TCSDEFAULT_VAULE(value, defaultValue) (value != TCSUNDEFINED_VALUE ? value : defaultValue)
#import "TCSMenuView.h"
#import "UIView+Extension.h"
@interface TCSMenuView()<TCSMenuItemDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;


@property (nonatomic, strong) UIScrollView *bgViewscrollView;

@property (nonatomic, weak) TCSMenuItem *selItem;
@property (nonatomic, strong) NSMutableArray *frames;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, readonly) NSInteger titlesCount;
@end
@implementation TCSMenuView

- (NSMutableArray *)frames {
    if (_frames == nil) {
        _frames = [NSMutableArray array];
    }
    return _frames;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.progressViewCornerRadius = TCSUNDEFINED_VALUE;
//        self.progressHeight = TCSUNDEFINED_VALUE;
        self.selectIndex = 0;
    }
    return self;
}
-(void)setRatype:(NSInteger)ratype{
    _ratype = ratype;
    switch (ratype) {
        case 1:
        {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.scrollView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(12, 12)];
            CAShapeLayer*maskLayer = [[CAShapeLayer alloc]init];
            //设置大
            maskLayer.frame= self.scrollView.bounds;
            //设置图形样子
            maskLayer.path= maskPath.CGPath;
            self.scrollView.layer.mask= maskLayer;
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (self.scrollView) { return; }
    
    [self addScrollView];
    [self addItems];
//    [self makeStyle];
//    [self addBadgeViews];
//    [self resetSelectionIfNeeded];
}
-(void)reloadData{
    if (self.titleScrollerWid > 0) {
        self.scrollView.width = self.titleScrollerWid;
    }
    if (self.titleHg > 0) {
        self.scrollView.height = self.titleHg;
        self.bgViewscrollView.height =  self.height - self.scrollView.height;
    }
//    if (self.ratype == 1) {
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.scrollView.bounds byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(12, 12)];
//        CAShapeLayer*maskLayer = [[CAShapeLayer alloc]init];
//        //设置大
//        maskLayer.frame= self.scrollView.bounds;
//        //设置图形样子
//        maskLayer.path= maskPath.CGPath;
//        self.scrollView.layer.mask= maskLayer;
//    }
    [self.frames removeAllObjects];
//    [self.progressView removeFromSuperview];
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.bgViewscrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self addItems];
}

- (void)addScrollView {
    CGFloat width = self.frame.size.width - self.contentMargin * 2;
    CGFloat height = 50;
    CGRect frame = CGRectMake(self.contentMargin, 0, width, height);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator   = NO;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.scrollsToTop = NO;
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    
    CGFloat bgwidth = self.width;
    CGFloat bghg = self.height - height;
    CGRect bgframe = CGRectMake(0, CGRectGetMaxY(scrollView.frame), bgwidth, bghg);
    
    UIScrollView *bgscrollView = [[UIScrollView alloc] initWithFrame:bgframe];
    bgscrollView.showsHorizontalScrollIndicator = NO;
    bgscrollView.showsVerticalScrollIndicator   = NO;
    bgscrollView.backgroundColor = [UIColor whiteColor];
    bgscrollView.scrollsToTop = NO;
    bgscrollView.pagingEnabled = true;
    bgscrollView.delegate = self;
    if (@available(iOS 11.0, *)) {
        bgscrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:bgscrollView];
    self.bgViewscrollView = bgscrollView;
    
}
-(void)addItems{
    [self calculateItemFrames];
    
    for (int i = 0; i < self.titlesCount; i++) {
        CGRect frame = [self.frames[i] CGRectValue];
        TCSMenuItem *item = [[TCSMenuItem alloc] initWithFrame:frame];
        item.tag = (i + TCSMENUITEM_TAG_OFFSET);
        item.delegate = self;
        item.text = [self.dataSource menuView:self titleAtIndex:i];
        item.textAlignment = NSTextAlignmentCenter;
        item.userInteractionEnabled = YES;
        item.backgroundColor = [UIColor clearColor];
        item.normalFont    = [self sizeForState:TCSMenuItemStateNormal atIndex:i];
        item.selectedFont  = [self sizeForState:TCSMenuItemStateSelected atIndex:i];
        item.normalColor   = [self colorForState:TCSMenuItemStateNormal atIndex:i];
        item.selectedColor = [self colorForState:TCSMenuItemStateSelected atIndex:i];
        item.speedFactor   = self.speedFactor;
        if ([self.dataSource respondsToSelector:@selector(menuView:initialMenuItem:atIndex:)]) {
            item = [self.dataSource menuView:self initialMenuItem:item atIndex:i];
        }
        if (i == 0) {
            [item setSelected:YES withAnimation:NO];
            self.selItem = item;
            
            if ([self.delegate respondsToSelector:@selector(menuViewFisrtView:atIndex:)]) {
                [self.delegate menuViewFisrtView:self atIndex:i];
            }
            item.alerdySlelected = YES;
            
            if (self.ratype == 1) {
                UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:item.bounds byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(12, 12)];
                CAShapeLayer*maskLayer = [[CAShapeLayer alloc]init];
                //设置大
                maskLayer.frame= item.bounds;
                //设置图形样子
                maskLayer.path= maskPath.CGPath;
                item.layer.mask= maskLayer;
            }
        } else {
            [item setSelected:NO withAnimation:NO];
        }
        [self.scrollView addSubview:item];
        
        
        //添加视图
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(self.width * i, 0, self.width, self.bgViewscrollView.height)];
        UIColor * randomColor= [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        bgView.backgroundColor = randomColor;
        
        if ([self.dataSource respondsToSelector:@selector(menuView:item:cellForRowAtIndexPath:)]) {
            bgView = [self.dataSource menuView:self item:bgView cellForRowAtIndexPath:i];
        }
        if (bgView == nil) {
            bgView = [[UIView alloc]initWithFrame:CGRectMake(self.width * i, 0, self.width, self.bgViewscrollView.height)];
            UIColor * randomColor= [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
            bgView.backgroundColor = randomColor;
        }
        [self.bgViewscrollView addSubview:bgView];
    }
    
    
}

// 计算所有item的frame值，主要是为了适配所有item的宽度之和小于屏幕宽的情况
// 这里与后面的 `-addItems` 做了重复的操作，并不是很合理
- (void)calculateItemFrames {
    CGFloat contentWidth = [self itemMarginAtIndex:0];
    CGFloat itemH = 50.0;
    if (self.titleHg) {
        itemH = self.titleHg;
    }
    for (int i = 0; i < self.titlesCount; i++) {
        CGFloat itemW = 60.0;
        if ([self.delegate respondsToSelector:@selector(menuView:widthForItemAtIndex:)]) {
            itemW = [self.delegate menuView:self widthForItemAtIndex:i];
        }
        CGRect frame = CGRectMake(contentWidth, 0, itemW, itemH);
        // 记录frame
        [self.frames addObject:[NSValue valueWithCGRect:frame]];
        contentWidth += itemW + [self itemMarginAtIndex:i+1];
    }
    // 如果总宽度小于屏幕宽,重新计算frame,为item间添加间距
    if (contentWidth < self.scrollView.frame.size.width) {
        CGFloat distance = self.scrollView.frame.size.width - contentWidth;
        CGFloat (^shiftDis)(int);
        switch (self.layoutMode) {
            case TCSMenuViewLayoutModeScatter: {
                CGFloat gap = distance / (self.titlesCount + 1);
                shiftDis = ^CGFloat(int index) { return gap * (index + 1); };
                break;
            }
            case TCSMenuViewLayoutModeLeft: {
                shiftDis = ^CGFloat(int index) { return 0.0; };
                break;
            }
            case TCSMenuViewLayoutModeRight: {
                shiftDis = ^CGFloat(int index) { return distance; };
                break;
            }
            case TCSMenuViewLayoutModeCenter: {
                shiftDis = ^CGFloat(int index) { return distance / 2; };
                break;
            }
        }
        for (int i = 0; i < self.frames.count; i++) {
            CGRect frame = [self.frames[i] CGRectValue];
            frame.origin.x += shiftDis(i);
            self.frames[i] = [NSValue valueWithCGRect:frame];
        }
        contentWidth = self.scrollView.frame.size.width;
    }
    self.scrollView.contentSize = CGSizeMake(contentWidth, self.scrollView.height);
    self.bgViewscrollView.contentSize = CGSizeMake(self.titlesCount*self.width, self.height - self.scrollView.height);

}

- (CGFloat)itemMarginAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(menuView:itemMarginAtIndex:)]) {
        return [self.delegate menuView:self itemMarginAtIndex:index];
    }
    return 0.0;
}

- (UIColor *)colorForState:(TCSMenuItemState)state atIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(menuView:titleColorForState:atIndex:)]) {
        return [self.delegate menuView:self titleColorForState:state atIndex:index];
    }
    return [UIColor blackColor];
}

- (UIFont *)sizeForState:(TCSMenuItemState)state atIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(menuView:titleFontForState:atIndex:)]) {
        return [self.delegate menuView:self titleFontForState:state atIndex:index];
    }
    return [UIFont systemFontOfSize:15];
}

// 让选中的item位于中间
- (void)refreshContenOffset {
    CGRect frame = self.selItem.frame;
    CGFloat itemX = frame.origin.x;
    CGFloat width = self.scrollView.frame.size.width;
    CGSize contentSize = self.scrollView.contentSize;
    if (itemX > width/2) {
        CGFloat targetX;
        if ((contentSize.width-itemX) <= width/2) {
            targetX = contentSize.width - width;
        } else {
            targetX = frame.origin.x - width/2 + frame.size.width/2;
        }
        // 应该有更好的解决方法
        if (targetX + width > contentSize.width) {
            targetX = contentSize.width - width;
        }
        [self.scrollView setContentOffset:CGPointMake(targetX, 0) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }

    NSInteger currentIndex = self.selItem.tag - TCSMENUITEM_TAG_OFFSET;
    [self.bgViewscrollView setContentOffset:CGPointMake(currentIndex*self.bgViewscrollView.width, 0) animated:YES];

}

- (void)selectItemAtIndex:(NSInteger)index withAnimation:(BOOL)animation {
    NSInteger tag = index + TCSMENUITEM_TAG_OFFSET;
    NSInteger currentIndex = self.selItem.tag - TCSMENUITEM_TAG_OFFSET;
    self.selectIndex = index;
    if (index == currentIndex || !self.selItem) { return; }
    
    TCSMenuItem *item = (TCSMenuItem *)[self viewWithTag:tag];
    if (item.alerdySlelected) {

    }else{
        if ([self.delegate respondsToSelector:@selector(menuViewFisrtView:atIndex:)]) {
            [self.delegate menuViewFisrtView:self atIndex:index];
            
        }
    }
    

    item.alerdySlelected = YES;
    [self.selItem setSelected:NO withAnimation:animation];
    self.selItem = item;
    [self.selItem setSelected:YES withAnimation:animation];
//    [self.progressView setProgressWithOutAnimate:index];
    if ([self.delegate respondsToSelector:@selector(menuView:didSelectedIndex:currentIndex:)]) {
        [self.delegate menuView:self didSelectedIndex:index currentIndex:currentIndex];
    }
    [self refreshContenOffset];
}

#pragma mark --- scroller deleate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSLog(@"socroole =x== %lf",scrollView.contentOffset.x);
    if (scrollView == self.bgViewscrollView) {
        CGPoint offset = scrollView.contentOffset;
        NSInteger currentPage = offset.x / scrollView.width;
        [self selectItemAtIndex:currentPage withAnimation:true];
//        [self selectBtnTitle:currentPage];
    }
    
}
#pragma mark - Data source
- (NSInteger)titlesCount {
    return [self.dataSource numbersOfTitlesInMenuView:self];
}

#pragma mark - Menu item delegate
- (void)didPressedMenuItem:(TCSMenuItem *)menuItem {
    
    if ([self.delegate respondsToSelector:@selector(menuView:shouldSelesctedIndex:)]) {
        BOOL should = [self.delegate menuView:self shouldSelesctedIndex:menuItem.tag - TCSMENUITEM_TAG_OFFSET];
        if (!should) {
            return;
        }
    }
    
    CGFloat progress = menuItem.tag - TCSMENUITEM_TAG_OFFSET;
//    [self.progressView moveToPostion:progress];
    
    NSInteger currentIndex = self.selItem.tag - TCSMENUITEM_TAG_OFFSET;
    if ([self.delegate respondsToSelector:@selector(menuView:didSelectedIndex:currentIndex:)]) {
        [self.delegate menuView:self didSelectedIndex:menuItem.tag - TCSMENUITEM_TAG_OFFSET currentIndex:currentIndex];
    }
    
    [self.selItem setSelected:NO withAnimation:YES];
    [menuItem setSelected:YES withAnimation:YES];
    self.selItem = menuItem;
    
    if (menuItem.alerdySlelected) {

    }else{
        if ([self.delegate respondsToSelector:@selector(menuViewFisrtView:atIndex:)]) {
            [self.delegate menuViewFisrtView:self atIndex:menuItem.tag - TCSMENUITEM_TAG_OFFSET];
            
        }
    }
    menuItem.alerdySlelected = YES;
    NSTimeInterval delay = self.style == TCSMenuViewStyleDefault ? 0 : 0.3f;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 让选中的item位于中间
        [self refreshContenOffset];
    });
}
@end
