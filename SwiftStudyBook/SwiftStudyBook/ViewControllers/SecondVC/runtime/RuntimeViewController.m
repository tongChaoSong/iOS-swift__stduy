//
//  RuntimeViewController.m
//  SwiftStudyBook
//
//  Created by Apple on 2021/9/2.
//  Copyright © 2021 tcs. All rights reserved.
//

#import "RuntimeViewController.h"
#import "SwiftStudyBook-Swift.h"
#import "Person.h"
#import "LoginInfo.h"

@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self initData];
    [self initTitle];
    // Do any additional setup after loading the view.
}
-(void)initData{
    
    
}
-(void)initTitle{
    self.mainTitleArr = @[@"清除数据",@"json-->model、消息转发机制",@"runtime-方式测试全局tab添加无数据图案",@"runtime-04实现自动解归档",@"runtime-万能界面跳转方法"];

    @WeakObj(self);
    self.mainTable.reloadBlock = ^{
        NSLog(@"无图新增刷新");
        selfWeak.mainTitleArr = selfWeak.mainTitleArr;

    };
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:
        {
            self.mainTitleArr = [NSArray new];
        }
            break;
        case 1:
        {
            Person * p = [[Person alloc]init];
            [p test];
        }
            break;
            
        case 2:
        {
            
            self.mainTitleArr = [NSArray new];

        }
            break;
        case 3:
        {
            LoginInfo * log = [LoginInfo new];
            log.userName = @"ale";
            log.userSex = @"男";
            log.userId = @"10000";
            [ToolClass saveUserInfo:log];
            
            LoginInfo * log1 = [ToolClass readUserInfo];
            NSLog(@"lo==%@,",log1.userName);
            
        }
            break;
        case 4:
        {
            // 这个规则肯定事先跟服务端沟通好，跳转对应的界面需要对应的参数
            NSDictionary *userInfo = @{
                @"class": @"HSFeedsViewController",
                @"property": @{
                    @"ID": @"123",
                    @"type": @"12"
                }
            };
            [self push:userInfo];

            
        }
            break;
        default:
            break;
    }
}
- (void)push:(NSDictionary *)params
{
    // 类名
    NSString *class =[NSString stringWithFormat:@"%@", params[@"class"]];
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass)
    {
        // 创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        // 注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    // 创建对象
    id instance = [[newClass alloc] init];
    // 对该对象赋值属性
    NSDictionary * propertys = params[@"property"];
    [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 检测这个对象是否存在该属性
        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            // 利用kvc赋值
            [instance setValue:obj forKey:key];
        }
    }];

    // 获取导航控制器
//    UITabBarController *tabVC =  [UIApplication sharedApplication].keyWindow.rootViewController.tabBarController;
    UITabBarController *tabVC = [self currentTtabarController];
//    if (@available(iOS 13.0, *)) {
//        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        tabVC = (UITabBarController *)delegate.window.rootViewController;
//
//    } else {
//        // Fallback on earlier versions
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//        tabVC = (UITabBarController *)window.rootViewController;
//    }

//    [[ToolClass getCurrentRootVC].navigationController pushViewController:instance animated:YES];

//    [self.navigationController pushViewController:instance animated:YES];
    UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
    // 跳转到对应的控制器
    [pushClassStance pushViewController:instance animated:YES];
}

- (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    return NO;
}
-(UITabBarController *)currentTtabarController
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    UIViewController *tabbarController = window.rootViewController;
    if ([tabbarController isKindOfClass:[UITabBarController class]]) {
        return (UITabBarController *)tabbarController;
    }
    return nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
