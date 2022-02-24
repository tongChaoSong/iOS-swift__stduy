//
//  CoreAnimationVC.m
//  SwiftStudyBook
//
//  Created by Apple on 2021/12/14.
//  Copyright © 2021 tcs. All rights reserved.
//

#import "CoreAnimationVC.h"

@interface CoreAnimationVC ()
@property(nonatomic,strong)UIButton * animationBtn;
@end

@implementation CoreAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animationBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.animationBtn.center = self.view.center;
    self.animationBtn.backgroundColor = [UIColor redColor];
    [self.animationBtn setImage:[UIImage imageNamed:@"icon_xiaoma"] forState:UIControlStateNormal];
    [self.animationBtn setTitle:@"小马" forState:UIControlStateNormal];
    [self.view addSubview:self.animationBtn];
    
    NSArray * arr = @[@"CABasicAnimation ",@"keyanimation",@"transitionAni",@"springAni",@"groupAni"];
//    self.navigationController.title = @"core Animation";
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
            [self animaton];
        }
            break;
        case 1:
        {
            [self keyanimation];
        }
            break;
        case 2:
        {
            [self transitionAni];
        }
            break;
        case 3:
        {
            [self springAni];
        }
            break;
        case 4:
        {
            [self groupAni];
        }
            break;
        case 5:
        {

        }
            break;
            
        default:
            break;
    }
}
- (void)animaton{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];//position属性发生动画
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 100)];//动画要去的点
    animation.duration = 2.0;//时间
    [self.animationBtn setImage:[UIImage imageNamed:@"icon_xiaoma"] forState:UIControlStateNormal];
    [self.animationBtn.layer addAnimation:animation forKey:@"weiyi" ];//添加动画  weiyi 是自定义的标识
}
- (void)keyanimation{
   CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, Nil, 0, 0);
    CGPathAddCurveToPoint(path, Nil, 300, 250, 300, 400, 0, 720);//设置路径
    CAKeyframeAnimation  * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path;//匹配路径
    animation.duration = 3.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.animationBtn setImage:[UIImage imageNamed:@"icon_xiaoma"] forState:UIControlStateNormal];
    [self.animationBtn.layer addAnimation:animation forKey:@"dddd"];
}
- (void)transitionAni {
    CATransition * ani = [CATransition animation];
    ani.type = kCATransitionFade;
    ani.subtype = kCATransitionFromLeft;
    ani.duration = 1.5;
    [self.animationBtn setImage:[UIImage imageNamed:@"icon_qq_pre1"] forState:UIControlStateNormal];

    [self.animationBtn.layer addAnimation:ani forKey:@"transitionAni"];
}
- (void)springAni {
    CASpringAnimation * ani = [CASpringAnimation animationWithKeyPath:@"bounds"];
    ani.mass = 10.0; //质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
    ani.stiffness = 5000; //刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快
    ani.damping = 100.0;//阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快 ani.initialVelocity = 5.f;//初始速率，动画视图的初始速度大小;速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
    ani.duration = ani.settlingDuration;
    ani.toValue = [NSValue valueWithCGRect:self.animationBtn.bounds];
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.animationBtn.layer addAnimation:ani forKey:@"boundsAni"];
    
}
- (void)groupAni {
    CABasicAnimation * posAni = [CABasicAnimation animationWithKeyPath:@"position"];
    posAni.toValue = [NSValue valueWithCGPoint:self.animationBtn.center]; CABasicAnimation * opcAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opcAni.toValue = [NSNumber numberWithFloat:1.0];
    opcAni.toValue = [NSNumber numberWithFloat:0.7];
    CABasicAnimation * bodAni = [CABasicAnimation animationWithKeyPath:@"bounds"];
    bodAni.toValue = [NSValue valueWithCGRect:self.animationBtn.bounds]; CAAnimationGroup * groupAni = [CAAnimationGroup animation]; groupAni.animations = @[posAni, opcAni, bodAni];
    groupAni.duration = 1.0;
    groupAni.fillMode = kCAFillModeForwards;
    groupAni.removedOnCompletion = NO;
    groupAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; [self.animationBtn.layer addAnimation:groupAni forKey:@"groupAni"];
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
