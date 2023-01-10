//
//  ImageWithBtn.m
//  1998demo
//
//  Created by TCS on 2023/1/10.
//  Copyright © 2023 TCS. All rights reserved.
//

#import "ImageWithBtn.h"
#import "UIButton+Ex.h"

@interface ImageWithBtn()

@property(nonatomic,strong)UIImageView * imageV;
@property(nonatomic,strong)UILabel * mainLab;

@end
@implementation ImageWithBtn

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, (self.height-30)/2, 30, 30)];
        self.imageV.layer.cornerRadius = self.imageV.height/2;
        self.imageV.layer.masksToBounds = true;
        
        
        self.mainLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageV.frame) + 7, 0, self.width - CGRectGetMaxX(self.imageV.frame), self.height)];
        self.mainLab.font = [UIFont boldSystemFontOfSize:12];
//        self.mainLab.textColor = toolClassColor(@"#333333");
        
        [self addSubview:self.imageV];
        [self addSubview:self.mainLab];

    
    }
    
    return self;
}

-(void)setMainTitle:(NSString *)mainTitle{
    _mainTitle = mainTitle;
    self.mainLab.text = mainTitle;
}
-(void)setImageStr:(NSString *)imageStr{
    _imageStr = imageStr;
    self.imageV.image = [UIImage imageNamed:imageStr];
}

-(void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"person_Defa"]];
}
-(void)setMainTitleFont:(UIFont *)mainTitleFont{
    _mainTitleFont = mainTitleFont;
    self.mainLab.font = mainTitleFont;

}
-(void)setMainTitleColor:(UIColor *)mainTitleColor{
    _mainTitleColor = mainTitleColor;
    self.mainLab.textColor = mainTitleColor;

}
-(instancetype)initWithFrame:(CGRect)frame withStyle:(ImageWithBtnStyle)style withImageSize:(CGSize)imageSize withMinLin:(CGFloat)minLin{
    if ([super initWithFrame:frame]) {
        CGSize imageVSize = imageSize;
        if (imageVSize.width && imageVSize.height) {
            imageVSize = CGSizeMake(30, 30);
        }
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, (self.height-30)/2, 30, 30)];
        self.imageV.layer.cornerRadius = self.imageV.height/2;
        self.imageV.layer.masksToBounds = true;
        
        
        self.mainLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageV.frame) + 7, 0, self.width - CGRectGetMaxX(self.imageV.frame), self.height)];
        self.mainLab.font = [UIFont boldSystemFontOfSize:12];
//        self.mainLab.textColor = toolClassColor(@"#333333");
        
        

//        ImageLeftLabelRight, // 图左 字右边
//        ImageRightLabelleft, // 图右边 字左边
//        ImageTopLabelBottom, // 图上子下
//        ImageBottomLabelTop, // 图下字上
        
        if (style == ImageLeftLabelRight) {
            self.imageV.frame = CGRectMake(0, (self.height-imageVSize.width)/2, imageVSize.width, imageVSize.height);
            self.mainLab.frame = CGRectMake(CGRectGetMaxX(self.imageV.frame) + minLin, 0, self.width - CGRectGetMaxX(self.imageV.frame), self.height);
        }else if (style == ImageRightLabelleft) {
            self.imageV.frame = CGRectMake(self.width - imageVSize.width, (self.height-imageVSize.width)/2, imageVSize.width, imageVSize.height);
            self.mainLab.frame = CGRectMake(0, 0, self.width - self.imageV.x - minLin, self.height);
            
        }else if (style == ImageTopLabelBottom) {
            self.imageV.frame = CGRectMake((self.width-imageVSize.width)/2, 0, imageVSize.width, imageVSize.height);
            self.mainLab.frame = CGRectMake(0, CGRectGetMaxY(self.imageV.frame) + minLin, self.width, self.height - CGRectGetMaxY(self.imageV.frame) - minLin);
            self.mainLab.textAlignment = NSTextAlignmentCenter;

        }else if (style == ImageBottomLabelTop) {
            
            self.imageV.frame = CGRectMake((self.width-imageVSize.width)/2, self.height - imageVSize.height , imageVSize.width, imageVSize.height);
            self.mainLab.frame = CGRectMake(0, 0, self.width, self.height - CGRectGetMaxY(self.imageV.frame) - minLin);
            self.mainLab.textAlignment = NSTextAlignmentCenter;
        }
    
        [self addSubview:self.imageV];
        [self addSubview:self.mainLab];
    }
    
    return self;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
