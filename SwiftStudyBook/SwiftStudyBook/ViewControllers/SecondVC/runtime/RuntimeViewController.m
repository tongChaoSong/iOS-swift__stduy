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
@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self initTitle];
    // Do any additional setup after loading the view.
}

-(void)initTitle{
    self.mainTitleArr = @[@"json->model、消息转发机制",@"",@""];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"32435");
    switch (indexPath.row) {
        case 0:
        {
            Person * p = [[Person alloc]init];
            [p test];
        }
            break;
            
        case 1:
        {

            
        }
            break;
        
            
        default:
            break;
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
