//
//  UILabel+LeftTopAlign.m
//  一起自驾游
//
//  Created by apple-CXTX on 17/12/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UILabel+LeftTopAlign.h"

@implementation UILabel (LeftTopAlign)

- (void) textLeftTopAlignfont: (UIFont *)font
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName:font};
    
    CGSize labelSize = [self.text boundingRectWithSize:CGSizeMake(self.width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    if (labelSize.height > 40) {
        labelSize.height = 40;
    }
    
    CGRect dateFrame =CGRectMake(self.x,self.y , CGRectGetWidth(self.frame), labelSize.height);
    self.frame = dateFrame;
}

@end
