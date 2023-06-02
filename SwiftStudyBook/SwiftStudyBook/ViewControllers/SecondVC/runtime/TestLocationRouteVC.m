//
//  TestLocationRouteVC.m
//  SwiftStudyBook
//
//  Created by 1998xxsq on 2023/5/29.
//  Copyright © 2023 tcs. All rights reserved.
//

#import "TestLocationRouteVC.h"

@interface TestLocationRouteVC ()

@end

@implementation TestLocationRouteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"age==%@ maintitle==%@",self.age,self.maintitle];
    NSLog(@"age==%@ maintitle==%@",self.age,self.maintitle);
    // Do any additional setup after loading the view.
    self.mainTitleArr = @[@"1",@"2",@"3",@"5"];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tcs_RouterBlock) {
        self.tcs_RouterBlock(self.mainTitleArr[indexPath.row]);
    }
    if (indexPath.row == 0) {
        NSDictionary *userInfo = @{
            @"class": @"HSFeedsViewController",
            @"property": @{
                @"ID": @"123",
                @"type": @"12"
            }
        };
        [RouteToolClass push:userInfo];

    }else{
        [RouteToolClass pushViewControllerName:@"TestLocationRouteVC" param:@{@"age": @"123",@"maintitle": @"123"} animated:true routerBlock:^(id backData) {
            NSLog(@"111页面返回的值是==%@",backData);

        }];
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
