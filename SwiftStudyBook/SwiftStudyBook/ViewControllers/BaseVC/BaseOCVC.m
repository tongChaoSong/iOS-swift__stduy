//
//  BaseOCVC.m
//  SwiftStudyBook
//
//  Created by Apple on 2020/8/19.
//  Copyright © 2020 tcs. All rights reserved.
//

#import "BaseOCVC.h"

@interface BaseOCVC ()

@end

@implementation BaseOCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
-(void)dealloc{
    
    NSLog(@"____当前vc已被释放____:)");
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
