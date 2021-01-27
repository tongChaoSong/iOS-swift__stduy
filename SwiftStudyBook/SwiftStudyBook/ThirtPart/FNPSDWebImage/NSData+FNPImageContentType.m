
//
//  NSData+FNPImageContentType.m
//  SwiftStudyBook
//
//  Created by Apple on 2021/1/27.
//  Copyright © 2021 tcs. All rights reserved.
//

#import "NSData+FNPImageContentType.h"

#if SD_MAC
#import <CoreServices/CoreServices.h>
#else
#import <MobileCoreServices/MobileCoreServices.h>
#endif
// Currently Image/IO does not support WebP
#define kSDUTTypeWebP ((__bridge CFStringRef)@"public.webp")
// AVFileTypeHEIC is defined in AVFoundation via iOS 11, we use this without import AVFoundation
#define kSDUTTypeHEIC ((__bridge CFStringRef)@"public.heic")

@implementation NSData (FNPImageContentType)
+ (FNPSDImageFormat)sd_imageFormatForImageData:(nullable NSData *)data {
    if (!data) {
        return FNPSDImageFormatUndefined;
    }
    
    // File signatures table: http://www.garykessler.net/library/file_sigs.html
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return FNPSDImageFormatJPEG;
        case 0x89:
            return FNPSDImageFormatPNG;
        case 0x47:
            return FNPSDImageFormatGIF;
        case 0x49:
        case 0x4D:
            return FNPSDImageFormatTIFF;
        case 0x52: {
            if (data.length >= 12) {
                //RIFF....WEBP
                NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
                if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                    return FNPSDImageFormatWebP;
                }
            }
            break;
        }
        case 0x00: {
            if (data.length >= 12) {
                //....ftypheic ....ftypheix ....ftyphevc ....ftyphevx
                NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(4, 8)] encoding:NSASCIIStringEncoding];
                if ([testString isEqualToString:@"ftypheic"]
                    || [testString isEqualToString:@"ftypheix"]
                    || [testString isEqualToString:@"ftyphevc"]
                    || [testString isEqualToString:@"ftyphevx"]) {
                    return FNPSDImageFormatHEIC;
                }
            }
            break;
        }
    }
    return FNPSDImageFormatUndefined;
}

+ (nonnull CFStringRef)sd_UTTypeFromSDImageFormat:(FNPSDImageFormat)format {
    CFStringRef UTType;
    switch (format) {
        case FNPSDImageFormatJPEG:
            UTType = kUTTypeJPEG;
            break;
        case FNPSDImageFormatPNG:
            UTType = kUTTypePNG;
            break;
        case FNPSDImageFormatGIF:
            UTType = kUTTypeGIF;
            break;
        case FNPSDImageFormatTIFF:
            UTType = kUTTypeTIFF;
            break;
        case FNPSDImageFormatWebP:
            UTType = kSDUTTypeWebP;
            break;
        case FNPSDImageFormatHEIC:
            UTType = kSDUTTypeHEIC;
            break;
        default:
            // default is kUTTypePNG
            UTType = kUTTypePNG;
            break;
    }
    return UTType;
}
@end
