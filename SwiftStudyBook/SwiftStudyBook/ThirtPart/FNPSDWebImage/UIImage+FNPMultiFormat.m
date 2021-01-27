//
//  UIImage+FNPMultiFormat.m
//  SwiftStudyBook
//
//  Created by Apple on 2021/1/27.
//  Copyright © 2021 tcs. All rights reserved.
//

#import "UIImage+FNPMultiFormat.h"

#import "objc/runtime.h"
#import "FNPSDWebImageCodersManager.h"

@implementation UIImage (FNPMultiFormat)
#if SD_MAC
- (NSUInteger)sd_imageLoopCount {
    NSUInteger imageLoopCount = 0;
    for (NSImageRep *rep in self.representations) {
        if ([rep isKindOfClass:[NSBitmapImageRep class]]) {
            NSBitmapImageRep *bitmapRep = (NSBitmapImageRep *)rep;
            imageLoopCount = [[bitmapRep valueForProperty:NSImageLoopCount] unsignedIntegerValue];
            break;
        }
    }
    return imageLoopCount;
}

- (void)setSd_imageLoopCount:(NSUInteger)sd_imageLoopCount {
    for (NSImageRep *rep in self.representations) {
        if ([rep isKindOfClass:[NSBitmapImageRep class]]) {
            NSBitmapImageRep *bitmapRep = (NSBitmapImageRep *)rep;
            [bitmapRep setProperty:NSImageLoopCount withValue:@(sd_imageLoopCount)];
            break;
        }
    }
}

#else

- (NSUInteger)sd_imageLoopCount {
    NSUInteger imageLoopCount = 0;
    NSNumber *value = objc_getAssociatedObject(self, @selector(sd_imageLoopCount));
    if ([value isKindOfClass:[NSNumber class]]) {
        imageLoopCount = value.unsignedIntegerValue;
    }
    return imageLoopCount;
}

- (void)setSd_imageLoopCount:(NSUInteger)sd_imageLoopCount {
    NSNumber *value = @(sd_imageLoopCount);
    objc_setAssociatedObject(self, @selector(sd_imageLoopCount), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#endif

+ (nullable UIImage *)sd_imageWithData:(nullable NSData *)data {
    return [[FNPSDWebImageCodersManager sharedInstance] decodedImageWithData:data];
}

- (nullable NSData *)sd_imageData {
    return [self sd_imageDataAsFormat:FNPSDImageFormatUndefined];
}

- (nullable NSData *)sd_imageDataAsFormat:(FNPSDImageFormat)imageFormat {
    NSData *imageData = nil;
    if (self) {
        imageData = [[FNPSDWebImageCodersManager sharedInstance] encodedDataWithImage:self format:imageFormat];
    }
    return imageData;
}
@end
