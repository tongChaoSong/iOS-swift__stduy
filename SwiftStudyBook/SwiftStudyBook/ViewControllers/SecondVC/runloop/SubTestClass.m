//
//  SubTestClass.m
//  SwiftStudyBook
//
//  Created by 1998xxsq on 2023/5/23.
//  Copyright © 2023 tcs. All rights reserved.
//

#import "SubTestClass.h"

@implementation SubTestClass
//对于[self class]来说,首先会被转化成objc_msgSend函数调用
//[super class]会被转化成objc_msgSendSuper函数调用，objc_msgSendSuper的参数虽然是super,
//但super结构体里面包的receiver是当前对象，所以这两个方法的接收者都是当前对象
//假如现在Phone,实例在8,初始化的时候,我们通过[self class]打印类信息
//会通过8的isa指针找到Phone的类对象14在这里寻找class方法,本身是没有的
//然后会通过superClass指针向上找,找到6号Mobile父类,他这里也没有class实现
//一直找到根类对象5号,也就是NSObject,有class实现,就会调用class具体实现
//返回给调用方，打印出来的就是Phone
//————————————————
//版权声明：本文为CSDN博主「ochenmengo」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
//原文链接：https://blog.csdn.net/ochenmengo/article/details/104943499
-(instancetype)init{
    if([super init]){
        
        NSLog(@"--%@",NSStringFromClass([self class]));
        NSLog(@"--%@",NSStringFromClass([super class]));

    }
    return self;
}
@end
