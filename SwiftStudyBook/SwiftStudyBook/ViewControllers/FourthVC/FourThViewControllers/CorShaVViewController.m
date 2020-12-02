//
//  CorShaVViewController.m
//  SwiftStudyBook
//
//  Created by Apple on 2020/9/15.
//  Copyright © 2020 tcs. All rights reserved.
//

#import "CorShaVViewController.h"

@interface CorShaVViewController ()

@end

@implementation CorShaVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self radius];
    
    // Do any additional setup after loading the view.
}

-(void)radius{
    //阴影
    UIView * shadowView = [[UIView alloc]initWithFrame:CGRectMake(50, kApplicationStatusBarHeight + 100, SCREEN_WIDTH - 50 * 2, SCREEN_WIDTH - 50 * 2)];
    shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    shadowView.layer.shadowOffset = CGSizeMake(0, 0);
    
    shadowView.layer.shadowOpacity = 1;
    
    shadowView.layer.shadowRadius = 5.0;
    
    shadowView.layer.cornerRadius = shadowView.width/2;
    
    shadowView.clipsToBounds = NO;
    
    //圆角
    UIView * radView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, shadowView.width, shadowView.height)];
    radView.backgroundColor = [UIColor purpleColor];
    radView.layer.cornerRadius = shadowView.width/2;
    radView.layer.masksToBounds = YES;
    
    [shadowView addSubview:radView];
    [self.view addSubview:shadowView];
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
