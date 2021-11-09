//
//  RunloopViewController.m
//  SwiftStudyBook
//
//  Created by Apple on 2021/10/28.
//  Copyright © 2021 tcs. All rights reserved.
//

#import "RunloopViewController.h"
#import "Person.h"

extern void _objc_autoreleasePoolPrint(void);
@interface RunloopViewController ()
@property(nonatomic,copy)NSString * name;
@end

@implementation RunloopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"---1----%ld", CFGetRetainCount((__bridge CFTypeRef)self));
    NSArray * arr = @[@"@autoreleasepool ",@"引用计数测试",@"",@""];
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
            
        }
            break;
        case 3:
        {
            
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
