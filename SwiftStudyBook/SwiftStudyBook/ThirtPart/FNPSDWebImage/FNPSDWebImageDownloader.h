//
//  FNPSDWebImageDownloader.h
//  SwiftStudyBook
//
//  Created by Apple on 2021/1/27.
//  Copyright © 2021 tcs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNPSDWebImageCompat.h"
#import "FNPSDWebImageOperation.h"
typedef NS_OPTIONS(NSUInteger, FNPSDWebImageDownloaderOptions) {
    FNPSDWebImageDownloaderLowPriority = 1 << 0,
    FNPSDWebImageDownloaderProgressiveDownload = 1 << 1,

    /**
     * By default, request prevent the use of NSURLCache. With this flag, NSURLCache
     * is used with default policies.
     */
    FNPSDWebImageDownloaderUseNSURLCache = 1 << 2,

    /**
     * Call completion block with nil image/imageData if the image was read from NSURLCache
     * (to be combined with `SDWebImageDownloaderUseNSURLCache`).
     */
    FNPSDWebImageDownloaderIgnoreCachedResponse = 1 << 3,
    
    /**
     * In iOS 4+, continue the download of the image if the app goes to background. This is achieved by asking the system for
     * extra time in background to let the request finish. If the background task expires the operation will be cancelled.
     */
    FNPSDWebImageDownloaderContinueInBackground = 1 << 4,

    /**
     * Handles cookies stored in NSHTTPCookieStore by setting
     * NSMutableURLRequest.HTTPShouldHandleCookies = YES;
     */
    FNPSDWebImageDownloaderHandleCookies = 1 << 5,

    /**
     * Enable to allow untrusted SSL certificates.
     * Useful for testing purposes. Use with caution in production.
     */
    FNPSDWebImageDownloaderAllowInvalidSSLCertificates = 1 << 6,

    /**
     * Put the image in the high priority queue.
     */
    FNPSDWebImageDownloaderHighPriority = 1 << 7,
    
    /**
     * Scale down the image
     */
    FNPSDWebImageDownloaderScaleDownLargeImages = 1 << 8,
};

typedef NS_ENUM(NSInteger, FNPSDWebImageDownloaderExecutionOrder) {
    /**
     * Default value. All download operations will execute in queue style (first-in-first-out).
     */
    FNPSDWebImageDownloaderFIFOExecutionOrder,

    /**
     * All download operations will execute in stack style (last-in-first-out).
     */
    FNPSDWebImageDownloaderLIFOExecutionOrder
};

FOUNDATION_EXPORT NSString * _Nonnull const FNPSDWebImageDownloadStartNotification;
FOUNDATION_EXPORT NSString * _Nonnull const FNPSDWebImageDownloadStopNotification;

typedef void(^FNPSDWebImageDownloaderProgressBlock)(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL);

typedef void(^FNPSDWebImageDownloaderCompletedBlock)(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished);

typedef NSDictionary<NSString *, NSString *> FNPSDHTTPHeadersDictionary;
typedef NSMutableDictionary<NSString *, NSString *> FNPSDHTTPHeadersMutableDictionary;

typedef FNPSDHTTPHeadersDictionary * _Nullable (^FNPSDWebImageDownloaderHeadersFilterBlock)(NSURL * _Nullable url, FNPSDHTTPHeadersDictionary * _Nullable headers);

/**
 *  A token associated with each download. Can be used to cancel a download
 */
@interface FNPSDWebImageDownloadToken : NSObject

@property (nonatomic, strong, nullable) NSURL *url;
@property (nonatomic, strong, nullable) id downloadOperationCancelToken;

@end
@interface FNPSDWebImageDownloader : NSObject


/**
 * Decompressing images that are downloaded and cached can improve performance but can consume lot of memory.
 * Defaults to YES. Set this to NO if you are experiencing a crash due to excessive memory consumption.
 */
@property (assign, nonatomic) BOOL shouldDecompressImages;

/**
 *  The maximum number of concurrent downloads
 */
@property (assign, nonatomic) NSInteger maxConcurrentDownloads;

/**
 * Shows the current amount of downloads that still need to be downloaded
 */
@property (readonly, nonatomic) NSUInteger currentDownloadCount;

/**
 *  The timeout value (in seconds) for the download operation. Default: 15.0.
 */
@property (assign, nonatomic) NSTimeInterval downloadTimeout;

/**
 * The configuration in use by the internal NSURLSession.
 * Mutating this object directly has no effect.
 *
 * @see createNewSessionWithConfiguration:
 */
@property (readonly, nonatomic, nonnull) NSURLSessionConfiguration *sessionConfiguration;


