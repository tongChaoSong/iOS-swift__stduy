//
//  UILabel+BaseLabel.h
//  一起自驾游
//
//  Created by tcs on 18/10/19.
//  Copyright © 2018年 tcs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (BaseLabel)

- (id)initWithFrame:(CGRect)frame labelText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font;

- (void)setLabelText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font;

@end
