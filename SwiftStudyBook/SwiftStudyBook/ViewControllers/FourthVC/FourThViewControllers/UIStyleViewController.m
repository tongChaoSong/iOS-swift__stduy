//
//  UIStyleViewController.m
//  SwiftStudyBook
//
//  Created by TCS on 2023/2/23.
//  Copyright © 2023 tcs. All rights reserved.
//

#import "UIStyleViewController.h"
#import "ScrollerLabel.h"
#import "ScrollerTwoLabe.h"
#import <WMPlayer.h>
#import <ZFPlayer.h>
#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFAVPlayerManager.h>
#import "VideoPlayCustomView.h"

@interface UIStyleViewController ()
@property(nonatomic,strong)ScrollerLabel * sclabel;

@property (nonatomic, strong) ScrollerTwoLabe *labelScroll;

@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) ZFAVPlayerManager *playerManager;
@property (nonatomic, strong) VideoPlayCustomView *customView;
@property (nonatomic, strong) UIImageView *containerView;
@end

@implementation UIStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ui样式";
    [self initView];
    [self addVM];
    [self addZF];
    // Do any additional setup after loading the view.
}

-(void)initView{
    self.sclabel = [[ScrollerLabel alloc] initWithFrame:CGRectMake(30, 100, self.view.frame.size.width-60, 44)];
    self.sclabel.backgroundColor = UIColor.whiteColor;
    [self.sclabel setTextArray:@[@"1.上岛咖啡就是看劳动法就是盛开的积分是劳动法",
                          @"2.SDK和索拉卡的附近是了的开发房贷",
                          @"3.收快递费就SDK废旧塑料的发三楼的靠近非塑料袋开发计算量大开发就"] InteralTime:2.0 Direction:SHRollingDirectionUp];
    self.sclabel.didSelect = ^(NSInteger index, NSString *text) {
        NSLog(@"---%ld----%@",index,text);
    };
    [self.view addSubview:self.sclabel];
    
    
    self.labelScroll = [[ScrollerTwoLabe alloc] initWithFrame:CGRectMake(30, 180, self.view.frame.size.width-60, 44)];
    [self.view addSubview:self.labelScroll];
    self.labelScroll.dataSource = [NSMutableArray arrayWithObjects:@"澳门", @"皇家",@"FBI",@"Warning",@"东京",@"热门",@"一拳超人", nil];
    [self.labelScroll showNext];
}
-(void)dealloc{
    [self.sclabel removGcdTimer];
    [self.labelScroll removeTimer];
    
}
-(void)addVM{
//    播放网络视频
    WMPlayerModel *playerModel = [WMPlayerModel new];
    playerModel.title = @"";
    playerModel.videoURL = [NSURL URLWithString:@"http://47.111.21.66/testVideo/test.m3u8"];
    WMPlayer * wmPlayer = [[WMPlayer alloc]initPlayerModel:playerModel];
    [self.view addSubview:wmPlayer];
    [wmPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(300);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(wmPlayer.mas_width).multipliedBy(9.0/16);
    }];
    [wmPlayer play];
//    wmPlayer.isFullscreen = true;
    
//    播放本地视频
//    WMPlayerModel *playerModel = [WMPlayerModel new];
//    playerModel.title = @"";
//    NSURL *URL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"4k" ofType:@"mp4"]];
//    playerModel.videoURL = [NSURL URLWithString:[URL absoluteString]];
//    WMPlayer * wmPlayer = [WMPlayer playerWithModel:playerModel];
//    [self.view addSubview:wmPlayer];
//    [wmPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.trailing.top.equalTo(self.view);
//        make.height.mas_equalTo(wmPlayer.mas_width).multipliedBy(9.0/16);
//    }];
//    [wmPlayer play];
}
-(void)addZF{
    
    [self.view addSubview:self.containerView];
    self.playerManager.assetURL = [NSURL URLWithString:@"http://47.111.21.66/testVideo/test.m3u8"];
//    ZFAVPlayerManager *manager = [[ZFAVPlayerManager alloc] init];
////
//    ZFPlayerController *player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:containerView];

}
- (VideoPlayCustomView *)customView {
    if (!_customView) {
        _customView = [[VideoPlayCustomView alloc] init];
        _customView.isTopHid = YES;
        _customView.isFullScreenImg = NO;
    }
    return _customView;
}
- (UIImageView *)containerView {
    if (!_containerView) {
//        _containerView = [UIImageView new];
        _containerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 800, kScreenWidth, 300)];
        _containerView.backgroundColor = [UIColor redColor];
        _customView.clipsToBounds = YES;
        _customView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _containerView;
}
- (ZFAVPlayerManager *)playerManager {
    if (!_playerManager) {
        _playerManager = [[ZFAVPlayerManager alloc] init];
    }
    return _playerManager;
}
- (ZFPlayerController *)player {
    if (!_player) {
        _player = [ZFPlayerController playerWithPlayerManager:self.playerManager containerView:self.containerView];
        /// 后台是否继续播放
        _player.pauseWhenAppResignActive = NO;
        /// 是否支持旋转
//        _player.allowOrentitaionRotation = NO;
        /// 设置自定义容器
        _player.controlView = self.customView;
        
        //@zf_weakify(self)
        _player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
//            ((AppDelegate *)[[UIApplication sharedApplication] delegate]).allowRotation = isFullScreen;
        };
    }
    return _player;
}


- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window {
//    if (self.allowRotation) { // yes
        //横屏
//        return UIInterfaceOrientationMaskLandscape;
        return UIInterfaceOrientationMaskAll;
//    } else { // no
        //竖屏
//        return UIInterfaceOrientationMaskPortrait;
//    }
}
//- (BOOL)shouldAutorotate {
//    return NO;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
