//
//  ToolClass.m
//  SwiftStudyBook
//
//  Created by TCS on 2022/9/15.
//  Copyright © 2022 tcs. All rights reserved.
//

#import "ToolClass.h"
#import "NSDictionary+DIcLog.h"
@implementation ToolClass

+(void)createPropetyCode:(NSDictionary*)dict{
    
    NSArray * arr = @[@"我的",@"他的"];
    NSString * nameStr = @"TCS";
    NSDictionary * peDict = @{@"keyName":@"阿乐",@"keyAge":@"18"};
    NSMutableDictionary * dadict = [NSMutableDictionary dictionaryWithCapacity:10];
    [dadict setValue:arr forKey:@"Arr"];
    [dadict setValue:nameStr forKey:@"nameStr"];
    [dadict setValue:peDict forKey:@"peDict"];
    [dadict setValue:dict forKey:@"dict"];

    [dadict createPropetyCode];
    
    
}

+ (void)saveUserInfo: (LoginInfo *)userInfo {
    
    NSString *path = [NSString stringWithFormat:@"%@/userInfo",FilePath];
    
    [NSKeyedArchiver archiveRootObject:userInfo toFile:path];
    
}
+ (void)removeUserInfo:(LoginInfo *)userInfo {
    
    NSString *path = [NSString stringWithFormat:@"%@/userInfo",FilePath];
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    
    if ([defaultManager isDeletableFileAtPath:path]) {
        
        [defaultManager removeItemAtPath:path error:nil];
    }
}
+ (LoginInfo *)readUserInfo {
    
    NSString *path = [NSString stringWithFormat:@"%@/userInfo",FilePath];
    
    LoginInfo *userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    return userInfo;
    
}
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentRootVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;

    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];

    return currentVC;
}
+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;

    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的

        rootVC = [rootVC presentedViewController];
    }

    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController

        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];

    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController

        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];

    }
    else {
        // 根视图为非导航类

        currentVC = rootVC;
    }

    return currentVC;
}
@end
