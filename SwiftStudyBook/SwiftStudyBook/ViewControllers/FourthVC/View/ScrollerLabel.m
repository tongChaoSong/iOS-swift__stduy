//
//  ScrollerLabel.m
//  SwiftStudyBook
//
//  Created by TCS on 2023/2/23.
//  Copyright © 2023 tcs. All rights reserved.
//

#import "ScrollerLabel.h"
#import "NSTimer+timerBlock.h"

@interface ScrollerLabel ()<UIScrollViewDelegate>

@property (nonatomic , strong) NSMutableArray *subViewArray;
@property (nonatomic , assign) NSInteger currentPage;
@property (nonatomic , copy) NSArray  *labelArray;

@property (nonatomic, strong) dispatch_source_t gcdTimer;

@end
@implementation ScrollerLabel
-(void)dealloc{
    NSLog(@"释放了");
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentPage = 0;
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self removeGestureRecognizer:self.panGestureRecognizer];
    }
    return self;
}

- (void)setTextArray:(NSArray<NSString *> *)dataArray InteralTime:(NSTimeInterval)time Direction:(SHRollingDirection)direction
{
    if (dataArray.count == 0) return;
    _labelArray = dataArray;            ///初始化控件
    if (_labelArray.count == 1) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        label.text = _labelArray.lastObject;
        label.font = [UIFont boldSystemFontOfSize:13];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panClick)]];
        [self addSubview:label];
    }else{
        self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height*3);
        [self setContentOffset:CGPointMake(0, self.frame.size.height)];
        [self.subViewArray removeAllObjects];
        for (NSInteger i = 0; i < 3; i ++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height*i, self.frame.size.width, self.frame.size.height)];
            label.text = _labelArray[i == 0 ? [self getLessNum] : i == 1 ? self.currentPage : [self getMoreNum]];
            label.userInteractionEnabled = YES;
            [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panClick)]];
            [self addSubview:label];
            [self.subViewArray addObject:label];
        }
        if (_labelArray.count > 1 && time > 0) {
//            [NSTimer scheduledTimerWithTimeInterval:time repeats:YES block:^(NSTimer * _Nonnull timer) {
//                NSLog(@"时间间隔==设定时间=%f",time);
//
//                [self setContentOffset:CGPointMake(0, direction == SHRollingDirectionUp ? self.frame.size.height*2 : 0) animated:YES];
//            }];
            [self initTimer:time Direction:direction];
           
        }
    }
}
- (void)panClick{
    !self.didSelect ? : self.didSelect(self.currentPage,self.labelArray[_currentPage]);
}
-(void)tileActionDirection:(SHRollingDirection)direction{
    [self setContentOffset:CGPointMake(0, direction == SHRollingDirectionUp ? self.frame.size.height*2 : 0) animated:YES];
}
- (void)initTimer:(NSTimeInterval)time Direction:(SHRollingDirection)direction{
    if (!_gcdTimer) {
        // 创建队列
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        // 初始化timer（设定source_type，以及队列）
        _gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        // 设定timer的开始时间
        dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC));
        // 如果timer的间隔时间比较大，那么可以使用dispatch_walltime来创建start，可以避免误差
        dispatch_time_t start_0 = dispatch_walltime(0, 0);
        // 设定timer的固定时间间隔
        uint64_t interval = (uint64_t)(time * NSEC_PER_SEC);
        // 设置timer，最后一个参数为leeway，是用f来设置定时器的“期望精度值”，系统会根据这个值延迟或提前触发定时器
        dispatch_source_set_timer(_gcdTimer, start, interval, 0);
        // 设定timer的方法调用
        dispatch_source_set_event_handler(_gcdTimer, ^{
            NSLog(@"时间间隔==设定时间=%f",time);
            // 如果timer的方法调用是UI方面相关的操作，需要在主线程中执行（线程间通信）
            dispatch_async(dispatch_get_main_queue(), ^{
//                [self changeLabelText];
                [self tileActionDirection:direction];
            });
        });
        // 开启定时器
        dispatch_resume(_gcdTimer);
    }
}

- (void)pauseTimer {
    if (_gcdTimer) {
        dispatch_suspend(_gcdTimer);
    }
}
-(void)removGcdTimer{
    if (_gcdTimer) {
        dispatch_source_cancel(_gcdTimer);
        _gcdTimer = nil;
    }
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == 0 || scrollView.contentOffset.x == 2 * self.frame.size.width) {
        [self layoutSubview];
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == 0 || scrollView.contentOffset.x == 2 * self.frame.size.width) {
        [self layoutSubview];
    }
}
- (void)layoutSubview
{
    if (self.contentOffset.y == 0) {
        _currentPage = [self getLessNum];
        [self.subViewArray exchangeObjectAtIndex:0 withObjectAtIndex:self.subViewArray.count-1];
        [self.subViewArray exchangeObjectAtIndex:1 withObjectAtIndex:self.subViewArray.count-1];
        UILabel *label = self.subViewArray.firstObject;
        label.text = self.labelArray[[self getLessNum]];
    }else{
        _currentPage = [self getMoreNum];
        [self.subViewArray exchangeObjectAtIndex:1 withObjectAtIndex:self.subViewArray.count-1];
        [self.subViewArray exchangeObjectAtIndex:0 withObjectAtIndex:self.subViewArray.count-1];
        UILabel *label = self.subViewArray.lastObject;
        label.text = self.labelArray[[self getMoreNum]];
    }
    NSInteger coun = self.subViewArray.count;
    for (NSInteger i = 0; i < coun; i++) {
        UILabel *label = self.subViewArray[i];
        label.frame = CGRectMake(0, self.frame.size.height*i, self.frame.size.width, self.frame.size.height);
    }
    [self setContentOffset:CGPointMake(0, self.frame.size.height)];
}
#pragma mark - lazy
- (NSMutableArray *)subViewArray
{
    if (!_subViewArray) {
        _subViewArray = [NSMutableArray array];
    }
    return _subViewArray;
}
#pragma mark - customMetod
- (NSInteger)getMoreNum{
    return _currentPage == _labelArray.count-1 ? 0 : _currentPage+1;
}
- (NSInteger)getLessNum{
    return _currentPage == 0 ? _labelArray.count-1 : _currentPage-1;
}
@end
