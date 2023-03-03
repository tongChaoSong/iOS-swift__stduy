//
//  VideoPlayCustomView.m
//  SwiftStudyBook
//
//  Created by TCS on 2023/3/2.
//  Copyright © 2023 tcs. All rights reserved.
//

#import "VideoPlayCustomView.h"
#import "VideoPlayCustomView.h"
#import <ZFPlayer/ZFPlayerController.h>
#import <ZFPlayer/ZFPlayerConst.h>
#import "SliderView.h"
@interface VideoPlayCustomView ()<SliderViewDelegate>

@property (nonatomic, strong) UIView *bottomToolView;///< 底部工具栏
@property (nonatomic, strong) UIView *topToolView;///< 顶部工具栏
@property (nonatomic, strong) UIButton *gobackBtn;///< 返回按钮
@property (nonatomic, strong) UIButton *deleBtn;///< 删除按钮
@property (nonatomic, strong) UIButton *playOrPauseBtn;///< 播放或暂停按钮
@property (nonatomic, strong) UIButton *fullScreenBtn;///< 满屏
@property (nonatomic, strong) UILabel *currentTimeLabel;///< 播放的当前时间
@property (nonatomic, strong) SliderView *slider;///< 滑杆
@property (nonatomic, strong) UILabel *totalTimeLabel;///< 视频总时间
//@property (nonatomic, strong) SliderView *bottomPgrogress;///< 底部播放进度
@property (nonatomic, assign) BOOL isSureCaptured; ///< 是否在录屏
@property (nonatomic, assign) BOOL isClearScreen; ///< 是否清屏

@end

@implementation VideoPlayCustomView

@synthesize player = _player;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.isClearScreen = NO;
        // 添加子控件
        [self addSubview:self.topToolView];
        [self addSubview:self.bottomToolView];
        [self.topToolView addSubview:self.gobackBtn];
        [self.topToolView addSubview:self.deleBtn];
        [self.bottomToolView addSubview:self.playOrPauseBtn];
        [self.bottomToolView addSubview:self.currentTimeLabel];
        [self.bottomToolView addSubview:self.slider];
        [self.bottomToolView addSubview:self.totalTimeLabel];
//        [self addSubview:self.bottomPgrogress];
        [self.bottomToolView addSubview:self.fullScreenBtn];
        
        // 设置子控件的响应事件
        [self makeSubViewsAction];
        self.clipsToBounds = YES;
        
    }
    return self;
}

- (void)setVideoPlayType:(VideoPlayType)videoPlayType {
    _videoPlayType = videoPlayType;
    if (_videoPlayType == VideoPlayType_Record) {
        self.deleBtn.hidden = YES;
    }
    else if (_videoPlayType == VideoPlayType_Ad) {
        self.deleBtn.hidden = NO;
    }
}

