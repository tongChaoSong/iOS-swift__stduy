//
//  RunloopViewController.m
//  SwiftStudyBook
//
//  Created by Apple on 2021/10/28.
//  Copyright © 2021 tcs. All rights reserved.
//

#import "RunloopViewController.h"
#import "Person.h"
#import "TestClass.h"
#import "SubTestClass.h"

extern void _objc_autoreleasePoolPrint(void);
@interface RunloopViewController ()
@property(nonatomic,copy)NSString * name;
@end

@implementation RunloopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"---1----%ld", CFGetRetainCount((__bridge CFTypeRef)self));
    NSArray * arr = @[@"@autoreleasepool ",@"引用计数测试",@"类簇",@"测试内方法调用实例方法"];
    self.navigationController.title = @"runloop";
    // Do any additional setup after loading the view.
    self.mainTitleArr = arr;
    // Do any additional setup after loading the view.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
        {
            [self autorepool];
        }
            break;
        case 1:
        {
            [self addSunView];
        }
            break;
        case 2:
        {
            [self testArray];
            [self testDictionary];
            [self testString];
            
            NSDictionary *userInfo = @{
                @"class": @"BaseWkWebvc",
                @"property": @{
                    @"url": @"https://www.jianshu.com/p/86ef3ca9810d",
                }
            };
            
            [RouteToolClass push:userInfo];
        
        }
            break;
        case 3:
        {
//            [TestClass classtest];
//            [SubTestClass classtest];

            SubTestClass * cls = [[SubTestClass alloc]init];
            
            [cls classtest];
            
//            [cls init];
        }
            break;
            
        default:
            break;
    }
}

-(void)autorepool{
    
    @autoreleasepool {
        Person * p = [[Person alloc]init];
        Person * p2 = [[Person alloc]init];
        @autoreleasepool {
            Person * p3 = [[Person alloc]init];
            Person * p4 = [[Person alloc]init];
            NSLog(@"---2----%ld", CFGetRetainCount((__bridge CFTypeRef)self));

            _objc_autoreleasePoolPrint();
        }
        
    }
    
}

-(void)addSunView{
    
    NSLog(@"---view--1--%ld", CFGetRetainCount((__bridge CFTypeRef)self.view));

    UIButton * bt = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    NSLog(@"---3----%ld", CFGetRetainCount((__bridge CFTypeRef)bt));
    NSLog(@"---view--2--%ld", CFGetRetainCount((__bridge CFTypeRef)self.view));

    [self.view addSubview:bt];
    NSLog(@"---3.1.1----%ld", CFGetRetainCount((__bridge CFTypeRef)bt));
    NSLog(@"---view--3--%ld", CFGetRetainCount((__bridge CFTypeRef)self.view));

    UIView * aaa = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 30)];
    NSLog(@"---3.1----%ld", CFGetRetainCount((__bridge CFTypeRef)bt));
    NSLog(@"---3.1.2----%ld", CFGetRetainCount((__bridge CFTypeRef)aaa));

    [bt addSubview:aaa];
    NSLog(@"---3.2----%ld", CFGetRetainCount((__bridge CFTypeRef)bt));
    NSLog(@"---3.2.1----%ld", CFGetRetainCount((__bridge CFTypeRef)aaa));

    
    NSLog(@"---4----%ld", CFGetRetainCount((__bridge CFTypeRef)self.view));
    NSLog(@"---4.1----%ld", CFGetRetainCount((__bridge CFTypeRef)self));

//
//    Person * p = [[Person alloc]init];
//    NSLog(@"---5----%ld", CFGetRetainCount((__bridge CFTypeRef)p));
    self.name = @"ale";
//    NSLog(@"---6----%ld", CFGetRetainCount((__bridge CFTypeRef)self.name));

}