/**
 * Changes download operations execution order. Default value is `SDWebImageDownloaderFIFOExecutionOrder`.
 */
@property (assign, nonatomic) FNPSDWebImageDownloaderExecutionOrder executionOrder;

/**
 *  Singleton method, returns the shared instance
 *
 *  @return global shared instance of downloader class
 */
+ (nonnull instancetype)sharedDownloader;

/**
 *  Set the default URL credential to be set for request operations.
 */
@property (strong, nonatomic, nullable) NSURLCredential *urlCredential;

/**
 * Set username
 */
@property (strong, nonatomic, nullable) NSString *username;

/**
 * Set password
 */
@property (strong, nonatomic, nullable) NSString *password;

/**
 * Set filter to pick headers for downloading image HTTP request.
 *
 * This block will be invoked for each downloading image request, returned
 * NSDictionary will be used as headers in corresponding HTTP request.
 */
@property (nonatomic, copy, nullable) FNPSDWebImageDownloaderHeadersFilterBlock headersFilter;

/**
 * Creates an instance of a downloader with specified session configuration.
 * *Note*: `timeoutIntervalForRequest` is going to be overwritten.
 * @return new instance of downloader class
 */
- (nonnull instancetype)initWithSessionConfiguration:(nullable NSURLSessionConfiguration *)sessionConfiguration NS_DESIGNATED_INITIALIZER;

/**
 * Set a value for a HTTP header to be appended to each download HTTP request.
 *
 * @param value The value for the header field. Use `nil` value to remove the header.
 * @param field The name of the header field to set.
 */
- (void)setValue:(nullable NSString *)value forHTTPHeaderField:(nullable NSString *)field;

/**
 * Returns the value of the specified HTTP header field.
 *
 * @return The value associated with the header field field, or `nil` if there is no corresponding header field.
 */
- (nullable NSString *)valueForHTTPHeaderField:(nullable NSString *)field;

/**
 * Sets a subclass of `SDWebImageDownloaderOperation` as the default
 * `NSOperation` to be used each time SDWebImage constructs a request
 * operation to download an image.
 *
 * @param operationClass The subclass of `SDWebImageDownloaderOperation` to set
 *        as default. Passing `nil` will revert to `SDWebImageDownloaderOperation`.
 */
- (void)setOperationClass:(nullable Class)operationClass;

/**
 * Creates a SDWebImageDownloader async downloader instance with a given URL
 *
 * The delegate will be informed when the image is finish downloaded or an error has happen.
 *
 * @see SDWebImageDownloaderDelegate
 *
 * @param url            The URL to the image to download
 * @param options        The options to be used for this download
 * @param progressBlock  A block called repeatedly while the image is downloading
 *                       @note the progress block is executed on a background queue
 * @param completedBlock A block called once the download is completed.
 *                       If the download succeeded, the image parameter is set, in case of error,
 *                       error parameter is set with the error. The last parameter is always YES
 *                       if SDWebImageDownloaderProgressiveDownload isn't use. With the
 *                       SDWebImageDownloaderProgressiveDownload option, this block is called
 *                       repeatedly with the partial image object and the finished argument set to NO
 *                       before to be called a last time with the full image and finished argument
 *                       set to YES. In case of error, the finished argument is always YES.
 *
 * @return A token (SDWebImageDownloadToken) that can be passed to -cancel: to cancel this operation
 */
- (nullable FNPSDWebImageDownloadToken *)downloadImageWithURL:(nullable NSURL *)url
                                                   options:(FNPSDWebImageDownloaderOptions)options
                                                  progress:(nullable FNPSDWebImageDownloaderProgressBlock)progressBlock
                                                 completed:(nullable FNPSDWebImageDownloaderCompletedBlock)completedBlock;

/**
 * Cancels a download that was previously queued using -downloadImageWithURL:options:progress:completed:
 *
 * @param token The token received from -downloadImageWithURL:options:progress:completed: that should be canceled.
 */
- (void)cancel:(nullable FNPSDWebImageDownloadToken *)token;

/**
 * Sets the download queue suspension state
 */
- (void)setSuspended:(BOOL)suspended;

/**
 * Cancels all download operations in the queue
 */
- (void)cancelAllDownloads;

/**
 * Forces SDWebImageDownloader to create and use a new NSURLSession that is
 * initialized with the given configuration.
 * *Note*: All existing download operations in the queue will be cancelled.
 * *Note*: `timeoutIntervalForRequest` is going to be overwritten.
 *
 * @param sessionConfiguration The configuration to use for the new NSURLSession
 */
- (void)createNewSessionWithConfiguration:(nonnull NSURLSessionConfiguration *)sessionConfiguration;
@end

