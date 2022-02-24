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
@property(nonatomic,strong)UIButton * layerImageView;
@end

@implementation LayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self clayer];
    [self addView];
    [self drawText:CGRectMake(10, SCREEN_HEIGHT - 100, SCREEN_WIDTH - 20, 80)];
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
    TestViewContext * view = [[TestViewContext alloc]initWithFrame:CGRectMake(0, kApplicationStatusBarHeight, SCREEN_WIDTH, (SCREEN_HEIGHT - kApplicationStatusBarHeight)/2)];
    [view setNeedsLayout];
//    [view layoutIfNeeded];
//    [view layoutSubviews];
    [self.view addSubview:view];
}
-(void)addView{
    
    self.layerImageView = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 25, (SCREEN_HEIGHT - kApplicationStatusBarHeight)/2 + kApplicationStatusBarHeight + 50, 50, 50)];
    self.layerImageView.layer.cornerRadius = 8;
    self.layerImageView.layer.masksToBounds = YES;
    self.layerImageView.backgroundColor = [UIColor greenColor];
    [self.layerImageView addTarget:self action:@selector(moveTransform:) forControlEvents:UIControlEventTouchUpInside];
    [self.layerImageView setImage:[UIImage imageNamed:@"icon_xiaoma"] forState:UIControlStateNormal];
    [self.view addSubview:self.layerImageView];
    
}

-(void)moveTransform:(UIButton*)sender{
    
    
    if (sender.selected) {
        CGAffineTransform transform = CGAffineTransformIdentity;
        //scale by 50%
        transform = CGAffineTransformTranslate(transform, 0.5, 0.5);
        //rotate by 30 degrees
        transform = CGAffineTransformRotate(transform, M_PI / 180.0 );
        //translate by 200 points
        transform = CGAffineTransformTranslate(transform, 0, 0);
        
        [UIView animateWithDuration:0.5 animations:^{
                self.layerImageView.transform = transform;
            //    self.layerImageView.layer.affineTransform = transform;

        }];
    }else{
        //    先缩小50%，再旋转30度，最后向右移动200个像素（
        //create a new transform
        CGAffineTransform transform = CGAffineTransformIdentity;
        //scale by 50%
        transform = CGAffineTransformScale(transform, 0.5, 0.5);
        //rotate by 30 degrees
        transform = CGAffineTransformRotate(transform, M_PI / 180.0 * 30.0);
        //translate by 200 points
        transform = CGAffineTransformTranslate(transform, 200, 0);

        
//        CATransform3D transform3d = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
//        transform3d.m34 = - 1.0 / 500.0;
//
        [UIView animateWithDuration:0.5 animations:^{
            self.layerImageView.transform = transform;
            //    self.layerImageView.layer.affineTransform = transform;
            
//            if (@available(iOS 12.0, *)) {
//                self.layerImageView.transform3D = transform3d;
//            } else {
//                // Fallback on earlier versions
//            }
        }];
        
        

    }
    sender.selected =!sender.selected;

}

-(void)drawText:(CGRect)rect{

    NSString *str = @"姜灵凤姜灵凤姜灵凤姜灵凤姜灵凤姜灵凤姜灵凤姜灵凤";

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    //字体大小

    dict[NSFontAttributeName] = [UIFont systemFontOfSize:30];

    //设置颜色

    dict[NSForegroundColorAttributeName] = [UIColor greenColor];

    //设置描边

    dict[NSStrokeColorAttributeName] = [UIColor redColor];

    dict[NSStrokeWidthAttributeName] = @2;



    //设置阴影

    NSShadow*shadow = [[NSShadow alloc]init];

    shadow.shadowColor = [UIColor blueColor];

    //设置阴影偏移量

    shadow.shadowOffset=CGSizeMake(1,1);

    //设置阴影模糊度

    shadow.shadowBlurRadius = 2;

    dict[NSShadowAttributeName] = shadow;

    //[str drawAtPoint:CGPointMake(50, 50) withAttributes:dict];//不会自动换行

    //会自动换行

    [str drawInRect:rect withAttributes:dict];

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
