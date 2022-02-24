//
//  LayNeedView.m
//  SwiftStudyBook
//
//  Created by Apple on 2022/2/21.
//  Copyright © 2022 tcs. All rights reserved.
//

#import "LayNeedView.h"

@implementation LayNeedView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        NSLog(@"LayIfneedViewController== initWithFrame");

    }
    return self;
}
//-(void)drawRect:(CGRect)rect{
//    NSLog(@"LayIfneedViewController== drawRect");
//}

-(void)layoutIfNeeded{
    NSLog(@"LayIfneedViewController== layoutIfNeeded");
}

-(void)setNeedsLayout{
    NSLog(@"LayIfneedViewController== setNeedsLayout");
}
-(void)setNeedsDisplay{
    NSLog(@"LayIfneedViewController== setNeedsDisplay");
}
-(void)layoutSubviews{
    NSLog(@"LayIfneedViewController== layoutSubviews");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
