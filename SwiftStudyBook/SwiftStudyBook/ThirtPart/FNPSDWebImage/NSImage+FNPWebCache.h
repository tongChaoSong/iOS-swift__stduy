//
//  NSImage+FNPWebCache.h
//  SwiftStudyBook
//
//  Created by Apple on 2021/1/27.
//  Copyright © 2021 tcs. All rights reserved.
//
#import "FNPSDWebImageCompat.h"

#if SD_MAC
#import <Cocoa/Cocoa.h>



@interface NSImage (FNPWebCache)
- (CGImageRef)CGImage;
- (NSArray<NSImage *> *)images;
- (BOOL)isGIF;
@end
#endif

