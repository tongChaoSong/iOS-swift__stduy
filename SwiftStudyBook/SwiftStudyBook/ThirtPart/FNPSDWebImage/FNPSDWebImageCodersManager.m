//
//  FNPSDWebImageCodersManager.m
//  SwiftStudyBook
//
//  Created by Apple on 2021/1/27.
//  Copyright © 2021 tcs. All rights reserved.
//

#import "FNPSDWebImageCodersManager.h"
#import "FNPSDWebImageImageIOCoder.h"
#import "FNPSDWebImageGIFCoder.h"
#ifdef SD_WEBP
#import "FNPSDWebImageWebPCoder.h"
#endif

@interface FNPSDWebImageCodersManager ()

@property (nonatomic, strong, nonnull) NSMutableArray<FNPSDWebImageCoder>* mutableCoders;
@property (SDDispatchQueueSetterSementics, nonatomic, nullable) dispatch_queue_t mutableCodersAccessQueue;

@end
@implementation FNPSDWebImageCodersManager
+ (nonnull instancetype)sharedInstance {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        // initialize with default coders
        _mutableCoders = [@[[FNPSDWebImageImageIOCoder sharedCoder]] mutableCopy];
#ifdef SD_WEBP
        [_mutableCoders addObject:[FNPSDWebImageWebPCoder sharedCoder]];
#endif
        _mutableCodersAccessQueue = dispatch_queue_create("com.hackemist.SDWebImageCodersManager", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)dealloc {
    SDDispatchQueueRelease(_mutableCodersAccessQueue);
}

#pragma mark - Coder IO operations

- (void)addCoder:(nonnull id<FNPSDWebImageCoder>)coder {
    if ([coder conformsToProtocol:@protocol(FNPSDWebImageCoder)]) {
        dispatch_barrier_sync(self.mutableCodersAccessQueue, ^{
            [self.mutableCoders addObject:coder];
        });
    }
}

- (void)removeCoder:(nonnull id<FNPSDWebImageCoder>)coder {
    dispatch_barrier_sync(self.mutableCodersAccessQueue, ^{
        [self.mutableCoders removeObject:coder];
    });
}

- (NSArray<FNPSDWebImageCoder> *)coders {
    __block NSArray<FNPSDWebImageCoder> *sortedCoders = nil;
    dispatch_sync(self.mutableCodersAccessQueue, ^{
        sortedCoders = (NSArray<FNPSDWebImageCoder> *)[[[self.mutableCoders copy] reverseObjectEnumerator] allObjects];
    });
    return sortedCoders;
}

- (void)setCoders:(NSArray<FNPSDWebImageCoder> *)coders {
    dispatch_barrier_sync(self.mutableCodersAccessQueue, ^{
        self.mutableCoders = [coders mutableCopy];
    });
}

#pragma mark - SDWebImageCoder
- (BOOL)canDecodeFromData:(NSData *)data {
    for (id<FNPSDWebImageCoder> coder in self.coders) {
        if ([coder canDecodeFromData:data]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)canEncodeToFormat:(FNPSDImageFormat)format {
    for (id<FNPSDWebImageCoder> coder in self.coders) {
        if ([coder canEncodeToFormat:format]) {
            return YES;
        }
    }
    return NO;
}

- (UIImage *)decodedImageWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    for (id<FNPSDWebImageCoder> coder in self.coders) {
        if ([coder canDecodeFromData:data]) {
            return [coder decodedImageWithData:data];
        }
    }
    return nil;
}

- (UIImage *)decompressedImageWithImage:(UIImage *)image
                                   data:(NSData *__autoreleasing  _Nullable *)data
                                options:(nullable NSDictionary<NSString*, NSObject*>*)optionsDict {
    if (!image) {
        return nil;
    }
    for (id<FNPSDWebImageCoder> coder in self.coders) {
        if ([coder canDecodeFromData:*data]) {
            return [coder decompressedImageWithImage:image data:data options:optionsDict];
        }
    }
    return nil;
}

- (NSData *)encodedDataWithImage:(UIImage *)image format:(FNPSDImageFormat)format {
    if (!image) {
        return nil;
    }
    for (id<FNPSDWebImageCoder> coder in self.coders) {
        if ([coder canEncodeToFormat:format]) {
            return [coder encodedDataWithImage:image format:format];
        }
    }
    return nil;
}
@end
