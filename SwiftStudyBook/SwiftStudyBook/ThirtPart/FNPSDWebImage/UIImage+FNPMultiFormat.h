//
//  UIImage+FNPMultiFormat.h
//  SwiftStudyBook
//
//  Created by Apple on 2021/1/27.
//  Copyright © 2021 tcs. All rights reserved.
//


#import "FNPSDWebImageCompat.h"
#import "NSData+FNPImageContentType.h"
@interface UIImage (FNPMultiFormat)
/**
 * UIKit:
 * For static image format, this value is always 0.
 * For animated image format, 0 means infinite looping.
 * Note that because of the limitations of categories this property can get out of sync if you create another instance with CGImage or other methods.
 * AppKit:
 * NSImage currently only support animated via GIF imageRep unlike UIImage.
 * The getter of this property will get the loop count from GIF imageRep
 * The setter of this property will set the loop count from GIF imageRep
 */
@property (nonatomic, assign) NSUInteger sd_imageLoopCount;

+ (nullable UIImage *)sd_imageWithData:(nullable NSData *)data;
- (nullable NSData *)sd_imageData;
- (nullable NSData *)sd_imageDataAsFormat:(FNPSDImageFormat)imageFormat;

@end