- (void)makeSubViewsAction {
    [self.playOrPauseBtn addTarget:self action:@selector(playPauseButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.fullScreenBtn addTarget:self action:@selector(fullScreenButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
}

/// 暂停视频
- (void)pauseVideo {
    self.playOrPauseBtn.selected = NO;
    [self.player.currentPlayerManager pause];
}

/// 播放视频
- (void)playVideo {
    self.playOrPauseBtn.selected = YES;
    [self.player.currentPlayerManager play];
}

/// 录屏
- (void)isCaptured {
    if (@available(iOS 11.0, *)) {
        if ([UIScreen mainScreen].isCaptured && self.isSureCaptured == NO) {
            self.isSureCaptured = YES;
            [self pauseVideo];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"不允许录制" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.isSureCaptured = NO;
            }];
            [alertController addAction:okAction];
//            [[ViewTool topViewController] presentViewController:alertController animated:YES completion:nil];
        }
        else {
//            NSLog(@"没在录制");
        }
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark - ZFSliderViewDelegate
- (void)sliderTouchBegan:(float)value {
    self.slider.isdragging = YES;
}

- (void)sliderTouchEnded:(float)value {
    if (self.player.totalTime > 0) {
        [self.player seekToTime:self.player.totalTime*value completionHandler:^(BOOL finished) {
            if (finished) {
                self.slider.isdragging = NO;
            }
        }];
    } else {
        self.slider.isdragging = NO;
    }
}

- (void)sliderValueChanged:(float)value {
    if (self.player.totalTime == 0) {
        self.slider.value = 0;
        return;
    }
    self.slider.isdragging = YES;
    NSString *currentTimeString = [self convertTimeSecond:self.player.totalTime*value];
    self.currentTimeLabel.text = currentTimeString;
}

- (void)sliderTapped:(float)value {
    if (self.player.totalTime > 0) {
        self.slider.isdragging = YES;
        [self.player seekToTime:self.player.totalTime*value completionHandler:^(BOOL finished) {
            if (finished) {
                self.slider.isdragging = NO;
                [self.player.currentPlayerManager play];
            }
        }];
    } else {
        self.slider.isdragging = NO;
        self.slider.value = 0;
    }
}

#pragma mark - action
- (void)playPauseButtonClickAction:(UIButton *)sender {
    [self playOrPause];
}

- (void)fullScreenButtonClickAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.player enterFullScreen:!self.player.isFullScreen animated:YES];
    
//    [self pauseVideo];
//    if (self.fullScreenVideoBlock) {
//        self.fullScreenVideoBlock(sender);
//    }
    
//    if (!self.player) return;
//    if (self.player.isSmallFloatViewShow && !self.player.isFullScreen) {
//        [self.player enterFullScreen:!self.player.isFullScreen animated:YES];
//    }
}

/// 根据当前播放状态取反
- (void)playOrPause {
    if (self.isplayEnd) {
        self.isplayEnd = NO;
        [self.player.currentPlayerManager replay];
    }
    else {
        self.playOrPauseBtn.selected = !self.playOrPauseBtn.isSelected;
        self.playOrPauseBtn.isSelected? [self.player.currentPlayerManager play]: [self.player.currentPlayerManager pause];
    }
}

- (void)playBtnSelectedState:(BOOL)selected {
    self.playOrPauseBtn.selected = selected;
}

#pragma mark - 添加子控件约束

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    CGFloat min_view_w = self.bounds.size.width;
    CGFloat min_view_h = self.bounds.size.height;
        
    min_x = 0;
//    min_y = kStatusBarHeight + RATIOA(8);
    min_y = kStatusBarHeight + RATIOA(8);

    min_w = min_view_w;
    min_h = RATIOA(26);
    self.topToolView.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = RATIOA(10);
    min_y = 0;
    min_w = RATIOA(26);
    min_h = RATIOA(26);
    self.gobackBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = SCREEN_WIDTH - RATIOA(15) - RATIOA(48);
    min_y = 0;
    min_w = RATIOA(48);
    min_h = RATIOA(26);
    self.deleBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.deleBtn.centerY = self.gobackBtn.centerY;
    
    min_h = RATIOA(40);
    min_x = 0;
    min_y = min_view_h - min_h;
    min_w = min_view_w;
    self.bottomToolView.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = RATIOA(12);
    min_w = RATIOA(20);
    min_h = RATIOA(20);
    min_y = RATIOA(8);
    self.playOrPauseBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = RATIOA(43);
    min_w = RATIOA(60);
    min_h = RATIOA(13);
    min_y = 0;
    self.currentTimeLabel.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.currentTimeLabel.centerY = self.playOrPauseBtn.centerY;
    
    min_w = RATIOA(60);
    min_h = RATIOA(13);
    min_x = min_view_w - min_w - RATIOA(43);
    min_y = 0;
    self.totalTimeLabel.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.totalTimeLabel.centerY = self.playOrPauseBtn.centerY;

    min_x = self.currentTimeLabel.right + RATIOA(8);
    min_w = self.totalTimeLabel.left - min_x - RATIOA(8);
    min_h = 30;
    min_y = 0;
    self.slider.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.slider.centerY = self.playOrPauseBtn.centerY;
    
//    min_x = 0;
//    min_y = min_view_h - 1;
//    min_w = min_view_w;
//    min_h = 1;
//    self.bottomPgrogress.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = self.totalTimeLabel.right + RATIOA(8);
    min_y = RATIOA(8);
    min_w = RATIOA(20);
    min_h = RATIOA(20);
    self.fullScreenBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
}

