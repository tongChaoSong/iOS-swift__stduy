//
//  NSData+FNPImageContentType.h
//  SwiftStudyBook
//
//  Created by Apple on 2021/1/27.
//  Copyright © 2021 tcs. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "FNPSDWebImageCompat.h"

typedef NS_ENUM(NSInteger, FNPSDImageFormat) {
    FNPSDImageFormatUndefined = -1,
    FNPSDImageFormatJPEG = 0,
    FNPSDImageFormatPNG,
    FNPSDImageFormatGIF,
    FNPSDImageFormatTIFF,
    FNPSDImageFormatWebP,
    FNPSDImageFormatHEIC
};
@interface NSData (FNPImageContentType)

/**
 *  Return image format
 *
 *  @param data the input image data
 *
 *  @return the image format as `SDImageFormat` (enum)
 */
+ (FNPSDImageFormat)sd_imageFormatForImageData:(nullable NSData *)data;

/**
 Convert SDImageFormat to UTType

 @param format Format as SDImageFormat
 @return The UTType as CFStringRef
 */
+ (nonnull CFStringRef)sd_UTTypeFromSDImageFormat:(FNPSDImageFormat)format;
@end

