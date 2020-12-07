//
//  Transfoem3DVC.m
//  SwiftStudyBook
//
//  Created by Apple on 2020/12/7.
//  Copyright © 2020 tcs. All rights reserved.
//
#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5
#import "Transfoem3DVC.h"
#import <QuartzCore/QuartzCore.h>
#import <GLKit/GLKit.h>
@interface Transfoem3DVC ()
@property (nonatomic, strong)  UIView *containerView;
@property (nonatomic, strong)  NSMutableArray *faces;

@end

@implementation Transfoem3DVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.containerView.backgroundColor = [UIColor grayColor];
    self.containerView.center = self.view.center;
    [self.view addSubview:self.containerView];
    
    self.faces = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 5; i++) {
        UILabel * labe = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 200, 200)];
//        UILabel * labe = [[UILabel alloc]init];

        labe.text = [NSString stringWithFormat:@"%d",i+1];
        labe.font = [UIFont systemFontOfSize:26];
        labe.textColor = [UIColor redColor];
        labe.textAlignment = NSTextAlignmentCenter;
        if (i %2 == 0) {
            labe.backgroundColor = [UIColor greenColor];
        }else{
            labe.backgroundColor = [UIColor yellowColor];
        }
        [self.faces addObject:labe];
    }
    //set up the container sublayer transform
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    //    self.containerView.layer.sublayerTransform = perspective;
    self.containerView.layer.sublayerTransform = perspective;
    //add cube face 1
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 100);
    [self addFace:0 withTransform:transform];
    //add cube face 2
    transform = CATransform3DMakeTranslation(100, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    //add cube face 3
    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    //add cube face 4
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    //add cube face 5
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    //add cube face 6
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
    // Do any additional setup after loading the view.
    
//    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
//    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
//    self.containerView.layer.sublayerTransform = perspective;

}
- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform
{
    //get the face view and add it to the container
    UIView *face = self.faces[index];
    [self.containerView addSubview:face];
    //center the face view within the container
    CGSize containerSize = self.containerView.bounds.size;
    face.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    // apply the transform
    face.layer.transform = transform;
    //apply lighting
    [self applyLightingToFace:face.layer];
}
- (void)applyLightingToFace:(CALayer *)face
{
    //add lighting layer
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    //译者注：GLKMatrix4和CATransform3D内存结构一致，但坐标类型有长度区别，所以理论上应该做一次float到CGFloat的转换，感谢[@zihuyishi](https://github.com/zihuyishi)同学~
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}
//

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
