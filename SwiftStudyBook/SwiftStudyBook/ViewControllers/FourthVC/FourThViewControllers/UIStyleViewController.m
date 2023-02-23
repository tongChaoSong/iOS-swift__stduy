//
//  UIStyleViewController.m
//  SwiftStudyBook
//
//  Created by TCS on 2023/2/23.
//  Copyright © 2023 tcs. All rights reserved.
//

#import "UIStyleViewController.h"
#import "ScrollerLabel.h"
#import "ScrollerTwoLabe.h"

@interface UIStyleViewController ()
@property(nonatomic,strong)ScrollerLabel * sclabel;

@property (nonatomic, strong) ScrollerTwoLabe *labelScroll;

@end

@implementation UIStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

-(void)initView{
    self.sclabel = [[ScrollerLabel alloc] initWithFrame:CGRectMake(30, 100, self.view.frame.size.width-60, 44)];
    self.sclabel.backgroundColor = UIColor.whiteColor;
    [self.sclabel setTextArray:@[@"1.上岛咖啡就是看劳动法就是盛开的积分是劳动法",
                          @"2.SDK和索拉卡的附近是了的开发房贷",
                          @"3.收快递费就SDK废旧塑料的发三楼的靠近非塑料袋开发计算量大开发就"] InteralTime:2.0 Direction:SHRollingDirectionUp];
    self.sclabel.didSelect = ^(NSInteger index, NSString *text) {
        NSLog(@"---%ld----%@",index,text);
    };
    [self.view addSubview:self.sclabel];
    
    
    self.labelScroll = [[ScrollerTwoLabe alloc] initWithFrame:CGRectMake(30, 180, self.view.frame.size.width-60, 44)];
    [self.view addSubview:self.labelScroll];
    self.labelScroll.dataSource = [NSMutableArray arrayWithObjects:@"澳门", @"皇家",@"FBI",@"Warning",@"东京",@"热门",@"一拳超人", nil];
    [self.labelScroll showNext];
}
-(void)dealloc{
    [self.sclabel removGcdTimer];
    [self.labelScroll removeTimer];
    
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
