//
//  CorShaVViewController.m
//  SwiftStudyBook
//
//  Created by Apple on 2020/9/15.
//  Copyright © 2020 tcs. All rights reserved.
//

#import "CorShaVViewController.h"
#import "UIColor+extend.h"
#import "MYCustumText.h"
@interface CorShaVViewController ()
@property(nonatomic,strong)CALayer* myLayer;

@property(nonatomic,strong)NSMutableArray* colorArray;
@property(nonatomic,strong)NSMutableArray* imageArray;

@property(nonatomic,strong)MYCustumText * mycust;
@end

@implementation CorShaVViewController
{
    //圆角
    UIView * radView;

    bool isSelet;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self radius];
    [self initLayer:nil];
    [self initMYCustumText];
    // Do any additional setup after loading the view.
}

-(void)initData{
    self.colorArray = [[NSMutableArray alloc]init];
    
    [self.colorArray addObject:[UIColor redColor]];
    [self.colorArray addObject:[UIColor purpleColor]];
    [self.colorArray addObject:[UIColor yellowColor]];
    [self.colorArray addObject:[UIColor grayColor]];
    [self.colorArray addObject:[UIColor blueColor]];
    
    self.imageArray = [[NSMutableArray alloc]init];
    [self.imageArray addObject:[UIImage imageNamed:@"icon_xiaoma"]];
    [self.imageArray addObject:[UIImage imageNamed:@"btn_pengyouquan"]];
    [self.imageArray addObject:[UIImage imageNamed:@"btn_location_4.0.9"]];
    
    
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
    
    radView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, shadowView.width, shadowView.height)];
    radView.backgroundColor = [UIColor purpleColor];
    radView.layer.cornerRadius = shadowView.width/2;
    radView.layer.masksToBounds = YES;
    
    [shadowView addSubview:radView];
    
    //手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(createCATransation)];
    [radView addGestureRecognizer:tap];
//    [self initLayer:radView];

    [self.view addSubview:shadowView];
}
-(void)initMYCustumText{
    self.mycust = [[MYCustumText alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT - 400, SCREEN_WIDTH - 20, 350)];
//    self.mycust = [[MYCustumText alloc]initWithFrame:CGRectMake(10, 88, SCREEN_WIDTH - 20, SCREEN_HEIGHT - 88 - 50)];

    self.mycust.backgroundColor = [UIColor grayColor];
    [self.mycust setNeedsLayout];
    [self.view addSubview:self.mycust];
    
}

-(void)closeCATransation{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction commit];
}
-(void)initLayer:(UIView*)view{
    
    //实例化自定义图层
    
    self.myLayer = [CALayer layer];
    
    if (view == nil) {
//        self.myLayer.frame = CGRectMake(100, 100, 100, 100);
        //设置大小
        [self.myLayer setBounds:CGRectMake(0, 0, 50, 50)];
        //设置背景颜色
        [self.myLayer setBackgroundColor:[UIColor redColor].CGColor];
        [self.myLayer setPosition:CGPointMake(100, 150)];
//        self.myLayer.anchorPoint = CGPointMake(40, 40);
        [self.view.layer addSublayer:self.myLayer];
    }else{
        //设置大小
        [self.myLayer setBounds:CGRectMake(20, 20, 50, 50)];
        //设置背景颜色
        [self.myLayer setBackgroundColor:[UIColor redColor].CGColor];
        [self.myLayer setPosition:CGPointMake(20, 20)];
        [view.layer addSublayer:self.myLayer];
    }
}

-(void)createCATransation{
    //    UITouch *touch = touches.anyObject;
    //    CGPoint location = [radView locationInView:self.view];
    CGPoint location = [radView convertPoint:radView.frame.origin toView:self.view];
    [self.myLayer setPosition:location];
    //颜色
    NSInteger r1 = arc4random_uniform(self.colorArray.count);
    [self.myLayer setBackgroundColor:[self.colorArray[r1] CGColor]];
    //透明度
    CGFloat alpha = (arc4random_uniform(5) + 1.0) / 10.0 + 0.5;
    [self.myLayer setOpacity:alpha];
    //尺寸
    NSInteger size = arc4random_uniform(50) + 51;
    [self.myLayer setBounds:CGRectMake(0, 0, size, size)];
    //圆角
    NSInteger r2 = arc4random_uniform(30);
    [self.myLayer setCornerRadius:r2];
    //旋转角度
    CGFloat angle = arc4random_uniform(180) /180.0 * M_PI;
    [self.myLayer setTransform:CATransform3DMakeRotation(angle, 0, 0, 1)];
    //设置content
    NSInteger r3 = arc4random_uniform(self.imageArray.count);
    UIImage *image = self.imageArray[r3];
    [self.myLayer setContents:(id)image.CGImage];
    NSLog(@"1111111");

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"dsdjksjfdsjf");
    
    if (!isSelet) {
        UITouch *touch = touches.anyObject;
        
        CGPoint location = [touch locationInView:self.view];
        //关闭动画
        //    [CATransaction begin];
        //    [CATransaction setDisableActions:YES];
        //    [CATransaction commit];
        //位置
        [self.myLayer setPosition:location];
        //颜色
        NSInteger r1 = arc4random_uniform(self.colorArray.count);
        [self.myLayer setBackgroundColor:[self.colorArray[r1] CGColor]];
        //透明度
        CGFloat alpha = (arc4random_uniform(5) + 1.0) / 10.0 + 0.5;
        [self.myLayer setOpacity:alpha];
        //尺寸
        NSInteger size = arc4random_uniform(50) + 51;
        [self.myLayer setBounds:CGRectMake(0, 0, size, size)];
        //圆角
        NSInteger r2 = arc4random_uniform(30);
        [self.myLayer setCornerRadius:r2];
        //旋转角度
        CGFloat angle = arc4random_uniform(180) /180.0 * M_PI;
        [self.myLayer setTransform:CATransform3DMakeRotation(angle, 0, 0, 1)];
        //设置content
        NSInteger r3 = arc4random_uniform(self.imageArray.count);
        UIImage *image = self.imageArray[r3];
        [self.myLayer setContents:(id)image.CGImage];
    }else{
        [self initLayer:nil];
    }
    
    isSelet = !isSelet;
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
