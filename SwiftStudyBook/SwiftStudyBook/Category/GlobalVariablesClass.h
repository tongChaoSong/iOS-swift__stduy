//
//  GlobalVariablesClass.h
//  一起自驾游
//
//  Created by apple-CXTX on 18/1/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalVariablesClass : NSObject


extern NSInteger gSeeFormatAllTime;

extern NSInteger gSeeUserCaptainEndTim;

/**
 *  是否刚打开APP
 */
extern BOOL gJustOpenApp;


extern NSString *const gNotLoginWhenNeedLogin;


extern BOOL gUseNavLocation;
/**
 *  音频输出
 */
extern BOOL gAudioIsMicrophone;

extern BOOL gInHomeVC;
//是否在导航中
extern BOOL gInNav;

//是否在位置共享中
extern BOOL gInLocationShareVC;

extern BOOL gLocationViewIsPop;

extern BOOL asraAtivation;

extern BOOL sceneDetail;

extern BOOL firstOpenApp;

extern BOOL asraPress;

extern BOOL isDriveLife;

extern BOOL isSelectLine;

extern BOOL isCarService;

extern BOOL isHorseSet;

extern NSString *const gAsrNotificationString;

extern NSString *const gTrainTicketTableName;

extern NSString *const gHomeHotelTableName;

extern NSString *const gLocatShareMicPress;


//extern NSString *const gMemberTable;
//extern NSString *const gUnMemberTable;

extern NSString *const gAiSceneIntroPlayFinish;

extern NSString *const gZfbPayFinish;

extern NSString *const gInlocationPushGNav;

extern NSString *gCarServiceCity;

extern BOOL gInHorseWake;

///app是否挂起的状态。默人激活
extern BOOL appResign;

///判断小马是否在激活中
extern BOOL horseActive;


extern NSString * PlaySpeaker;

/**
 *  收到推送退出当前位置共享和导航
 */
extern NSString *const gQuitLocatVCGPSVC;

/**
 *  时间表
 */
extern NSString *const gDistanceTimeTable;

//是否显示登陆按钮，ios审核第三方登录无法通过，使用本地缓存和后台控制的方式，隐藏和显示按钮，方便通过审核
extern NSString *const gNotIsShowLoginBtn;
//网络状态通知
//有网
extern NSString *const gNetWorkYes;
//无网
extern NSString *const gNetWorkNo;

extern NSString *const gpsSocketIp;
//无网
extern NSString *const gpsSocketProt;

extern NSString *const gInviteFriendWhenDontReigiser;
extern NSString *const gInviteUnMemberFriendInContactList;

extern NSMutableArray *friendMemberArray;
extern NSMutableArray *unFriendMemberArray;
extern NSMutableArray *contactPeopleArray;
//gps页面小红点显示
extern NSString *const sHowRedCircle;
//位置共享页面小红点显示
extern NSString *const showLocationRedCircle;

//路径规划方式
extern NSString *const gRoutePlanWay1;
extern NSString *const gRoutePlanWay2;
extern NSString *const gRoutePlanWay3;
extern NSString *const gRoutePlanWay4;

//家的地主数据
extern NSString *const homeLocationModel;

//车主卡价格
extern NSString *const carPeopleCard;
extern NSString *const carPeopleImage;

extern NSString *const isCarRecorderVip;


extern NSString *const WXAPIuserName;



//是否是自动对话的场景
extern BOOL gAsrAtumoYYSpeechEnd;

extern dispatch_semaphore_t gSemaphore;

@end
