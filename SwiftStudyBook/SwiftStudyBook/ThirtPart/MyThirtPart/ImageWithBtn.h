//
//  ImageWithBtn.h
//  1998demo
//
//  Created by TCS on 2023/1/10.
//  Copyright © 2023 TCS. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ImageWithBtnStyle) {
    ImageLeftLabelRight, // 图左 字右边
    ImageRightLabelleft, // 图右边 字左边
    ImageTopLabelBottom, // 图上子下
    ImageBottomLabelTop, // 图下字上

};

@interface ImageWithBtn : UIButton
@property(nonatomic,strong)NSString * mainTitle;
@property(nonatomic,strong)UIFont * mainTitleFont;
@property(nonatomic,strong)UIColor * mainTitleColor;

@property(nonatomic,strong)NSString * imageUrl;

@property(nonatomic,strong)NSString * imageStr;


-(instancetype)initWithFrame:(CGRect)frame withStyle:(ImageWithBtnStyle)style withImageSize:(CGSize)imageSize withMinLin:(CGFloat)minLin;
@end

NS_ASSUME_NONNULL_END