#pragma mark - 添加子控件约束
- (BOOL)shouldResponseGestureWithPoint:(CGPoint)point withGestureType:(ZFPlayerGestureType)type touch:(nonnull UITouch *)touch {
    CGRect sliderRect = [self.bottomToolView convertRect:self.slider.frame toView:self];
    if (CGRectContainsPoint(sliderRect, point)) {
        return NO;
    }
    return YES;
}

/**
 设置标题、封面、全屏模式
 
 @param coverUrl 视频的封面，占位图默认是灰色的
 @param fullScreenMode 全屏模式
 */
- (void)showCoverURLString:(NSString *)coverUrl fullScreenMode:(ZFFullScreenMode)fullScreenMode {
    [self layoutIfNeeded];
    [self setNeedsDisplay];
    self.player.orientationObserver.fullScreenMode = fullScreenMode;
    [self.player.currentPlayerManager.view.coverImageView sd_setImageWithURL:[NSURL URLWithString:coverUrl]];
}

/// 调节播放进度slider和当前时间更新
- (void)sliderValueChanged:(CGFloat)value currentTimeString:(NSString *)timeString {
    self.slider.value = value;
    self.currentTimeLabel.text = timeString;
    self.slider.isdragging = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.slider.sliderBtn.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }];
}

/// 滑杆结束滑动
- (void)sliderChangeEnded {
    self.slider.isdragging = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.slider.sliderBtn.transform = CGAffineTransformIdentity;
    }];
}

- (NSString *)convertTimeSecond:(NSInteger)timeSecond {
    NSString *theLastTime = nil;
    long second = timeSecond;
//    theLastTime = [NSString stringWithFormat:@"%02zd:%02zd:%02zd", second/3600, second%3600/60, second%60];
    if (timeSecond < 60) {
        theLastTime = [NSString stringWithFormat:@"00:%02zd", second];
    } else if(timeSecond >= 60 && timeSecond < 3600){
        theLastTime = [NSString stringWithFormat:@"%02zd:%02zd", second/60, second%60];
    } else if(timeSecond >= 3600){
        theLastTime = [NSString stringWithFormat:@"%02zd:%02zd:%02zd", second/3600, second%3600/60, second%60];
    }
    return theLastTime;
}

#pragma mark - ZFPlayerControlViewDelegate

/// 手势筛选，返回NO不响应该手势
- (BOOL)gestureTriggerCondition:(ZFPlayerGestureControl *)gestureControl gestureType:(ZFPlayerGestureType)gestureType gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer touch:(nonnull UITouch *)touch {
    CGPoint point = [touch locationInView:self];
    if (self.player.isSmallFloatViewShow && !self.player.isFullScreen && gestureType != ZFPlayerGestureTypeSingleTap) {
        return NO;
    }
    return [self shouldResponseGestureWithPoint:point withGestureType:gestureType touch:touch];
}

/// 单击手势事件
- (void)gestureSingleTapped:(ZFPlayerGestureControl *)gestureControl
{
    if (!self.player) return;
    
    if (!self.isClearScreen)
    {
        self.isClearScreen = YES;
        if (!self.isTopHid) {
            self.topToolView.hidden = YES;
        }
        self.bottomToolView.hidden = YES;
    }
    else
    {
        self.isClearScreen = NO;
        if (!self.isTopHid) {
            self.topToolView.hidden = NO;
        }
        self.bottomToolView.hidden = NO;
    }
//    if (self.player.isSmallFloatViewShow && !self.player.isFullScreen) {
//        [self.player enterFullScreen:YES animated:YES];
//    }
}

/// 双击手势事件
- (void)gestureDoubleTapped:(ZFPlayerGestureControl *)gestureControl
{
    if (!self.player) return;
    [self playOrPause];
}

/// 捏合手势事件，这里改变了视频的填充模式
- (void)gesturePinched:(ZFPlayerGestureControl *)gestureControl scale:(float)scale {
    if (scale > 1) {
        self.player.currentPlayerManager.scalingMode = ZFPlayerScalingModeAspectFill;
    } else {
        self.player.currentPlayerManager.scalingMode = ZFPlayerScalingModeAspectFit;
    }
}

