//
//  BlockViewController.m
//  SwiftStudyBook
//
//  Created by Apple on 2021/9/16.
//  Copyright © 2021 tcs. All rights reserved.
//

#import "BlockViewController.h"
#import "Person.h"
@interface BlockViewController ()

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray * arr = @[@"block 获取自动变量情况下的变化",@"",@"",@""];
    self.navigationController.title = @"block 理解";
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
            NSString * str = @"name";
            static int val = 10;
            void (^blk)(void) = ^{
                NSLog(@"val=%d name ==%@",val,str);
                
            };
            val = 2;
            str = @"lala";
            blk();
            [self testExp];
        }
            break;
        case 1:
        {
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
int i = 1;  //全局变量
static int j = 2;  //静态全局变量
- (void)testExp {
    Person * p = [Person new];
    p.name = @"ale";
    __strong id k = self;  //对象类型的局部变量
    static int l = 3;   //静态局部变量
    int m = 4;  //基本数据类型的局部变量
    void(^testBlock)(void) = ^{
        NSLog(@"全局变量 i = %d", i);
        NSLog(@"静态全局变量 j = %d", j);
        NSLog(@"对象类型的局部变量 k = %@", k);
        NSLog(@"静态局部变量 l = %d", l);
        NSLog(@"基本数据类型的局部变量 m = %d", m);
        NSLog(@"personName = %@", p.name);

        p.name = @"suwan";
        NSLog(@"personNamesuwan = %@", p.name);

    };
    testBlock();
    NSLog(@"------再次赋值------");
    i = 11;
    j = 21;
    k = nil;
    l = 31;
    m = 41;
    p.name = @"tong";
    testBlock();
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
