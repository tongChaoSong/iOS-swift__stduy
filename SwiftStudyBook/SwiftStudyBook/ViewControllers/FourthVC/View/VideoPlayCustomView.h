//
//  VideoPlayCustomView.h
//  SwiftStudyBook
//
//  Created by TCS on 2023/3/2.
//  Copyright © 2023 tcs. All rights reserved.
//

#import "BaseView.h"

#import <ZFPlayer/ZFPlayerMediaControl.h>

typedef NS_ENUM(NSInteger, VideoPlayType) {
    /// 录制
    VideoPlayType_Record = 0,
    /// 广告
    VideoPlayType_Ad = 1
};
NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayCustomView : UIView <ZFPlayerMediaControl>

@property (nonatomic, assign) VideoPlayType videoPlayType; ///< 两种情况，因需求而定
@property (nonatomic, strong) VoidBlock gobackBlock;
@property (nonatomic, strong) VoidBlock deleVideoBlock;
@property (nonatomic, strong) BoolBlock fullScreenVideoBlock;

@property (nonatomic,assign) BOOL isplayEnd; ///< 是否播放完成
/**
 设置标题、封面、全屏模式
 
 @param coverUrl 视频的封面，占位图默认是灰色的
 @param fullScreenMode 全屏模式
 */
- (void)showCoverURLString:(NSString *)coverUrl fullScreenMode:(ZFFullScreenMode)fullScreenMode;

@property (nonatomic, assign) BOOL isTopHid; ///< 顶部工具条是否隐藏
@property (nonatomic, assign) BOOL isBottomHid; ///< 底部工具条是否隐藏
@property (nonatomic, assign) BOOL isFullScreenImg; ///< 是否隐藏放大缩小按钮

@end

NS_ASSUME_NONNULL_END