/// 准备播放
- (void)videoPlayer:(ZFPlayerController *)videoPlayer prepareToPlay:(NSURL *)assetURL {
    
}

/// 播放状态改变
- (void)videoPlayer:(ZFPlayerController *)videoPlayer playStateChanged:(ZFPlayerPlaybackState)state {
    if (state == ZFPlayerPlayStatePlaying) {
        [self playBtnSelectedState:YES];
    } else if (state == ZFPlayerPlayStatePaused) {
        [self playBtnSelectedState:NO];
    } else if (state == ZFPlayerPlayStatePlayFailed) {
    }
}

/// 加载状态改变
- (void)videoPlayer:(ZFPlayerController *)videoPlayer loadStateChanged:(ZFPlayerLoadState)state {
    if (state == ZFPlayerLoadStatePrepare) {
    } else if (state == ZFPlayerLoadStatePlaythroughOK || state == ZFPlayerLoadStatePlayable) {
        self.player.currentPlayerManager.view.backgroundColor = [UIColor blackColor];
    }
    if (state == ZFPlayerLoadStateStalled && videoPlayer.currentPlayerManager.isPlaying) {
    } else if ((state == ZFPlayerLoadStateStalled || state == ZFPlayerLoadStatePrepare) && videoPlayer.currentPlayerManager.isPlaying) {
    } else {
    }
}

/// 播放进度改变回调
- (void)videoPlayer:(ZFPlayerController *)videoPlayer currentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime {

    [self isCaptured];
    
    if (!self.slider.isdragging) {
        NSString *currentTimeString = [self convertTimeSecond:currentTime];
        self.currentTimeLabel.text = currentTimeString;
        NSString *totalTimeString = [self convertTimeSecond:totalTime];
        self.totalTimeLabel.text = totalTimeString;
        self.slider.value = videoPlayer.progress;
    }
//    self.bottomPgrogress.value = videoPlayer.progress;
}

/// 缓冲改变回调
- (void)videoPlayer:(ZFPlayerController *)videoPlayer bufferTime:(NSTimeInterval)bufferTime {
    self.slider.bufferValue = videoPlayer.bufferProgress;
//    self.bottomPgrogress.bufferValue = videoPlayer.bufferProgress;
}

- (void)videoPlayer:(ZFPlayerController *)videoPlayer presentationSizeChanged:(CGSize)size {}

/// 视频view即将旋转
- (void)videoPlayer:(ZFPlayerController *)videoPlayer orientationWillChange:(ZFOrientationObserver *)observer {}

/// 视频view已经旋转
- (void)videoPlayer:(ZFPlayerController *)videoPlayer orientationDidChanged:(ZFOrientationObserver *)observer {}

/// 锁定旋转方向
- (void)lockedVideoPlayer:(ZFPlayerController *)videoPlayer lockedScreen:(BOOL)locked {}

#pragma mark - setter
- (void)setIsplayEnd:(BOOL)isplayEnd {
    _isplayEnd = isplayEnd;
    
    if (_isplayEnd == YES) {
        self.playOrPauseBtn.selected = NO;
        [self.playOrPauseBtn setImage:IMG(@"releaseVideo_refresh") forState:UIControlStateNormal];
        
    }
    else {
        [self.playOrPauseBtn setImage:IMG(@"releaseVideo_suspend") forState:UIControlStateNormal];
    }
}

- (void)setPlayer:(ZFPlayerController *)player {
    _player = player;
}

#pragma mark - getter


#pragma mark - action
- (void)gobackClick {
    if (self.gobackBlock) {
        self.gobackBlock();
    }
}

- (void)deleVideo {
    if (self.deleVideoBlock) {
        self.deleVideoBlock();
    }
}

 
// MARK: ----- 顶部工具条是否隐藏
- (void)setIsTopHid:(BOOL)isTopHid
{
    _isTopHid = isTopHid;
    
    self.topToolView.hidden = isTopHid;
}

// MARK: ----- 底部工具条是否隐藏
- (void)setIsBottomHid:(BOOL)isBottomHid
{
    _isBottomHid = isBottomHid;
    
    self.bottomToolView.hidden = isBottomHid;
}

