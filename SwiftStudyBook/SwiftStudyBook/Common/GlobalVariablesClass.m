//
//  GlobalVariablesClass.m
//  一起自驾游
//
//  Created by apple-CXTX on 18/1/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GlobalVariablesClass.h"

NSInteger gSeeFormatAllTime = 300;

NSInteger gSeeUserCaptainEndTim = 10;


BOOL appResign = NO;

//小马开启识别中
BOOL horseActive = NO;

/**
 * 判断是否使用导航坐标上传鹰眼轨迹
 */
BOOL gUseNavLocation = NO;

/**
 *  是否刚打开APP
 */
BOOL gJustOpenApp = YES;

/**
 *  音频输出
 */
BOOL gAudioIsMicrophone = YES;

//是否在首页
BOOL gInHomeVC = NO;

//是否在导航中
BOOL gInNav = NO;

//是否在位置共享中
BOOL gInLocationShareVC = NO;

BOOL gLocationViewIsPop = NO;

BOOL gInHorseWake = NO;

//语音识别是否唤醒
BOOL asraAtivation = NO;

BOOL sceneDetail = NO;

BOOL firstOpenApp = NO;

BOOL asraPress = NO;
//自驾生活
BOOL isDriveLife = NO;
//精选线路
BOOL isSelectLine = NO;
//汽车服务
BOOL isCarService = NO;
//小马设置
BOOL isHorseSet = NO;

NSString * PlaySpeaker = @"zhilingf";

NSString *const gInviteFriendWhenDontReigiser = @"该好友未注册，不能邀请";

NSString *const gInviteUnMemberFriendInContactList = @"该好友未注册，是否前往微信邀请？";


NSString *const gNotIsShowLoginBtn = @"gNotIsShowLoginBtn";


NSString *const gInlocationPushGNav = @"gInlocationPushGNav";

NSString *const gNotLoginWhenNeedLogin = @"gNotLoginWhenNeedLogin";


NSString *const gAsrNotificationString = @"gAsrNotificationString";
/**
 * 自驾生活酒店搜索记录
 */
NSString *const gTrainTicketTableName = @"gTrainTicketTableName";

/**
 *  首页酒店搜索记录
 */
NSString *const gHomeHotelTableName = @"gHomeHotelTableName";

/**
 *  收到推送退出当前位置共享和导航
 */
NSString *const gQuitLocatVCGPSVC = @"gQuitLocatVCGPSVC";

/**
 *  时间表
 */
NSString *const gDistanceTimeTable = @"gDistanceTimeTable";

//NSString *const gMemberTable = @"gMemberTable";
//NSString *const gUnMemberTable = @"gUnMemberTable";

NSMutableArray *friendMemberArray = nil;
NSMutableArray *unFriendMemberArray = nil;
NSMutableArray *contactPeopleArray = nil;

NSString *const gLocatShareMicPress = @"gLocatShareMicPress";

NSString *const gAiSceneIntroPlayFinish = @"gAiSceneIntroPlayFinish";

NSString *const gZfbPayFinish = @"gZfbPayFinish";

NSString *gCarServiceCity = @"";

//网络状态
NSString *const gNetWorkYes = @"gNetWorkYes";

NSString *const gNetWorkNo = @"gNetWorkNo";

NSString *const sHowRedCircle = @"sHowRedCircle";

NSString *const showLocationRedCircle = @"showLocationRedCircle";

//sockt地址和端口号
NSString *const gpsSocketIp = @"socketIp";

NSString *const gpsSocketProt = @"socketProt";

//家的地主数据
NSString *const homeLocationModel = @"homeLocationModel";

//车主卡价格
NSString *const carPeopleCard = @"carPeopleCard";

NSString *const carPeopleImage = @"carPeopleImage";

NSString *const isCarRecorderVip = @"isCRecorderVip";


//路径规划方式
NSString *const gRoutePlanWay1 = @"gRoutePlanWay1";
NSString *const gRoutePlanWay2 = @"gRoutePlanWay2";
NSString *const gRoutePlanWay3 = @"gRoutePlanWay3";
NSString *const gRoutePlanWay4 = @"gRoutePlanWay4";

BOOL gAsrAtumoYYSpeechEnd = NO;

dispatch_semaphore_t gSemaphore = nil;

NSString *const WXAPIuserName = @"gh_07cf19165dff";


@implementation GlobalVariablesClass

@end
