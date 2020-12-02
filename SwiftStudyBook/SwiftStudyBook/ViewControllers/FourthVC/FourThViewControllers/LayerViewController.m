//
//  LayerViewController.m
//  SwiftStudyBook
//
//  Created by Apple on 2020/12/2.
//  Copyright © 2020 tcs. All rights reserved.
//

#import "LayerViewController.h"
#import "TestViewContext.h"
@interface LayerViewController ()

@end

@implementation LayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self clayer];
    // Do any additional setup after loading the view.
}
-(void)clayer{
//    UIView * shadowView = [[UIView alloc]initWithFrame:CGRectMake(50, kApplicationStatusBarHeight + 100, SCREEN_WIDTH - 50 * 2, SCREEN_WIDTH - 50 * 2)];
//    shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
//
//    shadowView.layer.shadowOffset = CGSizeMake(0, 0);
//
//    shadowView.layer.shadowOpacity = 1;
//
//    shadowView.layer.shadowRadius = 5.0;
//
//    shadowView.layer.cornerRadius = shadowView.width/2;
//
//    shadowView.clipsToBounds = NO;
//    shadowView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@""].CGImage);
    TestViewContext * view = [[TestViewContext alloc]initWithFrame:CGRectMake(0, kApplicationStatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kApplicationStatusBarHeight)];
    [self.view addSubview:view];
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
