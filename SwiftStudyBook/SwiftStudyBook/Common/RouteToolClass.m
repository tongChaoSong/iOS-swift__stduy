//
//  RouteToolClass.m
//  SwiftStudyBook
//
//  Created by 1998xxsq on 2023/5/26.
//  Copyright © 2023 tcs. All rights reserved.
//

#import "RouteToolClass.h"


@interface RouteToolClass ()
//@property (nonatomic,copy,nullable)TCSRouterBlock lhz_RouterBlock;


@end
@implementation RouteToolClass

//static char JZTCallBackBlockKey;

//+(void)setLhz_RouterBlock:(TCSRouterBlock)lhz_RouterBlock {
//    objc_setAssociatedObject(self, &JZTCallBackBlockKey, lhz_RouterBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//+(TCSRouterBlock)lhz_RouterBlock{
//    return objc_getAssociatedObject(self, &JZTCallBackBlockKey);
//}
+ (void)push:(NSDictionary *)params
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
+(UINavigationController*)getcurrentNavVc{
    // 获取导航控制器

    UITabBarController *tabVC = [self currentTtabarController];
    UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
    // 跳转到对应的控制器
//    [pushClassStance pushViewController:instance animated:YES];
    
    return pushClassStance;
}

+ (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
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
+(UITabBarController *)currentTtabarController
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    UIViewController *tabbarController = window.rootViewController;
    if ([tabbarController isKindOfClass:[UITabBarController class]]) {
        return (UITabBarController *)tabbarController;
    }
    return nil;
}

+(void)paramToVc:(UIViewController *) v param:(NSDictionary *)parameters{
    if (parameters) {
        unsigned int outCount = 0;
        objc_property_t * properties = class_copyPropertyList(v.class , &outCount);
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSString *key = [NSString stringWithUTF8String:property_getName(property)];
            NSString *param = parameters[key];
            if (param != nil) {
                [v setValue:param forKey:key];
            }
        }
    }
}
+(void)pushViewControllerName:(NSString * __nonnull)vcName {
    [self pushViewControllerName:vcName
                           param:nil
                        animated:YES
                     routerBlock:nil];
}
+(void)pushViewControllerName:(NSString * __nonnull)vcName
                     animated:(BOOL)animated {
    [self pushViewControllerName:vcName
                           param:nil
                        animated:animated
                     routerBlock:nil];
}
+(void)pushViewControllerName:(NSString * __nonnull)vcName
                        param:(NSDictionary *)aParam {
    [self pushViewControllerName:vcName
                           param:aParam
                        animated:YES
                     routerBlock:nil];
}
+(void)pushViewControllerName:(NSString * __nonnull)vcName
                        param:(NSDictionary * __nullable)aParam
                     animated:(BOOL)animated {
    [self pushViewControllerName:vcName
                           param:aParam
                        animated:animated
                     routerBlock:nil];
}
+(void)pushViewControllerName:(NSString *)vcName
                        param:(NSDictionary *)aParam
                  routerBlock:(TCSRouterBlock)routerBlock {
    [self routerViewControllerName:vcName
                             param:aParam
                        routerType:TCSRouterTypePush
                          animated:YES
                       routerBlock:routerBlock];
}


+(void)pushViewControllerName:(NSString *)vcName
                        param:(NSDictionary *)aParam
                     animated:(BOOL)animated
                  routerBlock:(TCSRouterBlock)routerBlock {
    [self routerViewControllerName:vcName
                             param:aParam
                        routerType:TCSRouterTypePush
                          animated:animated
                       routerBlock:routerBlock];
}
+(void)presentViewControllerName:(NSString *)vcName
                           param:(NSDictionary *)aParam
                        animated:(BOOL)animated
                     routerBlock:(TCSRouterBlock)routerBlock {
    [self routerViewControllerName:vcName
                             param:aParam
                        routerType:TCSRouterTypePresent
                          animated:animated
                       routerBlock:routerBlock];
}



+(void)routerViewControllerName:(NSString * __nonnull)vcName
                          param:(NSDictionary * __nullable)aParam
                     routerType:(TCSRouterType)rType
                       animated:(BOOL)animated
                    routerBlock:(TCSRouterBlock)routerBlock{
    //跳转
    //获取控制器
    Class cls = NSClassFromString(vcName);
    if (!cls) {
        return;
    }
    BaseOCVC *vc = [[cls alloc] init];
    //参数解析
    [self paramToVc:vc param:aParam];
    if ([self respondsToSelector:@selector(loadParam:)]) {
        [self loadParam:aParam];
    }
    if (rType == TCSRouterTypePush) {
//        if ([self isKindOfClass:[UINavigationController class]]) {
//            //当前控制器本身就是一个导航控制器
//            [(UINavigationController *)self pushViewController:vc animated:animated];
//        }else {
            //控制器存在堆栈中
//            if (self.navigationController) {
//                [self.navigationController pushViewController:vc animated:animated];
//            }
//        }
        [[self getcurrentNavVc] pushViewController:vc animated:animated];
        
    }else {
        
        [[self getcurrentNavVc] presentViewController:vc animated:animated completion:nil];
//        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
//        if ([self isKindOfClass:[UINavigationController class]]) {
//            //当前控制器本身就是一个导航控制器
//            [(UINavigationController *)self presentViewController:nav animated:animated completion:nil];
//        }else {
//            //控制器存在堆栈中
//            if (self.navigationController) {
//                [[self getcurrentNavVc] presentViewController:nav animated:animated completion:nil];
//            }else {
//                [[self getcurrentNavVc] presentViewController:nav animated:animated completion:nil];
//            }
//        }
    }
    if (routerBlock) {
        vc.tcs_RouterBlock = routerBlock;
//        [vc setTcs_RouterBlock:1];
//        [vc setLhz_RouterBlock:routerBlock];
    }
}
+(void)loadParam:(NSDictionary *)parameters{
    
}

@end
