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
@property (nonatomic, strong) dispatch_source_t gcdTimer;

@end

@implementation RuntimeViewController

-(void)dealloc{
    [self removGcdTimer];
}
- (void)viewDidLoad {

    [super viewDidLoad];
    [self initData];
    [self initTitle];
    // Do any additional setup after loading the view.
}
-(void)initData{
    
    
}
-(void)initTitle{
    self.mainTitleArr = @[@"清除数据",@"json-->model、消息转发机制",@"runtime-方式测试全局tab添加无数据图案",@"runtime-04实现自动解归档",@"runtime-万能界面跳转方法",@"打印成员变量",@"gcd定时器",@"iOS底层探究-alloc/init做了什么？https://www.jianshu.com/p/0a795b4b894d"];

    @WeakObj(self);
    self.mainTable.reloadBlock = ^{
        NSLog(@"无图新增刷新");
        selfWeak.mainTitleArr = @[@"清除数据",@"json-->model、消息转发机制",@"runtime-方式测试全局tab添加无数据图案",@"runtime-04实现自动解归档",@"runtime-万能界面跳转方法"];

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
        case 5:
        {
            [self printVal];
        }
            break;
        case 6:
        {
            [self initTimer];
            
//            [self pauseTimer];
//            [self removGcdTimer];
        }
            break;
        case 7:
        {
            NSLog(@"一句话概括就是alloc做了三件事1. cls->instanceSize(extraBytes);计算对象需要多大内存空间。2.调用calloc函数申请内存并返回内存的指针地址。3.obj->initInstanceIsa 将 cls类 与 obj指针（即isa） 关联。 init做了一件事就是返回当前对象。");
            // 这个规则肯定事先跟服务端沟通好，跳转对应的界面需要对应的参数
            NSDictionary *userInfo = @{
                @"class": @"BaseWkWebvc",
                @"property": @{
                    @"url": @"https://www.jianshu.com/p/0a795b4b894d",
                }
            };
            [self push:userInfo];
        }
            break;
            
        default:
            break;
    }
}
-(void)printVal{
    unsigned int count;
    Ivar* ivars = class_copyIvarList([UIPageControl class], &count);
    for (int i=0; i<count; i++) {
        Ivar ivar = ivars[i];
        NSString* name = [NSString stringWithUTF8String:ivar_getName(ivar)];    // 名称
        NSString* type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];     // 类型
        NSLog(@"成员变量：%@ -> 类型：%@",name,type);
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

- (void)initTimer {
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
        uint64_t interval = (uint64_t)(1 * NSEC_PER_SEC);
        // 设置timer，最后一个参数为leeway，是用来设置定时器的“期望精度值”，系统会根据这个值延迟或提前触发定时器
        dispatch_source_set_timer(_gcdTimer, start, interval, 0);
        // 设定timer的方法调用
        dispatch_source_set_event_handler(_gcdTimer, ^{
            // 如果timer的方法调用是UI方面相关的操作，需要在主线程中执行（线程间通信）
            dispatch_async(dispatch_get_main_queue(), ^{
//                [self changeLabelText];
                NSLog(@"开始计时了 ==");
            });
        });
        // 开启定时器
        dispatch_resume(_gcdTimer);
    }
}
//暂停
- (void)pauseTimer {
    if (_gcdTimer) {
        dispatch_suspend(_gcdTimer);
    }
}
//移除
-(void)removGcdTimer{
    if (_gcdTimer) {
        dispatch_source_cancel(_gcdTimer);
        _gcdTimer = nil;
    }
    
    
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
