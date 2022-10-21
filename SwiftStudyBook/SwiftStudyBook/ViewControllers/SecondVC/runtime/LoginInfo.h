//
//  LoginInfo.h
//  SwiftStudyBook
//
//  Created by TCS on 2022/10/21.
//  Copyright © 2022 tcs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginInfo : NSObject<NSCoding>
/**
 *  用户id
 */
@property (nonatomic,copy)NSString *userId;
/**
 *  用户姓名
 */
@property (nonatomic,copy)NSString *userName;

/**
 *  用户头像
 */
@property (nonatomic,copy)NSString *handelImg;

/**
 *  用户等级
 */
@property (nonatomic,copy)NSString *userLeval;
/**
 *  昵称
 */
@property (nonatomic,copy)NSString *nickname;
/**
 *  用户手机号
 */
@property (nonatomic,copy)NSString *userPhone;
/**
 *  性别[0.男1.女]
 */
@property (nonatomic,copy)NSString *userSex;
/**
 *  设备ID
 */
@property (nonatomic,copy)NSString *deviceId;
/**
 *
 */
@property (nonatomic,copy)NSString *qqId;
/**
 *
 */
@property (nonatomic,copy)NSString *regType;
/**
 *
 */
@property (nonatomic,copy)NSString *unionId;
/**
 *  用户密码
 */
@property (nonatomic,copy)NSString *userPwd;
/**
 *  sid 用户登录唯一标志
 */
@property (nonatomic,copy)NSString *sid;
/**
 *  用户是否登录
 *  0：未登录，1：已登录
 */
@property (nonatomic,copy)NSString * isLogin;

/**
 *  发起的行程数量
 */
@property (nonatomic,copy)NSString * releaseCount;


/**
 *  加入的行程数量
 */
@property (nonatomic,copy)NSString * joinCount;



/**
 *  等待出发行程数量
 */
@property (nonatomic,copy)NSString * waitCount;


/**
 *  品牌
 */
@property (nonatomic,copy)NSString * brand;

/**
 *  型号
 */
@property (nonatomic,copy)NSString * model;

/**
 *  车牌号
 */
@property (nonatomic,copy)NSString * plateNumber;

/**
 *  发动机号
 */
@property (nonatomic,copy)NSString * engineNumber;

/**
 *  车架号
 */
@property (nonatomic,copy)NSString * vin;

/**
 *  单例
 *
 *  @return 数据模型
 */
+ (id)sharedInstance;
@end

NS_ASSUME_NONNULL_END