// MARK: ----- 是否隐藏放大缩小按钮
- (void)setIsFullScreenImg:(BOOL)isFullScreenImg
{
    _isFullScreenImg = isFullScreenImg;
    
    self.fullScreenBtn.hidden = isFullScreenImg;
}

#pragma mark - lazy
- (UIView *)topToolView {
    if (!_topToolView) {
        _topToolView = [[UIView alloc] init];
        _topToolView.backgroundColor = RGBA(0, 0, 0, 0);
    }
    return _topToolView;
}
- (UIButton *)gobackBtn {
    if (!_gobackBtn) {
        _gobackBtn = [[UIButton alloc] init];
        [_gobackBtn setImage:IMG(@"releaseVideo_goback") forState:UIControlStateNormal];
        [_gobackBtn addTarget:self action:@selector(gobackClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gobackBtn;
}
- (UIButton *)deleBtn {
    if (!_deleBtn) {
        _deleBtn = [[UIButton alloc] init];
        [_deleBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleBtn setTitleColor:KThmeColor forState:UIControlStateNormal];
        _deleBtn.backgroundColor = RGBA(0, 0, 0, 0.5);
        _deleBtn.clipsToBounds = YES;
        _deleBtn.layer.cornerRadius = RATIOA(5);
        _deleBtn.titleLabel.font = FONT(15);
        [_deleBtn addTarget:self action:@selector(deleVideo) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _deleBtn;
}
- (UIView *)bottomToolView {
    if (!_bottomToolView) {
        _bottomToolView = [[UIView alloc] init];
        _bottomToolView.backgroundColor = RGBA(0, 0, 0, 0.5);
    }
    return _bottomToolView;
}
- (UIButton *)playOrPauseBtn {
    if (!_playOrPauseBtn) {
        _playOrPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playOrPauseBtn setImage:IMG(@"releaseVideo_suspend") forState:UIControlStateNormal];
        [_playOrPauseBtn setImage:IMG(@"releaseVideo_play") forState:UIControlStateSelected];
    }
    return _playOrPauseBtn;
}
- (UILabel *)currentTimeLabel {
    if (!_currentTimeLabel) {
        _currentTimeLabel = [[UILabel alloc] init];
        _currentTimeLabel.textColor = [UIColor whiteColor];
        _currentTimeLabel.font = FONT(14);
        _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _currentTimeLabel;
}
- (SliderView *)slider {
    if (!_slider) {
        _slider = [[SliderView alloc] init];
        _slider.delegate = self;
//        _slider.maximumTrackTintColor = [UIColor whiteColor];
//        _slider.bufferTrackTintColor  = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
//        _slider.minimumTrackTintColor = YGFFFFFF;
//        [_slider setThumbImage:IMG(@"releaseVideo_circle") forState:UIControlStateNormal];
//        _slider.sliderHeight = 2;
    }
    return _slider;
}
- (UILabel *)totalTimeLabel {
    if (!_totalTimeLabel) {
        _totalTimeLabel = [[UILabel alloc] init];
        _totalTimeLabel.textColor = [UIColor whiteColor];
        _totalTimeLabel.font = FONT(14);
        _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _totalTimeLabel;
}
//- (SliderView *)bottomPgrogress {
//    if (!_bottomPgrogress) {
//        _bottomPgrogress = [[SliderView alloc] init];
//        _bottomPgrogress.maximumTrackTintColor = [UIColor clearColor];
//        _bottomPgrogress.minimumTrackTintColor = [UIColor whiteColor];
//        _bottomPgrogress.bufferTrackTintColor  = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
//        _bottomPgrogress.sliderHeight = 1;
//        _bottomPgrogress.isHideSliderBlock = NO;
//    }
//    return _bottomPgrogress;
//}
- (UIButton *)fullScreenBtn
{
    if (!_fullScreenBtn) {
        _fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenBtn setImage:IMG(@"palyback_enlarge") forState:UIControlStateNormal];
        [_fullScreenBtn setImage:IMG(@"palyback_narrow") forState:UIControlStateSelected];
    }
    return _fullScreenBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