- (void)testArray {
    NSLog(@"--------------------------------------------------------------");
    NSArray *a1 = [NSArray alloc];
    NSArray *a2 = [[NSArray alloc] init];
    NSArray *a3 = [NSArray array];
    NSArray *a4 = [NSArray arrayWithObject:@"1"];
    NSArray *a5 = [NSArray arrayWithObjects:@"1",@"2",nil];
    NSLog(@"\na1:%@, \na2:%@, \na3:%@, \na4:%@, \na5:%@",[a1 class],[a2 class],[a3 class],[a4 class],[a5 class]);
    NSLog(@"-------------depart line--------------");
    
    NSMutableArray *m1 = [NSMutableArray alloc];
    NSMutableArray *m2 = [[NSMutableArray alloc] init];
    NSMutableArray *m3 = [NSMutableArray array];
    NSMutableArray *m4 = [NSMutableArray arrayWithObject:@"1"];
    NSMutableArray *m5 = [NSMutableArray arrayWithObjects:@"1",@"2",nil];
    NSMutableArray *m6 = a5.mutableCopy;
    NSLog(@"\nm1:%@, \nm2:%@, \nm3:%@, \nm4:%@, \nm5:%@, \nm6:%@",[m1 class],[m2 class],[m3 class],[m4 class],[m5 class],[m6 class]);
}

- (void)testDictionary {
    NSLog(@"--------------------------------------------------------------");
    NSDictionary *d1 = [NSDictionary alloc];
    NSDictionary *d2 = [[NSDictionary alloc] init];
    NSDictionary *d3 = [NSDictionary dictionary];
    NSDictionary *d4 = [NSDictionary dictionaryWithObject:@"value" forKey:@"key"];
    NSDictionary *d5 = @{@"k1":@"v1", @"k2":@"v2"};
    NSLog(@"\nd1:%@, \nd2:%@, \nd3:%@, \nd4:%@, \nd5:%@",[d1 class],[d2 class],[d3 class],[d4 class],[d5 class]);
    NSLog(@"-------------depart line--------------");
    
    NSMutableDictionary *md1 = [NSMutableDictionary alloc];
    NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *md3 = [NSMutableDictionary dictionaryWithObject:@"value" forKey:@"key"];
    NSMutableDictionary *md4 = [NSMutableDictionary dictionaryWithDictionary:d5];
    NSMutableDictionary *md5 = @{@"k1":@"v1", @"k2":@"v2"}.mutableCopy;
    NSLog(@"\nmd1:%@, \nmd2:%@, \nmd3:%@, \nmd4:%@, \nmd5:%@",[md1 class],[md2 class],[md3 class],[md4 class],[md5 class]);
    
}

- (void)testString {
    NSLog(@"--------------------------------------------------------------");
    NSString *s1 = [NSString alloc];
    NSString *s2 = [[NSString alloc] init];
    NSString *s3 = @"test";
    NSString *s4 = [NSString stringWithFormat:@"testforstringWithFormat"];
    NSString *s5 = [NSString stringWithUTF8String:"test"];
    NSString *s6 = [NSString stringWithUTF8String:"中文"];
    NSLog(@"\ns1:%@, \ns2:%@, \ns3:%@, \ns4:%@, \ns5:%@, \ns6:%@",[s1 class],[s2 class],[s3 class],[s4 class],[s5 class],[s6 class]);
    NSLog(@"-------------depart line--------------");
    
    /*
     care:s5的类型为：NSTaggedPointerString;而s6的类型为__NSCFString
     
     1、NSTaggedPointerString其父类是NSString
     
     2、__NSTaggedPointerString这个类型是标签指针字符串，这是苹果在 64 位环境下对 NSString,NSNumber 等对象做的一些优化。简单来讲可以理解为把指针指向的内容直接放在了指针变量的内存地址中,因为在 64 位环境下指针变量的大小达到了 8 位足以容纳一些长度较小的内容。于是使用了标签指针这种方式来优化数据的存储方式。从他的引用计数可以看出，这货也是一个释放不掉的单例常量对象。在运行时根据实际情况创建。
     
     3、对于 NSString 对象来讲，当非字面值常量的数字，英文字母字符串的长度小于等于 9 的时候会自动成为 NSTaggedPointerString 类型.如果有中文或其他特殊符号（可能是非 ASCII 字符）存在的话则会直接成为 ）__NSCFString 类型。这种对象被直接存储在指针的内容中，可以当作一种伪对象。（所以：s6的类型为__NSCFString）
     */
    
    NSMutableString *ms1 = [NSMutableString alloc];
    NSMutableString *ms2 = @"";
    NSMutableString *ms3 = [[NSMutableString alloc] init];
    NSMutableString *ms4 = [NSMutableString stringWithFormat:@"test"];
    NSLog(@"\nms1:%@, \nms2:%@, \nms3:%@, \nsm4:%@",[ms1 class],[ms2 class],[ms3 class],[ms4 class]);
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
