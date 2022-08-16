//
//  UILabel+BaseLabel.m
//  一起自驾游
//
//  Created by tcs on 18/10/19.
//  Copyright © 2018年 tcs. All rights reserved.
//

#import "UILabel+BaseLabel.h"

@implementation UILabel (BaseLabel)

- (id)initWithFrame:(CGRect)frame labelText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font {
    self = [super initWithFrame:frame];
    if (self) {
        self.text = text;
        self.textColor = textColor;
        self.font = font;
    }
    return self;
}


- (void)setLabelText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font {
    self.text = text;
    self.textColor = textColor;
    self.font = font;
}

@end
