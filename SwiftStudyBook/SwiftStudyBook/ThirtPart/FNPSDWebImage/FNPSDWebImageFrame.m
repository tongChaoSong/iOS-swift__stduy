


//
//  FNPSDWebImageFrame.m
//  SwiftStudyBook
//
//  Created by Apple on 2021/1/27.
//  Copyright © 2021 tcs. All rights reserved.
//

#import "FNPSDWebImageFrame.h"
@interface FNPSDWebImageFrame ()

@property (nonatomic, strong, readwrite, nonnull) UIImage *image;
@property (nonatomic, readwrite, assign) NSTimeInterval duration;

@end
@implementation FNPSDWebImageFrame
+ (instancetype)frameWithImage:(UIImage *)image duration:(NSTimeInterval)duration {
    FNPSDWebImageFrame *frame = [[FNPSDWebImageFrame alloc] init];
    frame.image = image;
    frame.duration = duration;
    
    return frame;
}
@end
