//
//  weakStudyVC.m
//  SwiftStudyBook
//
//  Created by Apple on 2020/8/19.
//  Copyright © 2020 tcs. All rights reserved.
//

#import "weakStudyVC.h"

@interface weakStudyVC ()

@end

@implementation weakStudyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * arr = @[@"weak 底层获取",@"",@"",@""];
    self.navigationController.title = @"weak 实现";
    // Do any additional setup after loading the view.
    self.mainTitleArr = arr;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewScrollPositionNone;
    switch (indexPath.row) {
        case 0:
        {
            [self weakObjcGet];
        }
            break;
        case 1:
        {
            GCDViewController * vc = [[GCDViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
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

-(void)weakObjcGet{
    id referent = [NSObject new];
    __weak id weakObj = referent;
    NSLog(@"weakObjcGet == %@", weakObj);
    
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
