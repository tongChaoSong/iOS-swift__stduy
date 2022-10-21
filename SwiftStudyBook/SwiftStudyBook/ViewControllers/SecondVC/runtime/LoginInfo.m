//
//  LoginInfo.m
//  SwiftStudyBook
//
//  Created by TCS on 2022/10/21.
//  Copyright © 2022 tcs. All rights reserved.
//

#import "LoginInfo.h"
#import <objc/runtime.h>

@implementation LoginInfo

+ (LoginInfo *)sharedInstance {
    static LoginInfo *userInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[self alloc]init];
    });
    return userInfo;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        
//        _userName = [aDecoder decodeObjectForKey:@"userName"];
//        _handelImg = [aDecoder decodeObjectForKey:@"handelImg"];
//        _isLogin = [aDecoder decodeObjectForKey:@"isLogin"];
//        _userId = [aDecoder decodeObjectForKey:@"userId"];
//        _userSex = [aDecoder decodeObjectForKey:@"userSex"];
//        _userPhone = [aDecoder decodeObjectForKey:@"userPhone"];
//        _nickname = [aDecoder decodeObjectForKey:@"nickname"];
//        _userLeval = [aDecoder decodeObjectForKey:@"userLeval"];
//
//        _deviceId = [aDecoder decodeObjectForKey:@"deviceId"];
//        _qqId = [aDecoder decodeObjectForKey:@"qqId"];
//        _regType = [aDecoder decodeObjectForKey:@"regType"];
//        _unionId = [aDecoder decodeObjectForKey:@"unionId"];
//        _userPwd = [aDecoder decodeObjectForKey:@"userPwd"];
//        _sid     =  [aDecoder decodeObjectForKey:@"sid"];
//        _waitCount = [aDecoder decodeObjectForKey:@"waitCount"];
//        _joinCount = [aDecoder decodeObjectForKey:@"joinCount"];
//        _releaseCount = [aDecoder decodeObjectForKey:@"releaseCount"];
//
//        _brand = [aDecoder decodeObjectForKey:@"brand"];
//        _model = [aDecoder decodeObjectForKey:@"model"];
//        _plateNumber = [aDecoder decodeObjectForKey:@"plateNumber"];
//        _engineNumber = [aDecoder decodeObjectForKey:@"engineNumber"];
//        _vin = [aDecoder decodeObjectForKey:@"vin"];
//        _birthYyyyMmDd = [aDecoder decodeObjectForKey:@"birthYyyyMmDd"];
//        _isUserVip = [aDecoder decodeObjectForKey:@"isUserVip"];
//
//        _vipBeginTime  = [aDecoder decodeObjectForKey:@"vipBeginTime"];
//        _vipEndTime  = [aDecoder decodeObjectForKey:@"vipEndTime"];
//
//        _inviteCode  = [aDecoder decodeObjectForKey:@"inviteCode"];
//        _userAitaScore  = [aDecoder decodeObjectForKey:@"userAitaScore"];


        unsigned  int outCount;
        Ivar * ivars = class_copyIvarList([self class], &outCount);
        for (int i = 0; i< outCount; i++) {
            Ivar ivar = ivars[i];
            NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
        free(ivars);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    
//    [aCoder encodeObject:_userName forKey:@"userName"];
//    [aCoder encodeObject:_handelImg forKey:@"handelImg"];
//    [aCoder encodeObject:_isLogin forKey:@"isLogin"];
//    [aCoder encodeObject:_userId forKey:@"userId"];
//    [aCoder encodeObject:_userSex forKey:@"userSex"];
//    [aCoder encodeObject:_userPhone forKey:@"userPhone"];
//    [aCoder encodeObject:_nickname forKey:@"nickname"];
//    [aCoder encodeObject:_userLeval forKey:@"userLeval"];
//
//    [aCoder encodeObject:_deviceId forKey:@"deviceId"];
//    [aCoder encodeObject:_qqId forKey:@"qqId"];
//    [aCoder encodeObject:_regType forKey:@"regType"];
//    [aCoder encodeObject:_unionId forKey:@"unionId"];
//    [aCoder encodeObject:_userPwd forKey:@"userPwd"];
//    [aCoder encodeObject:_sid forKey:@"sid"];
//    [aCoder encodeObject:_waitCount forKey:@"waitCount"];
//    [aCoder encodeObject:_joinCount forKey:@"joinCount"];
//    [aCoder encodeObject:_releaseCount forKey:@"releaseCount"];
//
//    [aCoder encodeObject:_brand forKey:@"brand"];
//    [aCoder encodeObject:_model forKey:@"model"];
//    [aCoder encodeObject:_plateNumber forKey:@"plateNumber"];
//    [aCoder encodeObject:_engineNumber forKey:@"engineNumber"];
//    [aCoder encodeObject:_vin forKey:@"vin"];
//    [aCoder encodeObject:_birthYyyyMmDd forKey:@"birthYyyyMmDd"];
//    [aCoder encodeObject:_isUserVip forKey:@"isUserVip"];
//    [aCoder encodeObject:_vipBeginTime forKey:@"vipBeginTime"];
//    [aCoder encodeObject:_vipEndTime forKey:@"vipEndTime"];
//
//    [aCoder encodeObject:_inviteCode forKey:@"inviteCode"];
//    [aCoder encodeObject:_userAitaScore forKey:@"userAitaScore"];

    unsigned int outCount;
    Ivar * ivars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i ++) {
        Ivar ivar = ivars[i];
        NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    free(ivars);
    
}
@end
