//
//  CopyVC.m
//  SwiftStudyBook
//
//  Created by Apple on 2020/8/20.
//  Copyright © 2020 tcs. All rights reserved.
//

#import "CopyVC.h"

@interface CopyVC ()

@end

@implementation CopyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)CopyStrong{
    /**
     不管是集合类对象（NSArray、NSDictionary、NSSet ... 之类的对象），还是非集合类对象（NSString, NSNumber ... 之类的对象），接收到copy和mutableCopy消息时，都遵循以下准则：
     1\. copy 返回的是不可变对象（immutableObject）；如果用copy返回值调用mutable对象的方法就会crash。
     2\. mutableCopy 返回的是可变对象（mutableObject）。
     
     一、非集合类对象的copy与mutableCopy
     在非集合类对象中，对不可变对象进行copy操作，是指针复制，mutableCopy操作是内容复制；
     对可变对象进行copy和mutableCopy都是内容复制。用代码简单表示如下：
     **/
    NSString *str = @"hello word!";
    NSString *strCopy = [str copy];// 指针复制，strCopy与str的地址一样
    NSMutableString *strMCopy = [str mutableCopy]; // 内容复制，strMCopy与str的地址不一样
    
    NSMutableString *mutableStr = [NSMutableString stringWithString: @"hello word!"];
    NSString *strCopy1 = [mutableStr copy]; // 内容复制
    NSMutableString *strMCopy1 = [mutableStr mutableCopy]; // 内容复制
    
    /**
     二、集合类对象的copy与mutableCopy (同上)
     在集合类对象中，对不可变对象进行copy操作，是指针复制，mutableCopy操作是内容复制；
     对可变对象进行copy和mutableCopy都是内容复制。但是：集合对象的内容复制仅限于对象本身，对集合内的对象元素仍然是指针复制。(即单层内容复制)
     */
    NSArray *arr = @[@[@"a", @"b"], @[@"c", @"d"]];
    NSArray *copyArr = [arr copy]; // 指针复制
    NSMutableArray *mCopyArr = [arr mutableCopy]; //单层内容复制
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:[NSMutableString stringWithString:@"a"],@"b",@"c",nil];
    NSArray *copyArr1 = [array copy]; // 单层内容复制
    NSMutableArray *mCopyArr1 = [array mutableCopy]; // 单层内容复制
    
    //【总结一句话】：只有对不可变对象进行copy操作是指针复制（浅复制），其它情况都是内容复制（深复制）！复制代码
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
